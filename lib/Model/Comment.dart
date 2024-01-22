class Comment {
  String nameUser;
  String email;
  String content;
  String time;
  String title;
  List lstLike;

  Comment({
    required this.content,
    required this.email,
    required this.time,
    required this.nameUser,
    required this.title,
    required this.lstLike,
  });
}
