import 'package:cloud_firestore/cloud_firestore.dart';

class Video{

String username;
String profilePic;
String uid;
String id;
List likes;
int commentsCount;
int shareCount;
String title;
String description;
String videoUrl;
String thumbnail;

Video({

  required this.username,
  required this.profilePic,
  required this.uid,
  required this.id,
  required this.likes,
  required this.commentsCount,
  required this.shareCount,
  required this.title,
  required this.description,
  required this.videoUrl,
  required this.thumbnail

});

 Map<String, dynamic> toJson() {
    return {
      'username': username,
      'profilePic': profilePic,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentsCount': commentsCount,
      'shareCount': shareCount,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
    };
  }


    // Factory method to create a Video object from a DocumentSnapshot
  static Video fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Video(
      username: data['username'],
      profilePic: data['profilePic'],
      uid: data['uid'],
      id: data['id'],
      likes: List.from(data['likes'] ?? []),
      commentsCount: data['commentsCount'],
      shareCount: data['shareCount'],
      title: data['title'],
      description: data['description'],
      videoUrl: data['videoUrl'],
      thumbnail: data['thumbnail'],
    );
  }
}

