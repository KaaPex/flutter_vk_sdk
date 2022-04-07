import 'package:flutter/foundation.dart';

enum VKAttachmentType {
  photo,
  photos_list,
  posted_photo,
  audio,
  audio_playlist,
  video,
  doc,
  link,
  graffiti,
  note,
  app,
  poll,
  page,
  pretty_cards,
  album,
  market_album,
  market,
  event,
  mini_app,
  donut_link,
  article,
  textlive,
  textpost,
  textpost_publish,
  situational_theme,
  group,
  sticker,
  podcast,
  curator,
  artist,
}

extension VKAttachmentTypeExtension on VKAttachmentType {
  /// Name of scope.
  String get name => describeEnum(this);
}
