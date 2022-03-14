import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shaiqa/core/sound/sound_stream_controller.dart';
import 'package:shaiqa/features/music/views/screens/music_page.dart';
import 'package:shaiqa/utils/models/music_model.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> with TickerProviderStateMixin  {



  bool recording = false;
  SoundStreamController soundStreamController = SoundStreamController();
  Random random = Random();
  Timer? timer;
  MusicModel? musicModel;
  double radius = 80;


  /// Animation controller
  late AnimationController _controller;
  late Animation<int> _decorationTween;

  /// Listening controller
  void changeRadius() {
    setState(() {
      radius = 80.0 + random.nextInt(30);
    });
  }

  void listeningStart() {
    timer = Timer.periodic(const Duration(microseconds: 30000), (Timer t) => changeRadius());
  }

  void listeningStop() {
    timer?.cancel();
  }



  @override
  void initState() {
    super.initState();

    /// Animation controller init
    _controller =
        AnimationController(
          lowerBound: 0.9,
          upperBound: 1.0,
          duration: const Duration(seconds: 1),
          vsync: this
        );
    _controller.repeat(reverse: true);

    _decorationTween = IntTween(
      begin: 80,
      end: 100
    ).animate(_controller);
  }


  @override
  void dispose() {
    _controller.dispose();
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
              RippleAnimation(
                repeat: true,
                color: const Color(0xff006466),
                minRadius: recording ? 90 : 0,
                ripplesCount: 6,
                child: GestureDetector(
                  onTap: () async {

                    _controller.stop();
                    listeningStart();
                    setState(() {
                      recording = true;
                    });

                    try {
                      musicModel = await soundStreamController.listen(context);
                    } catch(e) {
                      setState(() {
                        radius = 80;
                        recording = false;
                      });
                    }

                    setState(() {
                      radius = 80;
                      recording = false;
                    });
                    listeningStop();
                    _controller.repeat(reverse: true);

                    if(musicModel != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MusicPage(musicModel: musicModel!)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Doesn't have result :("),
                      ));
                    }

                  },
                  child: AnimatedBuilder(
                    animation: _decorationTween,
                    builder: (BuildContext _, child) {
                      return Transform.scale(

                        scale: _controller.value,
                        child: child,
                      );
                    },
                    child: CircleAvatar(
                      radius: radius,
                      backgroundColor: recording ? const Color(0xff006466) : const Color(0xff1A1A2E),
                      child: Icon(
                        Icons.mic_rounded,
                        size: 50,
                        color: recording ? Colors.white : Colors.grey,
                      ),
                    ),
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
