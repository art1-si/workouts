import 'package:workouts/data/clients/workouts_http_client/exceptions/api_context_exceptions.dart';
import 'package:workouts/data/clients/workouts_http_client/network_storage.dart';

typedef JwtAccessTokens = (String accessToken, String refreshToken);

class ApiContext {
  ApiContext._internal({
    required this.networkClientStorage,
    required this.baseUrl,
    this.jwtAccessTokens,
  });

  final NetworkClientStorage networkClientStorage;
  final String baseUrl;
  final JwtAccessTokens? jwtAccessTokens;

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

  static Future<void> load() async {
    final storage = await NetworkClientStorage.instance();
    final baseUrl = storage.getString(_apiBaseUrlKey);
    if (baseUrl == null) {
      throw const BaseUrlNotFoundException();
    }
    final jwtAccessTokens = await storage.getSecret(_jwtAccessToken);
    final jwtRefreshToken = await storage.getSecret(_jwtRefreshToken);

    _instance = ApiContext._internal(
      networkClientStorage: storage,
      baseUrl: baseUrl,
      jwtAccessTokens: jwtAccessTokens != null && jwtRefreshToken != null ? (jwtAccessTokens, jwtRefreshToken) : null,
    );
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
}
