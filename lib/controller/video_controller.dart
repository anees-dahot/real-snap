import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:video_compress_plus/video_compress_plus.dart';
import '../model/video.dart';
import '../view/screens/home_screen.dart';



class VideoUploadController extends GetxController{
  static VideoUploadController instance = Get.find();
  var uuid = const Uuid();

  Future<File> _getThumb(String videoPath) async{
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

 Future<String> _uploadVideoThumbToStorage(String id , String videoPath) async{
  Reference reference = FirebaseStorage.instance.ref().child("thumbnail").child(id);
  UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
  TaskSnapshot snapshot = await uploadTask;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}

  //Main Video Upload
  //Video To Storage
  //Video Compress
  //Video Thumb Gen
  //Video Thumb To Storage

  uploadVideo(String songName , String caption , String videoPath) async{

    try{
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    //videoID - uuid
    String id  = uuid.v1();
    String videoUrl = await _uploadVideoToStorage( id, videoPath);

    String thumbnail  = await   _uploadVideoThumbToStorage(id , videoPath);
    //IDHAR SE
    Video video = Video(
      uid: uid,
      username: (userDoc.data() as Map)['userName'],
      videoUrl: videoUrl,
      thumbnail: thumbnail,
      title: songName,
      shareCount: 0,
      commentsCount: 0,
      likes: [],
      profilePic: (userDoc.data() as Map)['profilePic'],
      description: caption,
      id: id
    );
    await FirebaseFirestore.instance.collection("videos").doc(id).set(video.toJson());
    Get.snackbar("Video Uploaded Successfully", "Thank You Sharing Your Content");
Get.to(()=>const HomeScreen());
    }catch(e){

      Get.snackbar("Error Uploading Video", e.toString());
    }
  }


  _uploadVideoToStorage(String videoID , String videoPath) async{
   try{
     Reference reference = FirebaseStorage.instance.ref().child("videos").child(videoID);
    UploadTask uploadTask = reference.putFile(File(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
   }catch(e){
Get.snackbar('Upload Video To Storage Error', e.toString());
   }
  }

  _compressVideo(String videoPath) async{
    try{
      final compressedVideo =
    await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.LowQuality);
    return compressedVideo!.path;
    }
    catch(e){
      Get.snackbar('error', e.toString());
    }
  }
}