import 'package:workouts/data/clients/workouts_http_client/exceptions/api_context_exceptions.dart';
import 'package:workouts/data/clients/workouts_http_client/network_storage.dart';

typedef JwtAccessTokens = ({String accessToken, String refreshToken});

class ApiContext {
  ApiContext._internal({
    required this.networkClientStorage,
    required this.baseUrl,
    this.jwtAccessTokens,
  });

  final NetworkClientStorage networkClientStorage;
  final String baseUrl;
  JwtAccessTokens? jwtAccessTokens;

  static ApiContext? _instance;

  static const _apiBaseUrlKey = 'api_base_url';
  static const _jwtAccessToken = 'jwt_access_token';
  static const _jwtRefreshToken = 'jwt_refresh_token';

  static ApiContext get instance {
    if (_instance == null) {
      throw const UninitiatedApiContextException();
    }
    return _instance!;
  }

  static Future<void> createIfNotExist({
    required String baseUrl,
    JwtAccessTokens? jwtAccessTokens,
  }) async {
    if (_instance != null) {
      return;
    }
    final storedInstance = await _loadStoredInstance();
    if (storedInstance != null) {
      _instance = storedInstance;
      return;
    }

    final storage = await NetworkClientStorage.instance();
    await storage.setString(_apiBaseUrlKey, baseUrl);
    if (jwtAccessTokens != null) {
      await storage.setSecret(_jwtAccessToken, jwtAccessTokens.accessToken);
      await storage.setSecret(_jwtRefreshToken, jwtAccessTokens.refreshToken);
    }

    _instance = ApiContext._internal(
      networkClientStorage: storage,
      baseUrl: baseUrl,
      jwtAccessTokens: jwtAccessTokens,
    );
  }

  static Future<ApiContext?> _loadStoredInstance() async {
    final storage = await NetworkClientStorage.instance();
    final baseUrl = storage.getString(_apiBaseUrlKey);
    if (baseUrl == null) {
      return null;
    }
    final jwtAccessTokens = await storage.getSecret(_jwtAccessToken);
    final jwtRefreshToken = await storage.getSecret(_jwtRefreshToken);

    return ApiContext._internal(
      networkClientStorage: storage,
      baseUrl: baseUrl,
      jwtAccessTokens: jwtAccessTokens != null && jwtRefreshToken != null
          ? (accessToken: jwtAccessTokens, refreshToken: jwtRefreshToken)
          : null,
    );
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await networkClientStorage.setSecret(_jwtAccessToken, accessToken);
    await networkClientStorage.setSecret(_jwtRefreshToken, refreshToken);

    jwtAccessTokens = (accessToken: accessToken, refreshToken: refreshToken);
  }

  /// Obtains the request host, stripping it from any
  /// illegal components.
  String get host {
    var host = baseUrl;
    host = _sanitizeHost(host);
    return host;
  }

  /// Sanitizes the host by removing any illegal components.
  ///
  /// If [stripPath] is set to true, the path will be stripped.
  String _sanitizeHost(String host, {bool stripPath = true}) {
    if (host.startsWith('https://')) {
      host = host.substring(8);
    }
    if (host.startsWith('http://')) {
      host = host.substring(7);
    }
    if (host.contains('/') && stripPath) {
      final firstIndexOfSlash = host.indexOf('/');
      host = host.substring(0, firstIndexOfSlash);
    }
    return host;
  }

  String? get pathPrefix {
    final hostWithPath = _sanitizeHost(baseUrl, stripPath: false);
    final sanitizedHost = _sanitizeHost(baseUrl, stripPath: true);
    var pathPrefix = hostWithPath.substring(sanitizedHost.length);
    if (pathPrefix.startsWith('/')) {
      pathPrefix = pathPrefix.substring(1);
    }
    return pathPrefix;
  }

  bool hasTokens() => jwtAccessTokens != null;

  Future<void> clearTokens() async {
    jwtAccessTokens = null;
    await networkClientStorage.removeSecret(_jwtAccessToken);
    await networkClientStorage.removeSecret(_jwtRefreshToken);
  }
}
