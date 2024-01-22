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
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      title: json['title'],
      email: json['email'],
      content: json['content'],
      time: json['time'],
      lstLike: json['lstLike'],
      nameUser: json['nameUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'email': email,
      'content': content,
      'time': time,
      'lstLike': lstLike,
      'nameUser': nameUser
    };
  }
}
