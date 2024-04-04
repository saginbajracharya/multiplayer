import 'package:dio/dio.dart';
import 'package:multiplayer/src/common/constant.dart';
import 'package:multiplayer/src/common/dio/dio_interceptor.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: baseApiUrl,
    headers: <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
    receiveDataWhenStatusError: true,
  ),
)..interceptors.add(DioInterceptor());