import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:real_snap/view/screens/auth/login_screen.dart';

import '../model/user.dart';
import '../view/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _checkUserState);
  }

  _checkUserState(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

//imagge pickining

  File? profileImage;
  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    final imagePath = File(image.path);
    profileImage = imagePath;
  }

// profile picture uploading function

  Future<String> _uploadProPic(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref('ProfilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imgDwnlUrl = await taskSnapshot.ref.getDownloadURL();
    return imgDwnlUrl;
  }

// Account Creation Method
  void createAccount(
    String userName,
    String email,
    String password,
    File? image,
  ) async {
    try {
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadProPic(image);

        MyUser user = MyUser(
            userName: userName,
            email: email,
            uid: credential.user!.uid,
            profilePic: downloadUrl);

        //Saving user data to firestore

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(user.toJson())
            .then((value) {
          Get.snackbar(
              'Account Created', 'Your account has been successfully created.');
          Get.to(() => const LoginScreen());
        }).onError((error, stackTrace) {
          Get.snackbar('Error', error.toString());
        });
      } else {
        Get.snackbar(
            'Error Creating Account', 'Please Fill All Required Fields');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  //Sign ip function

  void signIn(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          Get.snackbar('Successfull', 'Signed In successfully');
          Get.to(()=> const HomeScreen());
        }).onError((error, stackTrace) {
          Get.snackbar('Error', error.toString());
        });
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  void singOut(){
    FirebaseAuth.instance.signOut();
     Get.snackbar('Signed Out','You have been signed out!');
    Get.offAll(const LoginScreen());
  }



}
