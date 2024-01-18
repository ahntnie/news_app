import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Model/Comment.dart';

class CommentRepository {
  static List<Comment> lstComments = List.filled(
      0,
      Comment(
        title: "",
        nameUser: "",
        email: "",
        content: "",
        time: "",
        like: 0,
      ),
      growable: true);
  static Future<void> setComment(Comment comment) async {
    var _comment = {
      "nameUser": comment.nameUser,
      "email": comment.email,
      "content": comment.content,
      "time": comment.time,
      "like": comment.like.toString(),
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

  static Future<void> getComment(String title) async {
    //print("Vào hàm get");
    var response = await FirebaseDatabase.instance.ref().child("comment").get();
    // print("ê fen ${response.value}");
    //print("abc cc ${response.children.first.value}");

    for (DataSnapshot comment in response.children) {
      if (comment.key.toString() == title) {
        for (DataSnapshot cmt in response.child(title).children) {
          if (response.children.length > lstComments.length) {
            lstComments.add(Comment(
              content: cmt.child("content").value.toString(),
              email: cmt.child("email").value.toString(),
              like: int.parse(cmt.child("like").value.toString()),
              time: cmt.child("time").value.toString(),
              nameUser: cmt.child("nameUser").value.toString(),
              title: title,
            ));
          }
        }
        print("Bài viết nè ${comment.key.toString()}");

        //print("Comment nè ${comment.value.toString()}");
      }
    }
  }
}
