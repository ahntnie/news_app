import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:news_app/Model/Comment.dart';

List<Comment> lstComment = [];

class CommentRepository {
  static Future<void> addComment(Comment comment) async {
    var _comment = {
      "nameUser": comment.nameUser,
      "email": comment.email,
      "content": comment.content,
      "time": comment.time,
      "like": comment.like,
      "delete": comment.delete
    };
    final ref2 = FirebaseDatabase.instance.ref().child("comment");

    ref2
        .child(comment.title.toString())
        .child(comment.nameUser.toString())
        .set(_comment)
        .then((value) {
      print("Thêm bình luận thành công");
    }).catchError((onError) {
      print('Thêm bình luận không thành công');
    });
  }
}
