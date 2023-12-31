import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/user.dart';

class SearchUserController extends GetxController{

Rx<List<MyUser>> _SearchedUser = Rx<List<MyUser>>([]);
List<MyUser> get SearchedUser => _SearchedUser.value;


SearchUser(String query) async{

_SearchedUser.bindStream(
 FirebaseFirestore.instance.collection('users').where('userName' ,isGreaterThanOrEqualTo : query ).snapshots().map((QuerySnapshot searchQuery){
final List<MyUser> retVal = [];
for(var element in searchQuery.docs ){
  retVal.add(MyUser.fromSnapshot(element));
}
return retVal;
})
);

}

}