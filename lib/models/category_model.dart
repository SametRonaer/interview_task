import 'dart:convert';

class CategoryModel {
  String? Title;
  String? Image;
  String? Id;
 
  CategoryModel({
    this.Title,
    this.Image,
    this.Id,
  });

  CategoryModel copyWith({
    String? Title,
    String? Image,
    String? Id,
  }) {
    return CategoryModel(
      Title: Title ?? this.Title,
      Image: Image ?? this.Image,
      Id: Id ?? this.Id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': Title,
      'Image': Image,
      'Id': Id,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      Title: map['Title'] != null ? map['Title'] as String : null,
      Image: map['Image'] != null ? map['Image'] as String : null,
      Id: map['Id'] != null ? map['Id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) => CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoryModel(Title: $Title, Image: $Image, Id: $Id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CategoryModel &&
      other.Title == Title &&
      other.Image == Image &&
      other.Id == Id;
  }

  @override
  int get hashCode => Title.hashCode ^ Image.hashCode ^ Id.hashCode;
}
