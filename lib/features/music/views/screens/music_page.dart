
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shaiqa/utils/models/music_model.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key, required this.musicModel}) : super(key: key);

  final MusicModel musicModel;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with SingleTickerProviderStateMixin {


  /// Audio Controller
  AudioPlayer audioPlayer = AudioPlayer();
  bool isAudioPlaying = false;

  /// Animation controller
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    /// Animated controller init
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));

    /// Audio player init
    audioPlayer.play(widget.musicModel.audioUri);
    setState(() {
      isAudioPlaying = true;
    });
  }


  @override
  void dispose() {
    audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          /// Music background Image in sliver appbar
          SliverAppBar(
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(

              /// Title of Music
              title: Text(widget.musicModel.subtitle + " - " + widget.musicModel.title),
              centerTitle: false,
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              background: Container(
                decoration: BoxDecoration(

                  /// Background Image
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.musicModel.backgroundImage
                    ),
                    fit: BoxFit.cover
                  )
                ),

                /// Gradient
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xff4d194d),
                      ],
                    )
                  ),
                ),
              )
            ),
          ),

          /// Other Information
          SliverList(
            delegate: SliverChildListDelegate([

              /// Audio Player
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [

                    /// Play button
                    GestureDetector(
                      onTap: isAudioPlaying ? () {
                        audioPlayer.pause();
                        _animationController.forward();
                        setState(() {
                          isAudioPlaying = false;
                        });
                      } : () {
                        audioPlayer.resume();
                        _animationController.reverse();
                        setState(() {
                          isAudioPlaying = true;
                        });
                      },
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.musicModel.image
                            )
                          )
                        ),
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.pause_play,
                            progress: _animationController,
                            color: Colors.white,
                          ),
                        )
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),

          /// Adaptive To Lyrics
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: Center(
                child: Text(
                  "Scroll to see Lyrics",
                  style: TextStyle(
                      color: Colors.white60
                  ),
                ),
              ),
            ),
          ),

        ],
      )
    );
  }
}
