import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:multiplayer/src/common/dio/dio_client.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class ApiServices{
  
  static apiPost(apiPath, params, {String? imagePath, String? imageFieldName}) async {
    try {
      var formData = FormData.fromMap(params);
      if (imagePath != null && imageFieldName != null) {
        formData.files.add(MapEntry(
          imageFieldName,
          await MultipartFile.fromFile(imagePath),
        ));
      }

      var response = await dio.post(apiPath, data: formData);
      if (response.statusCode == 200) {
        if (kDebugMode) {
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.data.containsKey('errors')) {
          log(e.response!.data['errors'].toString());
        } else {
          showToastMessage(e.response!.data['message'].toString());
          log(e.response!.data['message'].toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static apiGet(apiPath,queryParameters) async {
    try {
      var response = await dio.get(apiPath, queryParameters: queryParameters==''?{}:queryParameters);
      if (response.statusCode == 200) {
        if (kDebugMode) {
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if(e.response!=null){
        showToastMessage(e.response!.data['message'].toString());
      }
      log(e.message.toString());
    } catch (e) {
      log(e.toString());
    }
  }
  
  static apiPut(apiPath,queryParameters) async {
    try {
      var response = await dio.put(apiPath, data: queryParameters);
      if (response.statusCode == 200) {
        if (kDebugMode) {
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if(e.response!=null){
        showToastMessage(e.response!.data['message'].toString());
      }
      log(e.message.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  static apiDelete(apiPath) async {
    try {
      var response = await dio.delete(apiPath);
      if (response.statusCode == 200) {
        if (kDebugMode) {
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if(e.response!=null){
        showToastMessage(e.response!.data['message'].toString());
      }
      log(e.message.toString());
    } catch (e) {
      log(e.toString());
    }
  }
  
}