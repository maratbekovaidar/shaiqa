

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:mic_stream/mic_stream.dart';
import 'package:shaiqa/constants/sounds/base64_sound.dart';
import 'package:shaiqa/utils/services/music_detect_service.dart';

class SoundStreamController {

  late StreamSubscription<List<int>> listener;
  MusicDetectService musicDetectService = MusicDetectService();
  bool isRecord() => listener.isPaused;

  Future listen() async {
    Stream<Uint8List>? stream = await MicStream.microphone(
      audioSource: AudioSource.DEFAULT,
      sampleRate: 44100,
      channelConfig: ChannelConfig.CHANNEL_IN_MONO,
      audioFormat: AudioFormat.ENCODING_PCM_16BIT
    );

    String result = "";

    var soundBytes = BytesBuilder();

    listener = stream!.listen((samples) {
      print(samples);
      result += base64Encode(samples);
      // print(base64Encode(samples));
      soundBytes.add(samples);
    });


    Future.delayed(const Duration(seconds: 5), () {
      listener.cancel();
      print(result);
      musicDetectService.detectSound(base64string: base64Encode(soundBytes.toBytes()));
    });
  }

  Future stop() async {
    listener.cancel();
  }

  Future fileListen() async {
    File imagefile = File("sounds/sound.mp3"); //convert Path to File
    Uint8List imagebytes = await imagefile.readAsBytes(); //convert to bytes
    String base64string = base64.encode(imagebytes); //convert bytes to base64 string
    print(base64string);
  }

}