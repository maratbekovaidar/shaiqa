

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:mic_stream/mic_stream.dart';
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

    listener = stream!.listen((samples) {
      result += base64Encode(samples);
      // print(base64Encode(samples));
    });
    Future.delayed(const Duration(seconds: 5), () {
      listener.cancel();
      print(result);
      musicDetectService.detectSound(base64string: result);
    });
  }

  Future stop() async {
    listener.cancel();
  }

}