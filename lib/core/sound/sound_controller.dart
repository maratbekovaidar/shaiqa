

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

const pathToSaveAudio = 'record_audio.mp4';

class SoundController {

  FlutterSoundRecorder? _soundRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _soundRecorder!.isRecording;

  Future init() async {

    _soundRecorder = FlutterSoundRecorder();
    _soundRecorder!.setSubscriptionDuration(const Duration(milliseconds: 1));
    // _soundRecorder!.setLogLevel(aLevel);
    // _soundRecorder!.setDbPeakLevelUpdate(0.8);
    // _soundRecorder!.setDbLevelEnabled(true);

    final status = Permission.microphone.request();
    await status != PermissionStatus.granted ? throw RecordingPermissionException('Нету доступа к микрофону') : () {};

    await _soundRecorder!.openRecorder();
    _isRecorderInitialised = true;
  }

  Future dispose() async {
    if(!_isRecorderInitialised) return;
    _soundRecorder!.closeRecorder();
    _soundRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    if(!_isRecorderInitialised) return;

    debugPrint("Start recording");
    await _soundRecorder!.startRecorder(toFile: pathToSaveAudio, codec: Codec.aacMP4);
  }

  Future _stop() async {
    if(!_isRecorderInitialised) return;
    await _soundRecorder!.stopRecorder().then((value) {
      print(value);
    });
    debugPrint("End recording");
  }

  Future toggleRecording() async {
    _soundRecorder!.isStopped ? await _record() : await _stop();
  }

  Future getSound() async {



  }

}