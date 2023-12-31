import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_snap/controller/comment_controller.dart';
import 'package:real_snap/view/widgets/text_field.dart';

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({super.key, required this.id});

  final TextEditingController _commentText = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    commentController.updatePostId(id);

    return Scaffold(
      // appBar: AppBar(elevation: 0,backgroundColor: backgroundColor,),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Stack(
            children: [
              Column(children: [
                Expanded(
                  child: Obx(() {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: CommentController.instance.comments.length,
                      itemBuilder: (context, index) {
                        final comment =
                            CommentController.instance.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.red,
                              backgroundImage:
                                  NetworkImage(comment.profilePic)),
                          title: Text(comment.username),
                          subtitle: Text(comment.commentText),
                          trailing: Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    CommentController.instance
                                        .likeComment(comment.id);
                                  },
                                  child: Icon(Icons.favorite,
                                      color: comment.likes.contains(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          ? Colors.red
                                          : Colors.white)),
                              Text(comment.likes.length.toString())
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ]),
              const Divider(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  height: height * 0.13,
                  color: Colors.black,
                  child: Center(
                    child: ListTile(
                      title: CustomTextField(
                          controller: _commentText,
                          myIcon: Icons.comment,
                          myLableText: 'Comment'),
                      trailing: TextButton(
                          onPressed: () {
                            commentController.postComment(_commentText.text);
                          },
                          child: const Text('Send')),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
