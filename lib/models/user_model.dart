// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';


class UserModel {
  String Id;
  String Email;
  String? Image;
  List<dynamic> FavoriteBlogIds;
  Map<String, dynamic>? Location;
  UserModel({
    required this.Id,
    required this.Email,
    this.Image,
    required this.FavoriteBlogIds,
    this.Location,
  });

  UserModel copyWith({
    String? Id,
    String? Email,
    String? Image,
    List<dynamic>? FavoriteBlogIds,
    Map<String, dynamic>? Location,
  }) {
    return UserModel(
      Id: Id ?? this.Id,
      Email: Email ?? this.Email,
      Image: Image ?? this.Image,
      FavoriteBlogIds: FavoriteBlogIds ?? this.FavoriteBlogIds,
      Location: Location ?? this.Location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'Email': Email,
      'Image': Image,
      'FavoriteBlogIds': FavoriteBlogIds,
      'Location': Location,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      Id: map['Id'] as String,
      Email: map['Email'] as String,
      Image: map['Image'] != null ? map['Image'] as String : null,
      FavoriteBlogIds: List<dynamic>.from((map['FavoriteBlogIds'] as List<dynamic>)),
     Location: map['Location'] != null ? Map<String, dynamic>.from((map['Location'] as Map<String, dynamic>)) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(Id: $Id, Email: $Email, Image: $Image, FavoriteBlogIds: $FavoriteBlogIds, Location: $Location)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.Id == Id &&
      other.Email == Email &&
      other.Image == Image &&
      listEquals(other.FavoriteBlogIds, FavoriteBlogIds) &&
      mapEquals(other.Location, Location);
  }

  @override
  int get hashCode {
    return Id.hashCode ^
      Email.hashCode ^
      Image.hashCode ^
      FavoriteBlogIds.hashCode ^
      Location.hashCode;
  }
}
