
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class SoundController {

  FlutterSoundRecorder? _soundRecorder;
  bool _isRecorderInitialised = false;
  StreamSink<Food>? toStream;

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
    await _soundRecorder!.startRecorder(
      toFile: "recordedSound.mp4",
      // codec: Codec.defaultCodec,
      sampleRate: 44100,
      // bitRate: 44100,
      numChannels: 1
    );
  }

  Future _stop() async {
    if(!_isRecorderInitialised) return;
    String? path = await _soundRecorder!.stopRecorder();
    debugPrint("Path: " + path!);
    // final bytes = File(path).readAsBytesSync();
    // String img64 = base64Encode(bytes);
    // debugPrint("End recording");
    // debugPrint(img64);
  }

  Future toggleRecording() async {
    _soundRecorder!.isStopped ? await _record() : await _stop();
  }

  Future getSound() async {



  }

}