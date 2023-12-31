import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../model/comment.dart';

class CommentController extends GetxController {
  static CommentController instance = Get.find();
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;
  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    fetchCommnent();
  }

  postComment(String commentText) async {
  try {
    if (commentText.isNotEmpty) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      var allDoc = await FirebaseFirestore.instance
          .collection('Videos')
          .doc(_postId)
          .collection('comments')
          .get();
      int lngth = allDoc.docs.length;

      Comment comment = Comment(
        commentText: commentText.trim(),
        username: (userDoc.data() as dynamic)['userName'],
        profilePic: (userDoc.data() as dynamic)['profilePic'],
        pubDate: DateTime.now().toString(),
        uid: FirebaseAuth.instance.currentUser!.uid,
        id: 'comments $lngth', // Unique ID
        likes: [],
      );

      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(comment.id) // Use the comment ID here
          .set(comment.toJson());

      DocumentSnapshot doc =
          await FirebaseFirestore.instance.collection('videos').doc(_postId).get();
      await FirebaseFirestore.instance.collection('videos').doc(_postId).update(
        {'commentsCount': (doc.data() as dynamic)['commentsCount'] + 1},
      );
      Get.snackbar('Sent', 'Your comment has been sent.');
    } else {
      Get.snackbar('Empty field', 'Please write the comment');
    }
  } catch (e) {
    Get.snackbar('Error in commenting', e.toString());
  }
}


  fetchCommnent() async {
    try {
      _comments.bindStream(FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .where(_postId)
          .snapshots()
          .map((QuerySnapshot query) {
        List<Comment> retVal = [];
        for (var element in query.docs) {
          retVal.add(Comment.fromSnapshot(element));
        }
        return retVal;
      }));
    } catch (e) {
      Get.snackbar('Error in commenting', e.toString());
    }
  }

  likeComment(String id) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    var uid = FirebaseAuth.instance.currentUser!.uid;

    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await FirebaseFirestore.instance
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}
