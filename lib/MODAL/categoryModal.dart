// To parse this JSON data, do
//
//     final categoryModal = categoryModalFromJson(jsonString);

import 'dart:convert';

class CategoryModal {
  CategoryModal({
    required this.number,
    required this.categoryName,
    required this.categoryId,
    required this.categoryImg,
  });

  String number;
  String categoryName;
  String categoryId;
  dynamic categoryImg;

  factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
        number: json["number"],
        categoryName: json["category_name"],
        categoryId: json["category_id"],
        categoryImg: json["category_img"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "category_name": categoryName,
        "category_id": categoryId,
        "category_img": categoryImg,
      };
}
