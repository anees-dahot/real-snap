import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
String commentText;
String username;
String pubDate;
List likes;
String profilePic;
String uid;
String id;

Comment({
  required this.commentText,
  required this.username,
  required this.profilePic,
  required this.pubDate,
  required this.uid,
  required this.id,
  required this.likes,
});

 Map<String, dynamic> toJson() {
    return {
      'commentText' :commentText,
      'username': username,
      'profilePic': profilePic,
      'uid': uid,
      'id': id,
      'likes': likes,
      'pubDate': pubDate,

    };
  }


    // Factory method to create a Video object from a DocumentSnapshot
  static Comment fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return Comment(
      commentText: data['commentText'],
      username: data['username'],
      profilePic: data['profilePic'],
      uid: data['uid'],
      id: data['id'],
      likes: List.from(data['likes'] ?? []),
      pubDate: data['pubDate'],
    );
  }
}

