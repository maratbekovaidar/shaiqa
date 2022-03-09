import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shaiqa/core/sound/sound_stream_controller.dart';
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

  double radius = 80;

  void changeRadius() async {

      timer = Timer.periodic(const Duration(milliseconds: 10), (Timer t) {
        setState(() {
          radius = (random.nextInt(50) + 50).toDouble();
        });
      });
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
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
                color: Colors.black54,
                minRadius: recording ? 90 : 0,
                ripplesCount: 6,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      recording = true;
                    });
                    changeRadius();
                    String result = await soundStreamController.listen(context);

                    if(result.isNotEmpty) {
                      setState(() {
                        timer!.cancel();
                        print(timer!.isActive);
                        print("ok");
                        radius = 80;
                        recording = false;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: CircleAvatar(
                      radius: radius,
                      backgroundColor: recording ? Colors.red : const Color(0xff1A1A2E),
                      child: Icon(
                        Icons.mic_rounded,
                        size: 50,
                        color: recording ? Colors.pink : Colors.grey,
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
