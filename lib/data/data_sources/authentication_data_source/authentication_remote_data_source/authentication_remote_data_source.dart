import 'package:workouts/data/clients/workouts_http_client/api_context.dart';
import 'package:workouts/data/data_sources/authentication_data_source/authentication_data_source.dart';
import 'package:workouts/data/data_sources/authentication_data_source/authentication_remote_data_source/api_requests/sign_in_request.dart';
import 'package:workouts/data/data_sources/authentication_data_source/authentication_remote_data_source/api_requests/sign_up_request.dart';
import 'package:workouts/data/data_sources/remote_data_source.dart';
import 'package:workouts/data/dto_models/auth_token_dto.dart';

final class AuthenticationRemoteDataSource extends RemoteDataSource implements AuthenticationDataSource {
  AuthenticationRemoteDataSource({
    required super.httpClient,
  });

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
