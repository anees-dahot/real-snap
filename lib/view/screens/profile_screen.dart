// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_snap/constants.dart';
import 'package:real_snap/controller/auth_controller.dart';
import 'package:real_snap/controller/user_profile_controller.dart';
import 'package:real_snap/view/screens/dispay_reels_screen.dart';

import '../widgets/cusotm_button.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
final ProfileController profileController = Get.find<ProfileController>();
  final AuthController authController = Get.put(AuthController());
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    profileController.updateUseId(widget.uid);
  }

  dialogBoxOpt() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
                           child:   TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: 'Write name',
                  // icon: const Icon(Icons.search),
                  // labelText: 'Searc',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: borderColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: borderColor))),
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
            ),
            ),
            SimpleDialogOption(
              child:  CustomButton(
                title: 'Change',
                onTap: () {
                  profileController.changeUserName(_nameController.text);
                  Navigator.pop(context);
               
                
                }),
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

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    final height = Get.height;
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (profileController.user.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx((){
                          return Text(controller.user['name'].toString());
                        }
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      GestureDetector(
                          onTap: () {
                            dialogBoxOpt();
                          },
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                          ))
                    ],
                  ),
                  centerTitle: true,
                  backgroundColor: backgroundColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.010,
                      ),
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.user['profilePic'].toString(),
                          fit: BoxFit.contain,
                          height: 100,
                          width: 100,
                          placeholder: (context, url) {
                            return const CircularProgressIndicator();
                          },
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * 0.030,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(controller.user['following'].toString()),
                              SizedBox(
                                height: height * 0.001,
                              ),
                              const Text(
                                'Following',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.12,
                          ),
                          Column(
                            children: [
                              Text((controller.user['followers'].toString())),
                              SizedBox(
                                height: height * 0.001,
                              ),
                              const Text('Followers',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.12,
                          ),
                          Column(
                            children: [
                              Text((controller.user['likes'].toString())),
                              SizedBox(
                                height: height * 0.001,
                              ),
                              const Text('Likes',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.030,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (widget.uid ==
                                  FirebaseAuth.instance.currentUser!.uid) {
                                authController.singOut();
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                profileController.followUser();
                              },
                              child: Container(
                                  width: width * 0.28,
                                  height: height * 0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(widget.uid ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                          ? 'Sign Out'
                                          : controller.user['isFollowing']
                                              ? 'Follow'
                                              : 'Unfollow'))),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.030,
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                                crossAxisSpacing: 5),
                        itemCount: controller.user['thumbnails'].length,
                        itemBuilder: (context, index) {
                          String thumbnail =
                              controller.user['thumbnails'][index];
                          return GestureDetector(
                            onTap: ()=> Get.to(()=> DisplayReelsScreen()),
                            child: CachedNetworkImage(
                              imageUrl: thumbnail,
                              fit: BoxFit.cover,
                              // placeholder: (context, url) {
                              //   return const CircularProgressIndicator();
                              // },
                              errorWidget: (context, url, error) {
                                return const Icon(Icons.error);
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ));
          }
        });
  }
}
