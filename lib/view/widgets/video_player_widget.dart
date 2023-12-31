import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class VideoPlayerWidget extends StatefulWidget {

  String videoUrl;
   VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {


  late VideoPlayerController  videoPlayerController;
  var height = Get.height;
  var width = Get.width;

   @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
 }

 @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height *1,
      width: width * 1 ,
      decoration: const BoxDecoration(
color: Colors.black
      ),
      child: VideoPlayer(videoPlayerController),
    );
  }
}