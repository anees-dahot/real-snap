// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_snap/controller/video_controller.dart';
import 'package:real_snap/view/widgets/text_field.dart';
import 'package:video_player/video_player.dart';

import '../../constants.dart';
import '../widgets/cusotm_button.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoSource;
  String videoPath;
  AddCaptionScreen(
      {super.key, required this.videoSource, required this.videoPath});

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController;
  final TextEditingController _videoTitle = TextEditingController();
  final TextEditingController _videoDesc = TextEditingController();
  VideoUploadController instance = VideoUploadController.instance;
  var height = Get.height;

  @override
  void initState() {
    super.initState();
    setState(() {
      videoPlayerController = VideoPlayerController.file(widget.videoSource);
    });
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(0.3);
   
  }

@override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: SizedBox(
                height: height * 0.4,
                child: VideoPlayer(videoPlayerController),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                  controller: _videoTitle,
                  myIcon: Icons.title,
                  myLableText: 'Video Title'),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomTextField(
                  controller: _videoDesc,
                  myIcon: Icons.description,
                  myLableText: 'Video Description'),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CustomButton(
                title: 'Upload',
                onTap: () {
                  instance.uploadVideo(
                      _videoTitle.text, _videoDesc.text, widget.videoPath);
                })
          ],
        ),
      ),
    );
  }
}
