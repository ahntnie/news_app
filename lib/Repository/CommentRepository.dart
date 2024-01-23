import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:news_app/Model/Comment.dart';
import 'package:news_app/Repository/UserRepository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static Future<List<Comment>> getUserComment(String? email) async {
    List<Comment> lstCmt = List.filled(
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
    List<String> lst = [];

    var response = await FirebaseDatabase.instance.ref().child("comment").get();
    for (DataSnapshot title in response.children) {
      for (DataSnapshot cmt in title.children) {
        if (cmt.child("email").value.toString() == UserRepository.user.email) {
          lst = [];
          if (cmt.child("lstLike").children.isEmpty) {
            lst = [];
          } else {
            for (var count = 0;
                count < cmt.child("lstLike").children.length;
                count++) {
              lst.add(cmt
                  .child("lstLike")
                  .child(count.toString())
                  .value
                  .toString());
            }
          }
          lstCmt.add(Comment(
            lstLike: lst,
            content: cmt.child("content").value.toString(),
            email: cmt.child("email").value.toString(),
            time: cmt.child("time").value.toString(),
            nameUser: cmt.child("nameUser").value.toString(),
            title: cmt.child("title").value.toString(),
          ));
        }
      }
      // print("Bài viết nè ${comment.key.toString()}");
    }
    return lstCmt;
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
          lst = [];
          if (cmt.child("lstLike").children.isEmpty) {
            lst = [];
          } else {
            for (var count = 0;
                count < cmt.child("lstLike").children.length;
                count++) {
              lst.add(cmt
                  .child("lstLike")
                  .child(count.toString())
                  .value
                  .toString());
            }
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

  static List<Comment> lstCmts = [];
  static Future<List<Comment>> loadNotiCmt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove('lstNotification');
    List<String> viewedCmtsJsonList =
        prefs.getStringList('lstNotification') ?? [];
    List<Comment> viewedCmts = viewedCmtsJsonList
        .map((json) => Comment.fromJson(jsonDecode(json)))
        .toList();
    lstCmts = viewedCmts;
    return viewedCmts;
  }

  static Future<void> saveNotiCmt(List<Comment> lstNotification) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> viewedCmtJsonList = lstNotification
        .map((comments) => jsonEncode(comments.toJson()))
        .toList();
    await prefs.setStringList('lstNotification', viewedCmtJsonList);
  }
}
