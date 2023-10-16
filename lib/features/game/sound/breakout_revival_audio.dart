import 'package:flame_audio/flame_audio.dart';

///wrapper class to play background music and sound effects
class BreakoutRevivalAudioPlayer {
  /// load all sounds to cache to play at ease without interruption
  Future<void> loadAssets() async {
    ///sounds from  https://opengameart.org/content/breaking-rock

    await FlameAudio.audioCache.loadAll(['rock_break.ogg']);
  }

  void playRockBreaking() {
    FlameAudio.play('rock_break.ogg');
  }
}
