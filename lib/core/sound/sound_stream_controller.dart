

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:shaiqa/utils/services/music_detect_service.dart';

class SoundStreamController {

  late StreamSubscription<List<int>> listener;
  MusicDetectService musicDetectService = MusicDetectService();
  bool recording = false;
  bool get isRecord => recording;

  Future<String> listen(BuildContext context) async {

    recording = true;
    /// Stream Init
    Stream<Uint8List>? stream = await MicStream.microphone(
      audioSource: AudioSource.DEFAULT,
      sampleRate: 44100,
      channelConfig: ChannelConfig.CHANNEL_IN_MONO,
      audioFormat: AudioFormat.ENCODING_PCM_16BIT
    );

    /// List of bytes
    var soundBytes = BytesBuilder();

    /// Listen stream
    listener = stream!.listen((samples) {
      print(samples);
      soundBytes.add(samples);
    });

    Response? response;

    /// After 5 seconds stop record
    await Future.delayed(const Duration(seconds: 3), () async {

      /// Stop
      listener.cancel();

      /// Call request to detect service
      response = await musicDetectService.detectSound(base64string: base64Encode(soundBytes.toBytes()));

    });


    if(response!.statusCode == 200) {
      print(response!.data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response!.data['track'] == null ? "Not detect" : response!.data['track']['subtitle'] + " - " + response!.data['track']['title']),
      ));
      recording = false;
      return "success";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Doesn't have result :("),
      ));
      recording = false;
      return "false";
    }

  }

  /// Stop method
  Future stop() async {
    listener.cancel();
  }
}