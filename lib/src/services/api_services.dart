import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:multiplayer/src/common/dio/dio_client.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class ApiServices{

  static apiPostLeftToManage(apiPath,params) async {
    try {
      var response = await dio.post(apiPath, data: params);
      // if (response.statusCode == 200|| response!=null) {
      //   if (kDebugMode) {
      //   }
      //   return response;
      // } else {
      //   return null;
      // }
      return response;
    } on DioException catch (e) {
      if(e.response!=null){
        if(apiPath == "api/check-login") { 
          showToastMessage(e.response!.data['message'].toString());
        }
        else if(apiPath == "api/change-password") { 
          showToastMessage(e.response!.data['message'].toString());
        } 
        else if(apiPath == "api/shipping") { 
          if(e.response!.data['errors']!=null){
            e.response!.data['errors'].forEach((key, value){
              showToastMessage(e.response!.data['errors'][key][0]);
            });
          }
        } 
        else if(apiPath == "api/order"){
          if(e.response!.data['errors']!=null){
            e.response!.data['errors'].forEach((key, value){
              showToastMessage(e.response!.data['errors'][key][0]);
            });
          }
          else{
            showToastMessage(e.response!.data['message'].toString());
          }
        } 
        else if(e.response!.data.containsKey('errors')){
          log(e.response!.data['errors'].toString());
        }
        else{
          showToastMessage(e.response!.data['message'].toString());
          log(e.response!.data['message'].toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
  
  static apiPost(apiPath,params) async {
    try {
      var response = await dio.post(apiPath, data: params);
      if (response.statusCode == 200) {
        if (kDebugMode) {
        }
        return response.data;
      } else {
        return null;
      }
    } on DioException catch (e) {
      if(e.response!=null){
        if(apiPath == "api/check-login") { 
          showToastMessage(e.response!.data['message'].toString());
        }
        else if(apiPath == "api/change-password") { 
          showToastMessage(e.response!.data['message'].toString());
        } 
        else if(apiPath == "api/shipping") { 
          if(e.response!.data['errors']!=null){
            e.response!.data['errors'].forEach((key, value){
              showToastMessage(e.response!.data['errors'][key][0]);
            });
          }
        } 
        else if(apiPath == "api/order"){
          if(e.response!.data['errors']!=null){
            e.response!.data['errors'].forEach((key, value){
              showToastMessage(e.response!.data['errors'][key][0]);
            });
          }
          else{
            showToastMessage(e.response!.data['message'].toString());
          }
        } 
        else if(e.response!.data.containsKey('errors')){
          log(e.response!.data['errors'].toString());
        }
        else{
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
      if(apiPath == 'api/profile') {
        showToastMessage(e.response!.data['message'].toString());
        return e.response!.data;
      }
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