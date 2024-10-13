import 'package:workouts/data/clients/workouts_http_client/api_context.dart';
import 'package:workouts/data/clients/workouts_http_client/models/forbidden_middleware.dart';
import 'package:workouts/data/data_sources/authentication_data_source/authentication_data_source.dart';
import 'package:workouts/data/data_sources/authentication_data_source/authentication_remote_data_source/api_requests/refresh_token_request.dart';
import 'package:workouts/data/data_sources/authentication_data_source/authentication_remote_data_source/api_requests/sign_in_request.dart';
import 'package:workouts/data/data_sources/authentication_data_source/authentication_remote_data_source/api_requests/sign_up_request.dart';
import 'package:workouts/data/data_sources/remote_data_source.dart';
import 'package:workouts/data/dto_models/auth_token_dto.dart';

final class AuthenticationRemoteDataSource extends RemoteDataSource implements AuthenticationDataSource {
  AuthenticationRemoteDataSource({
    required super.httpClient,
  });

  /// Returns a [ForbiddenMiddleware] instance if the user has a refresh token, otherwise returns null.
  /// The [ForbiddenMiddleware] instance is used to refresh the access token when a 403 Forbidden response is received.
  /// The [ForbiddenMiddleware] instance is used by the `WorkoutsHttpClient` to automatically refresh the access token when a 403 Forbidden response is received.
  static Future<ForbiddenMiddleware?> forbiddenMiddleware() async {
    final refreshToken = ApiContext.instance.jwtAccessTokens?.refreshToken;
    if (refreshToken == null) {
      return null;
    }
    final refreshTokenRequest = RefreshTokenRequest(refreshToken: refreshToken);
    final shouldRetryInitialRequest = (Future<AuthTokenDto> Function() responseCallback) async {
      try {
        final response = await responseCallback();
        await ApiContext.instance.setTokens(response.accessToken, response.refreshToken);
        return true;
      } catch (e) {
        return false;
      }
    };
    final refreshTokenResponseParser = AuthTokenDto.fromJson;

    return ForbiddenMiddleware<AuthTokenDto>(
      refreshTokenRequest: refreshTokenRequest,
      shouldRetryInitialRequest: shouldRetryInitialRequest,
      refreshTokenResponseParser: refreshTokenResponseParser,
    );
  }

  @override
  Future<bool> isAuthenticated() async {
    return ApiContext.instance.hasTokens();
  }

  @override
  Future<AuthTokenDto> signIn(String email, String password) async {
    final request = SignInRequest(email: email, password: password);
    final response = await httpClient.executeRequest(request: request, parser: AuthTokenDto.fromJson);
    await ApiContext.instance.setTokens(response.accessToken, response.refreshToken);

    return response;
  }

  @override
  Future<AuthTokenDto> signUp(String email, String password) async {
    final request = SignUpRequest(email: email, password: password);
    final response = await httpClient.executeRequest(request: request, parser: AuthTokenDto.fromJson);
    await ApiContext.instance.setTokens(response.accessToken, response.refreshToken);

    return response;
  }

  @override
  Future<void> signOut() {
    return ApiContext.instance.clearTokens();
  }
}
