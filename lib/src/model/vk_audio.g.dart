// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_audio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKAudio _$VKAudioFromJson(Map<String, dynamic> json) => VKAudio(
      json['id'] as int,
      json['owner_id'] as int,
      json['artist'] as String,
      json['title'] as String,
      json['duration'] as int,
      json['url'] as String,
      const BooleanConverter().fromJson(json['is_hq'] as int?),
      json['lyrics_id'] as int?,
      json['album_id'] as int?,
      $enumDecodeNullable(_$VKAudioGenreEnumMap, json['genre_id']),
      const NullDateTimeConverter().fromJson(json['date'] as int?),
      const NullBooleanConverter().fromJson(json['no_search'] as int?),
    );

Map<String, dynamic> _$VKAudioToJson(VKAudio instance) => <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'artist': instance.artist,
      'title': instance.title,
      'duration': instance.duration,
      'url': instance.url,
      'lyrics_id': instance.lyricsId,
      'album_id': instance.albumId,
      'genre_id': _$VKAudioGenreEnumMap[instance.genreId],
      'date': const NullDateTimeConverter().toJson(instance.date),
      'no_search': const NullBooleanConverter().toJson(instance.noSearch),
      'is_hq': const BooleanConverter().toJson(instance.isHq),
    };

const _$VKAudioGenreEnumMap = {
  VKAudioGenre.Rock: 'Rock',
  VKAudioGenre.Pop: 'Pop',
  VKAudioGenre.RapAndHipHop: 'RapAndHipHop',
  VKAudioGenre.EasyListening: 'EasyListening',
  VKAudioGenre.HouseAndDance: 'HouseAndDance',
  VKAudioGenre.Instrumental: 'Instrumental',
  VKAudioGenre.Metal: 'Metal',
  VKAudioGenre.Alternative: 'Alternative',
  VKAudioGenre.Dubstep: 'Dubstep',
  VKAudioGenre.JazzAndBlues: 'JazzAndBlues',
  VKAudioGenre.DrumAndBass: 'DrumAndBass',
  VKAudioGenre.Trance: 'Trance',
  VKAudioGenre.Chanson: 'Chanson',
  VKAudioGenre.Ethnic: 'Ethnic',
  VKAudioGenre.AcousticAndVocal: 'AcousticAndVocal',
  VKAudioGenre.Reggae: 'Reggae',
  VKAudioGenre.Classical: 'Classical',
  VKAudioGenre.IndiePop: 'IndiePop',
  VKAudioGenre.Speech: 'Speech',
  VKAudioGenre.ElectropopAndDisco: 'ElectropopAndDisco',
  VKAudioGenre.Other: 'Other',
};
