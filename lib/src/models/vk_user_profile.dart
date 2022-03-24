class VKUserProfile {
  final int userId;
  final String firstName;
  final String lastName;
  final bool? online;
  final bool? onlineMobile;
  final String? photo50;
  final String? photo100;
  final String? photo200;

  VKUserProfile.fromMap(Map<String, dynamic> map)
      : userId = map['id'] as int,
        firstName = map['first_name'] as String,
        lastName = map['last_name'] as String,
        online = map['online'] == 1 ? true : false as bool?,
        onlineMobile = map['online_mobile'] == 1 ? true : false as bool?,
        photo50 = map['photo_50'] as String?,
        photo100 = map['photo_100'] as String?,
        photo200 = map['photo_200'] as String?;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'online': online != null && online == true ? 1 : 0,
      'online_mobile': onlineMobile != null && onlineMobile == true ? 1 : 0,
      'photo_50': photo50,
      'photo_100': photo100,
      'photo_200': photo200,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VKUserProfile &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          online == other.online &&
          onlineMobile == other.onlineMobile &&
          photo50 == other.photo50 &&
          photo100 == other.photo100 &&
          photo200 == other.photo200;

  @override
  int get hashCode =>
      userId.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      online.hashCode ^
      onlineMobile.hashCode ^
      photo50.hashCode ^
      photo100.hashCode ^
      photo200.hashCode;

  @override
  String toString() {
    return 'VKUserProfile(userId: $userId, firstName: $firstName, '
        'lastName: $lastName, online: $online, onlineMobile: $onlineMobile, '
        'photo50: $photo50, photo100: $photo100, photo200: $photo200)';
  }
}
