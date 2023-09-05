import 'package:exp_man/services/networking.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';

part 'community_post.g.dart';

@JsonSerializable()
class CommunityPost with ChangeNotifier {
  int id = 0;
  String title = '';
  String content = '';
  String city = '';
  DateTime date = DateTime.now();
  String student = '';
  String image_url = '';
  int upvotes = 0;
  bool liked = false;
  bool bookmarked = false;
  CommunityPost();

  toggleBookMark(int studentId) {
    if (bookmarked) {
      bookmarked = false;
      notifyListeners();
      NetworkHelper().patchData(
          url: 'communityPost/update/bookmark/$id',
          jsonMap: {"student_id": studentId});
    } else {
      bookmarked = true;
      notifyListeners();
      NetworkHelper().patchData(
          url: 'communityPost/update/bookmark/$id',
          jsonMap: {"student_id": studentId});
    }
  }

  toggleLike(int studentId) {
    if (liked) {
      liked = false;
      upvotes = upvotes - 1;
      notifyListeners();
      NetworkHelper().patchData(
          url: 'communityPost/update/like/$id',
          jsonMap: {"student_id": studentId});
    } else {
      liked = true;
      upvotes = upvotes + 1;
      notifyListeners();
      NetworkHelper().patchData(
          url: 'communityPost/update/like/$id',
          jsonMap: {"student_id": studentId});
    }
  }

  factory CommunityPost.fromJson(Map<String, dynamic> json) =>
      _$CommunityPostFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityPostToJson(this);
}
