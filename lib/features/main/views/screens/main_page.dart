
import 'package:flutter/material.dart';
import 'package:shaiqa/core/sound/sound_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> {

  /// Sound Controller
  final _soundController = SoundController();


  @override
  void initState() {
    super.initState();
    _soundController.init();

    // _soundController.setSubscriptionDuration(0.01);
    // _soundController.setDbPeakLevelUpdate(0.8);
    // _soundController.setDbLevelEnabled(true);
  }


  @override
  void dispose() {
    _soundController.dispose();
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
                  final isRecording = await _soundController.toggleRecording();
                  setState(() {

                  });
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: _soundController.isRecording ? Colors.red[300] : Colors.black38,
                  child: Icon(
                    Icons.mic_rounded,
                    color: _soundController.isRecording ? Colors.red[700] : Colors.black87,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}
