import 'package:firebase_database/firebase_database.dart';
import 'package:news_app/Model/Comment.dart';

class CommentRepository {
  static List<Comment> lstComments = List.filled(
      0,
      Comment(
        lstLike: [],
        title: "",
        nameUser: "",
        email: "",
        content: "",
        time: "",
      ),
      growable: true);
  static Future<void> setComment(Comment comment) async {
    var comment0 = {
      "nameUser": comment.nameUser,
      "email": comment.email,
      "content": comment.content,
      "time": comment.time.substring(0, 19),
      "lstLike": comment.lstLike,
    };
    final ref2 = FirebaseDatabase.instance.ref().child("comment");
    ref2.child(comment.title.toString()).push().set(comment0).then((value) {
      print("Thêm bình luận thành công");
    }).catchError((onError) {
      print('Thêm bình luận không thành công');
    });
  }

  static Future<void> getComment(String title) async {
    //print("Vào hàm get");
    List<String> lst = [];
    lstComments = List.filled(
        0,
        Comment(
          lstLike: [],
          title: "",
          nameUser: "",
          email: "",
          content: "",
          time: "",
        ),
        growable: true);
    var response = await FirebaseDatabase.instance.ref().child("comment").get();
    for (DataSnapshot comment in response.children) {
      if (comment.key.toString() == title) {
        for (DataSnapshot cmt in response.child(title).children) {
          for (var count = 0;
              count < cmt.child("lstLike").children.length;
              count++) {
            lst.add(
                cmt.child("lstLike").child(count.toString()).value.toString());
          }
          lstComments.add(Comment(
            lstLike: lst,
            content: cmt.child("content").value.toString(),
            email: cmt.child("email").value.toString(),
            time: cmt.child("time").value.toString(),
            nameUser: cmt.child("nameUser").value.toString(),
            title: title,
          ));
        }
        // print("Bài viết nè ${comment.key.toString()}");
      }
    }
  }
}
