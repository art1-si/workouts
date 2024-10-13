import 'dart:convert';

class AuthTokenDto {
  final String accessToken;
  final String refreshToken;
  AuthTokenDto({
    required this.accessToken,
    required this.refreshToken,
  });

  AuthTokenDto copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthTokenDto(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory AuthTokenDto.fromMap(Map<String, dynamic> map) {
    return AuthTokenDto(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthTokenDto.fromJson(String source) => AuthTokenDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthTokenDto(accessToken: $accessToken, refreshToken: $refreshToken)';

  @override
  bool operator ==(covariant AuthTokenDto other) {
    if (identical(this, other)) return true;

    return other.accessToken == accessToken && other.refreshToken == refreshToken;
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;
}
