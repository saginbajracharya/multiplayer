import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';

class AudioFiles {
  static const String themeSong = 'assets/audio/theme_song.mp3';
  static const String lobbySong = 'assets/audio/lobby_song.mp3';
}

class AudioServices extends GetxController {
  static final AudioServices _instance = AudioServices._internal();
  bool audioInitilized = false;

  factory AudioServices() {
    return _instance;
  }

  AudioServices._internal();
  late AssetsAudioPlayer _assetsAudioPlayer;
  RxDouble currentVolume = 1.0.obs;
  RxBool isPlaying = false.obs;

  void init() {
    if(audioInitilized==false){
      audioInitilized = true;
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
  }

  Future<void> play(String audioPath) async {
    // Check if the requested audio is already playing
    if (_assetsAudioPlayer.isPlaying.value && _assetsAudioPlayer.current.value?.audio.audio.path == audioPath) {
      return;
    }
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

  void playAudioBasedOnCurrentPage(currentRoute,prevRoute) {
    dynamic audioOn = read(StorageKeys.audioOnKey)==""?true:read(StorageKeys.audioOnKey);
    if(audioOn){
      if (currentRoute == '/lobby_view') {
        play(AudioFiles.lobbySong);
      } else {
        play(AudioFiles.themeSong);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _assetsAudioPlayer.dispose();
  }
}

class AudioNavigatorObserver extends NavigatorObserver {
  // POP Remove [prevRoute , currentRoute] opposit 
  // Push Add [currentRoute , prevRoute] original 
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    updateAudioBasedOnCurrentPage(previousRoute?.settings.name,route.settings.name);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    updateAudioBasedOnCurrentPage(route.settings.name, previousRoute?.settings.name);
  }

  void updateAudioBasedOnCurrentPage(currentRoute,prevRoute) {
    final AudioServices audioService = Get.put(AudioServices());
    if (currentRoute != null) {
      audioService.playAudioBasedOnCurrentPage(currentRoute,prevRoute);
    }
  }
}

