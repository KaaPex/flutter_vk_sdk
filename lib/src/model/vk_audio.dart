import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/constants/constants.dart';

import 'converter.dart';

part 'vk_audio.g.dart';

@JsonSerializable()
@NullDateTimeConverter()
@BooleanConverter()
@NullBooleanConverter()
@VKAudioGenreConverter()
class VKAudio extends Equatable {
  final int id;
  @JsonKey(name: 'owner_id')
  final int ownerId;
  final String artist;
  final String title;
  final int duration;
  final String url;
  @JsonKey(name: 'lyrics_id')
  final int? lyricsId;
  @JsonKey(name: 'album_id')
  final int? albumId;
  @JsonKey(name: 'genre_id')
  final VKAudioGenre? genreId;
  final DateTime? date;
  @JsonKey(name: 'no_search')
  final bool? noSearch;
  @JsonKey(name: 'is_hq')
  final bool isHq;

  const VKAudio(
    this.id,
    this.ownerId,
    this.artist,
    this.title,
    this.duration,
    this.url,
    this.isHq, [
    this.lyricsId,
    this.albumId,
    this.genreId,
    this.date,
    this.noSearch,
  ]);

  static const VKAudio empty = VKAudio(0, 0, '', '', 0, '', false);

  factory VKAudio.fromJson(Map<String, dynamic> json) => _$VKAudioFromJson(json);
  Map<String, dynamic> toJson() => _$VKAudioToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        ownerId,
        artist,
        title,
        duration,
        url,
        lyricsId,
        albumId,
        genreId,
        date,
        noSearch,
        isHq,
      ];
}
