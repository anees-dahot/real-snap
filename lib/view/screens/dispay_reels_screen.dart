// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_snap/view/screens/comments_screen.dart';
import 'package:real_snap/view/screens/profile_screen.dart';
import 'package:real_snap/view/widgets/profile_pic_widget.dart';
import 'package:video_player/video_player.dart';
import '../../controller/video_display_controller.dart';
import '../widgets/video_player_widget.dart';

class DisplayReelsScreen extends StatefulWidget {
  DisplayReelsScreen({Key? key}) : super(key: key);

  

   


  @override
  State<DisplayReelsScreen> createState() => _DisplayReelsScreenState();
}

class _DisplayReelsScreenState extends State<DisplayReelsScreen> {
  final VideoController videoController = Get.put(VideoController());
    late VideoPlayerController videoPlayerController;


    
  
   @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          body: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: PageController(initialPage: 0, viewportFraction: 1),
              itemCount: videoController.videoList.length,
              itemBuilder: (context, index) {
                final data = videoController.videoList[index];
                // Update the isLiked property in your data object
        
                return GestureDetector(
                  onDoubleTap: ()=>  videoController.likedVideo(data.id),
                 
          
                  child: Stack(
                    children: [
                      VideoPlayerWidget(
                        videoUrl: data.videoUrl,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, left: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.username,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  height: 1.6),
                            ),
                            Text(
                              data.description,
                              style: const TextStyle(height: 1.6),
                            ),
                            Text(
                              data.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, height: 1),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: Get.height * 0.5,
                          margin: EdgeInsets.only(top: Get.height / 3, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                 onTap: (){
                          Get.to(()=> ProfileScreen(uid: data.uid));
                        },
                                child: ProfilePicWidget(
                                  profilePhotoUrl: data.profilePic,
                                ),
                              ),
                          
                              InkWell(
                                onTap: () {
                                  videoController.likedVideo(data.id);
                                },
                                child: Column(
                                  children: [
                                     Icon(
                                      Icons.favorite,
                                      size: 35,
                                      color: data.likes.contains(FirebaseAuth.instance.currentUser!.uid) ? Colors.red : Colors.white,
                                    ),
                                    Text(
                                      data.likes.length.toString(),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.reply,
                                    size: 35,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    data.shareCount.toString(),
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  )
                                ],
                              ),
                              // SizedBox(height: 10,),
                              InkWell(
                                onTap: () =>
                                    Get.to(() => CommentScreen(id: data.id) ),
                                   
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.comment,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      data.commentsCount.toString(),
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    });
  }
}
