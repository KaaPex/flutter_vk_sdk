import 'package:flutter/foundation.dart';

enum VKFeedItemType {
  post,
  photo,
  photo_tag,
  wall_photo,
  friend,
  audio,
  video,
  topic,
  digest,
  stories,
  clips,
  promo_button,
  recommended_groups,
  tags_suggestions,
  games_carousel,
  feedback_poll,
  animated_block,
  textlive,
  video_promo,
  recommended_artists,
  recommended_playlists,
  clips_autoplay,
  recommended_game,
  clips_challenges,
  expert_card,
  videos_for_you,
  liked_by_friends_groups,
  recommended_mini_app,
  note,
  audio_playlist,
  clip,
  clips_block,
  videos_for_you_block,
  mini_apps_carousel,
  video_postcard,
  unknown,
}

extension VKFeedItemTypeExtension on VKFeedItemType {
  /// Name of scope.
  String get name => describeEnum(this);
}
