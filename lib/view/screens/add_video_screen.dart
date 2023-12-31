// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/auth_controller.dart';
import 'add_caption_screen.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({super.key});

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  AuthController instance = AuthController.instance;

  dialogBoxOpt() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {
                videoPicker(ImageSource.gallery, context);
              },
              child: const Text('Gallery'),
            ),
            SimpleDialogOption(
              onPressed: () {
                videoPicker(ImageSource.camera, context);
              },
              child: const Text('Camera'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.cancel),
            ),
          ],
        );
      },
    );
  }

  void videoPicker(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.snackbar('Video selected', video.path);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddCaptionScreen(
                  videoSource: File(video.path), videoPath: video.path)));
    } else {
      Get.snackbar('Error selecting video', 'Please choose a video');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () => dialogBoxOpt(),
              child: Container(
                width: 190,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: const Center(child: Text('Pick video')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
