import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:multiplayer/src/common/dio/dio_client.dart';
import 'package:multiplayer/src/services/debug_service.dart';
import 'package:multiplayer/src/widgets/toast_message_widget.dart';

class ApiServices{
  
  static apiPost(apiPath, params, {String? imagePath, String? imageFieldName}) async {
    try {
      DebugService().showLog('METHOD : POST || API Calling : $apiPath || PARAMS : $params');
      FormData? formData;
      if (params.isNotEmpty) {
        formData = FormData.fromMap(params);
      }
      if (imagePath != null && imageFieldName != null && formData != null) {
        formData.files.add(MapEntry(
          imageFieldName,
          await MultipartFile.fromFile(imagePath),
        ));
      }
      var response = await dio.post(apiPath, data: formData ?? {});
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
          DebugService().showLog(e.response!.data['errors'].toString());
        } else {
          showToastMessage(e.response!.data['message'].toString());
          DebugService().showLog(e.response!.data['message'].toString());
        }
      }
    } catch (e) {
      DebugService().showLog(e.toString());
    }
  }

  static apiGet(apiPath,queryParameters) async {
    try {
      DebugService().showLog('METHOD : GET \n API Calling : $apiPath\nQUERYPARAMS : $queryParameters');
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
      DebugService().showLog(e.message.toString());
    } catch (e) {
      DebugService().showLog(e.toString());
    }
  }
  
  static apiPut(apiPath,queryParameters) async {
    try {
      DebugService().showLog('METHOD : PUT || API Calling : $apiPath || QUERYPARAMS : $queryParameters');
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
      DebugService().showLog(e.message.toString());
    } catch (e) {
      DebugService().showLog(e.toString());
    }
  }

  static apiDelete(apiPath) async {
    try {
      DebugService().showLog('METHOD : DELETE || API Calling : $apiPath');
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
      DebugService().showLog(e.message.toString());
    } catch (e) {
      DebugService().showLog(e.toString());
    }
  }
  
}