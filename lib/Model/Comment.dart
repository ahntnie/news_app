import 'dart:ffi';

class Comment {
  String nameUser;
  String email;
  String content;
  String time;
  bool like;
  String title;
  bool delete;
  Comment(
      {required this.content,
      required this.email,
      required this.like,
      required this.time,
      required this.nameUser,
      required this.title,
      required this.delete});
}
