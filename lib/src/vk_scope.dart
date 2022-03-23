class VKUserScope {
  /// User allowed to send notifications to him/her (for Flash/iFrame apps).
  static const String notify = 'notify';

  /// Access to friends.
  static const String friends = 'friends';

  /// Access to photos.
  static const String photos = 'photos';

  /// Access to audio.
  static const String audio = 'audio';

  /// Access to video.
  static const String video = 'video';

  /// Access to stories.
  static const String stories = 'stories';

  /// Access to wiki pages.
  static const String pages = 'pages';

  /// Addition of link to the application in the left menu.
  static const String add256 = '+256';

  /// Access to user status.
  static const String status = 'status';

  /// Access to notes.
  static const String notes = 'notes';

  /// (for Standalone applications) Access to advanced methods for messaging.
  static const String messages = 'messages';

  /// Access to standard and advanced methods for the wall. Note that this access permission is unavailable for sites (it is ignored at attempt of authorization).
  static const String wall = 'wall';

  /// Access to advanced methods for Ads API.
  static const String ads = 'ads';

  /// Access to API at any time (you will receive expires_in = 0 in this case).
  static const String offline = 'offline';

  /// Access to docs.
  static const String docs = 'docs';

  /// Access to user communities.
  static const String groups = 'groups';

  /// Access to notifications about answers to the user.
  static const String notifications = 'notifications';

  /// Access to statistics of user groups and applications where he/she is an administrator.
  static const String stats = 'stats';

  /// Access to user email.
  static const String email = 'email';

  /// Access to market.
  static const String market = 'market';

  /// Possibility to make API requests without HTTPS.
  static const String nohttps = 'nohttps';
}

class VKCommunityScope {
  /// Access to stories.
  static const String stories = 'stories';

  /// Access to photos.
  static const String photos = 'photos';

  /// Access to messages.
  static const String messages = 'messages';

  /// Access to docs.
  static const String docs = 'docs';

  /// Access to community management.
  static const String manage = 'manage';
}
