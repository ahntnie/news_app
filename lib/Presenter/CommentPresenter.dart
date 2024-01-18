import 'package:news_app/Model/Comment.dart';
import 'package:news_app/Repository/CommentRepository.dart';

class CommentPresenter {
  static Future<void> setComment(Comment comment) async {
    return await CommentRepository.setComment(comment);
  }

  static Future<void> getComment(String title) async {
    return await CommentRepository.getComment(title);
  }
}
