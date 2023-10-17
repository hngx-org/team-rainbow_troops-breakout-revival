import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

///wrapper class to play background music and sound effects
class BreakoutRevivalAudioPlayer {
  /// load all sounds to cache to play at ease without interruption
  Future<void> loadAssets() async {
    ///sounds from  https://opengameart.org/content/breaking-rock

    await FlameAudio.audioCache
        .loadAll(['rock_break.ogg', 'cyberpunk_sonata.mp3']);
  }

  void playRockBreaking() {
    FlameAudio.play('rock_break.ogg');
  }

  void playBackgroundMusic() {
    try {
      FlameAudio.bgm.play('cyberpunk_sonata.mp3', volume: 0.25);
    } catch (e) {
      debugPrint('Error playing background music: $e');
    }
  }
}
