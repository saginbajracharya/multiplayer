import 'package:assets_audio_player/assets_audio_player.dart';

class AudioManager {
  static final AudioManager _instance = AudioManager._internal();

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal();

  late AssetsAudioPlayer _assetsAudioPlayer;

  void init() {
    _assetsAudioPlayer = AssetsAudioPlayer();
  }

  Future<void> play(String audioPath) async {
    await _assetsAudioPlayer.open(Audio(audioPath));
    _assetsAudioPlayer.play();
  }

  Future<void> pause() async {
    _assetsAudioPlayer.pause();
  }

  Future<void> resume() async {
    _assetsAudioPlayer.play();
  }

  void setVolume(double volume) {
    _assetsAudioPlayer.setVolume(volume);
  }

  void dispose() {
    _assetsAudioPlayer.dispose();
  }
}
