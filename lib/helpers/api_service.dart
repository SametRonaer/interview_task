import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:http_parser/http_parser.dart';

class ApiService {
  static String _baseUrl = "http://test20.internative.net";
  static final Dio _dio = Dio();

  static Future<dynamic> sendGetRequest(String endPoint, String token) async {
    try {
      var response = await _dio.get(_baseUrl + endPoint,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> sendPostRequest(
      {required String endPoint, dynamic postData, String? token}) async {
    try {
      var response = await _dio.post(_baseUrl + endPoint,
          data: postData,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      String? responseMessage = response.data["Message"];
      if (responseMessage != null) {
        if (response.data["HasError"] == true) {
          getx.Get.snackbar("Hata meydana geldi!", responseMessage,
              backgroundColor: Colors.red.shade400);
        } else {
          getx.Get.snackbar("İşlem Başarılı!", responseMessage,
              backgroundColor: Colors.green.shade400);
        }
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadImage(String filePath, String token) async {
    String imageName = filePath.split("/").last;
    try {
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(filePath, filename: imageName)
      });
      var response = await _dio.post(_baseUrl + "/General/UploadImage",
          data: formData,
          options: Options(headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data"
          }));

      String imageUrl = response.data["Data"];
      return imageUrl;
    } catch (e) {
      print(e);
    }
  }
}
