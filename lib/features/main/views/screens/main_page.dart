
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:shaiqa/core/sound/sound_controller.dart';
import 'package:shaiqa/core/sound/sound_stream_controller.dart';
import 'package:shaiqa/utils/services/music_detect_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> with TickerProviderStateMixin  {



  bool recording = false;
  final MusicDetectService _musicDetectService = MusicDetectService();
  SoundController soundController = SoundController();
  SoundStreamController soundStreamController = SoundStreamController();

  @override
  void initState() {
    super.initState();
    soundController.init();
  }


  @override
  void dispose() {
    soundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  // soundController.toggleRecording();
                  soundStreamController.listen();
                  setState(() {

                  });
                },
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: soundController.isRecording ? Colors.red[300] : Colors.black38,
                  child: Icon(
                    Icons.mic_rounded,
                    size: 50,
                    color: soundController.isRecording ? Colors.red[700] : Colors.black87,
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

}
