import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:real_snap/view/screens/add_video_screen.dart';
import 'package:real_snap/view/screens/dispay_reels_screen.dart';

import 'view/screens/profile_screen.dart';
import 'view/screens/search_users_screen.dart';

// Colors

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

final pageindex = [
  DisplayReelsScreen(),
  SearchUsers(),
  const AddVideoScreen(),
  const Text(
    'Messages',
  ),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
];
