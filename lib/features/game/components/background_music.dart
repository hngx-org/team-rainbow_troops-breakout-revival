import 'package:flame_audio/flame_audio.dart';

class BackgroundMusic {
  static void playBackgroundMusic() async {
    try {
      FlameAudio.bgm.initialize();
      await FlameAudio.play('cyberpunk_sonata.mp3', volume: 1.0);
    } catch (e) {
      print('Error playing background music: $e');
    }
  }
}
