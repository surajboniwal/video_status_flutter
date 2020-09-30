import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ChewieVideoItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool loop;

  ChewieVideoItem({@required this.videoPlayerController, this.loop});

  @override
  _ChewieVideoItemState createState() => _ChewieVideoItemState();
}

class _ChewieVideoItemState extends State<ChewieVideoItem> {
  ChewieController _chewieController;

  @override
  void initState() {
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      looping: widget.loop,
      aspectRatio: 16 / 9,
      autoPlay: true,
      allowMuting: false,
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}
