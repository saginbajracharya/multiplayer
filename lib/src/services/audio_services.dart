import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';

class AudioFiles {
  static const String themeSong = 'assets/audio/theme_song.mp3';
  static const String lobbySong = 'assets/audio/lobby_song.mp3';
}

class AudioServices extends GetxController {
  static final AudioServices _instance = AudioServices._internal();

  factory AudioServices() {
    return _instance;
  }

  AudioServices._internal();
  late AssetsAudioPlayer _assetsAudioPlayer;
  RxDouble currentVolume = 1.0.obs;
  RxBool isPlaying = false.obs;

  void init() {
    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.current.listen((Playing? playing) {
      if (playing != null) {
        isPlaying.value = true;
        write(StorageKeys.audioOnKey, true);
        update();
      } else {
        isPlaying.value = false;
        write(StorageKeys.audioOnKey, false);
        update();
      }
    });
  }

  Future<void> play(String audioPath) async {
    await _assetsAudioPlayer.open(Audio(audioPath),loopMode : LoopMode.single);
    isPlaying.value = true;
    update();
    _assetsAudioPlayer.play();
  }

  Future<void> pause() async {
    isPlaying.value = false;
    write(StorageKeys.audioOnKey, false);
    update();
    _assetsAudioPlayer.pause();
  }

  Future<void> resume() async {
    isPlaying.value = true;
    write(StorageKeys.audioOnKey, true);
    update();
    _assetsAudioPlayer.play();
  }

  void setVolume(double volume) {
    currentVolume.value = volume;
    _assetsAudioPlayer.setVolume(volume);
  }

  @override
  void dispose() {
    super.dispose();
    _assetsAudioPlayer.dispose();
  }
}