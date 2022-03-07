// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BlogModel {
  String Title;
  String Content;
  String Image;
  String CategoryId;
  String Id;
  BlogModel({
    required this.Title,
    required this.Content,
    required this.Image,
    required this.CategoryId,
    required this.Id,
  });

  BlogModel copyWith({
    String? Title,
    String? Content,
    String? Image,
    String? CategoryId,
    String? Id,
  }) {
    return BlogModel(
      Title: Title ?? this.Title,
      Content: Content ?? this.Content,
      Image: Image ?? this.Image,
      CategoryId: CategoryId ?? this.CategoryId,
      Id: Id ?? this.Id,
    );
  }


  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      Title: map['Title'] as String,
      Content: map['Content'] as String,
      Image: map['Image'] as String,
      CategoryId: map['CategoryId'] as String,
      Id: map['Id'] as String,
    );
  }


  factory BlogModel.fromJson(String source) => BlogModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlogModel(Title: $Title, Content: $Content, Image: $Image, CategoryId: $CategoryId, Id: $Id)';
  }


}
