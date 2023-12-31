import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String userName;
  String email;
  String uid;
  String profilePic;

  MyUser({
    required this.userName,
    required this.email,
    required this.uid,
    required this.profilePic,
  });



  // Factory constructor to create a User object from a DocumentSnapshot
  static MyUser fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;

    return MyUser(
      userName: data['userName'] ?? '',
      email: data['email'] ?? '',
      uid: data['uid'] ?? '',
      profilePic: data['profilePic'] ?? '',
    );
  }

        Map<String, dynamic> toJson(){
return{
'userName': userName,
'email': email,
'uid': uid,
'profilePic': profilePic,

};
}
}




  
  
