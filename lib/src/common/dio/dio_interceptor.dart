import 'package:dio/dio.dart';
import 'package:multiplayer/src/common/read_write_storage.dart';

class DioInterceptor extends Interceptor {
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    String? currentApitoken = await read(StorageKeys.currentApiToken);
    options.headers['Authorization'] = 'Bearer $currentApitoken';
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(response, ResponseInterceptorHandler handler) async {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401) { 
    } else if(err.response?.statusCode == 503) {
    }
    return super.onError(err, handler);
  }

}