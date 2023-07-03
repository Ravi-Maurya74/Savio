// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityPost _$CommunityPostFromJson(Map<String, dynamic> json) =>
    CommunityPost()
      ..id = json['id'] as int
      ..title = json['title'] as String
      ..content = json['content'] as String
      ..city = json['city'] as String
      ..date = DateTime.parse(json['date'] as String)
      ..student = json['student'] as String
      ..image_url = json['image_url'] as String
      ..upvotes = json['upvotes'] as int
      ..liked = json['liked'] as bool
      ..bookmarked = json['bookmarked'] as bool;

Map<String, dynamic> _$CommunityPostToJson(CommunityPost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'city': instance.city,
      'date': instance.date.toIso8601String(),
      'student': instance.student,
      'image_url': instance.image_url,
      'upvotes': instance.upvotes,
      'liked': instance.liked,
      'bookmarked': instance.bookmarked,
    };
