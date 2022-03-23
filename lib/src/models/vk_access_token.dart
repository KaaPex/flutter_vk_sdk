import 'dart:ffi';

/// VK access token.
class VKAccessToken {
  final String token;
  final String userId;
  final String? secret;
  final DateTime? created;
  final String? email;
  final String? phone;
  final String? phoneAccessKey;
  bool _httpsRequired;
  int _expirationDate;

  VKAccessToken(this.userId, this.token, this.secret, this.created, this.email,
      this.phone, this.phoneAccessKey)
      : _httpsRequired = true,
        _expirationDate = -1;

  VKAccessToken.fromMap(Map<String, dynamic> map)
      : token = map['token'] as String,
        userId = map['userId'] as String,
        created = DateTime.fromMillisecondsSinceEpoch(map['created'] as int,
            isUtc: true),
        secret = map['secret'] as String?,
        email = map['email'] as String?,
        phone = map['phone'] as String?,
        phoneAccessKey = map['phoneAccessKey'] as String?,
        _httpsRequired = map['httpsRequired'] == '1',
        _expirationDate =
            map.containsKey('expiresIn') ? map['expiresIn'] as int : -1;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VKAccessToken &&
          token == other.token &&
          userId == other.userId &&
          created == other.created &&
          secret == other.secret &&
          email == other.email;

  @override
  int get hashCode =>
      token.hashCode ^
      userId.hashCode ^
      created.hashCode ^
      secret.hashCode ^
      email.hashCode;

  @override
  String toString() {
    return 'VKAccessToken(token: $token, userId: $userId, '
        'created: $created, secret: $secret, email: $email)';
  }
}
