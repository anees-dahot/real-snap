import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_snap/model/user.dart';
import 'package:real_snap/view/screens/profile_screen.dart';

import '../../constants.dart';
import '../../controller/search_users_controller.dart';

class SearchUsers extends StatelessWidget {
   SearchUsers({super.key});

  final TextEditingController _searchController = TextEditingController();
  final SearchUserController searchUserController = Get.put(SearchUserController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:  SizedBox(
            height:50,
            width: 422,
            child: TextField(
                
                controller: _searchController,
                onChanged: (value) {
                  searchUserController.SearchUser(value);
                },
                decoration: InputDecoration(
                  hintText: 'SearchUsers',
              // icon: const Icon(Icons.search),
              // labelText: 'Searc',
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: borderColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: borderColor))),
                  onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
          ),
        ),
        body: searchUserController.SearchedUser.isEmpty ?   const Center(
                  child: Text("Search Users!"),
                ) :
                ListView.builder(
                    itemCount: searchUserController.SearchedUser.length,
                    itemBuilder: (context, index){
                  MyUser user = searchUserController.SearchedUser[index];
        
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid)));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
        
                        user.profilePic
                      ),
                    ),
        
                    title: Text(user.userName),
        
                  );
                }),
      );
  });
    
    
  }
}