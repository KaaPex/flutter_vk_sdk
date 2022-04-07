///
//  1 — Rock;
//  2 — Pop;
//  3 — Rap & Hip-Hop;
//  4 — Easy Listening;
//  5 — House & Dance;
//  6 — Instrumental;
//  7 — Metal;
//  21 — Alternative;
//  8 — Dubstep;
//  1001 — Jazz & Blues;
//  10 — Drum & Bass;
//  11 — Trance;
//  12 — Chanson;
//  13 — Ethnic;
//  14 — Acoustic & Vocal;
//  15 — Reggae;
//  16 — Classical;
//  17 — Indie Pop;
//  19 — Speech;
//  22 — Electropop & Disco;
//  18 — Other.
///

import 'package:flutter/foundation.dart';

enum VKAudioGenre {
  Rock,
  Pop,
  RapAndHipHop,
  EasyListening,
  HouseAndDance,
  Instrumental,
  Metal,
  Alternative,
  Dubstep,
  JazzAndBlues,
  DrumAndBass,
  Trance,
  Chanson,
  Ethnic,
  AcousticAndVocal,
  Reggae,
  Classical,
  IndiePop,
  Speech,
  ElectropopAndDisco,
  Other
}

extension VKAudioGenreExtension on VKAudioGenre {
  /// Name of scope.
  String get name => describeEnum(this);

  int get code {
    switch (this) {
      case VKAudioGenre.Rock:
        return 1;
      case VKAudioGenre.Pop:
        return 2;
      case VKAudioGenre.RapAndHipHop:
        return 3;
      case VKAudioGenre.EasyListening:
        return 4;
      case VKAudioGenre.HouseAndDance:
        return 5;
      case VKAudioGenre.Instrumental:
        return 6;
      case VKAudioGenre.Metal:
        return 7;
      case VKAudioGenre.Alternative:
        return 21;
      case VKAudioGenre.Dubstep:
        return 8;
      case VKAudioGenre.JazzAndBlues:
        return 1001;
      case VKAudioGenre.DrumAndBass:
        return 10;
      case VKAudioGenre.Trance:
        return 11;
      case VKAudioGenre.Chanson:
        return 12;
      case VKAudioGenre.Ethnic:
        return 13;
      case VKAudioGenre.AcousticAndVocal:
        return 14;
      case VKAudioGenre.Reggae:
        return 15;
      case VKAudioGenre.Classical:
        return 16;
      case VKAudioGenre.IndiePop:
        return 17;
      case VKAudioGenre.Speech:
        return 19;
      case VKAudioGenre.ElectropopAndDisco:
        return 22;
      case VKAudioGenre.Other:
      default:
        return 18;
    }
  }
}
