
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../export.dart';

@injectable
class BaseApiClient {

  BaseOptions dioOptions = BaseOptions(
   baseUrl: getIt.get<FlavorConfig>().baseUrl, connectTimeout: 30000, receiveTimeout: 30000, contentType: Headers.jsonContentType);
   final Dio _dio = Dio();

  BaseApiClient(){
    _dio.options=dioOptions;
    _dio.interceptors.add(CustomInterceptors());
  }

  Future<Response> get({
    required String pathUrl,
     params,
    String? path
  }) async {
    //_dio.options.headers['content-Type'] = "application/json";
    //_dio.interceptors.clear();
   // _dio.interceptors.add(CustomInterceptors());
    return await _dio.get(pathUrl);
  }

  Future<Response> post({
    required String pathUrl,
     jsonBody
  }) async {
    //_dio.options.headers['content-Type'] = "application/json";
    //_dio.interceptors.clear();
   // _dio.interceptors.add(CustomInterceptors());
    return await _dio.post(pathUrl,data: jsonBody);
  }

  Future<Response> put({
    required String pathUrl,
     jsonBody
  }) async {
    //_dio.options.headers['content-Type'] = "application/json";
   // _dio.interceptors.clear();
   // _dio.interceptors.add(CustomInterceptors());
    return await _dio.put(pathUrl, data: jsonBody);
  }

  Future<Response> delete({
    required String pathUrl,
     jsonBody
  }) async {
     //_dio.options.headers['content-Type'] = "application/json";
    //_dio.interceptors.clear();
    //_dio.interceptors.add(CustomInterceptors());
    return await _dio.delete(pathUrl, data: jsonBody);
  }




  String handleResponse(Response<dynamic> res) {
    final Map<String, dynamic> response = jsonDecode(res.toString());

    if (res.statusCode =="200") {
      return res.toString();
    } else if (res.statusCode == "501") {
      throw ServerException(message: 'Server Error, Bad Gateway!');
    } else {
      throw ServerException(message: response['code']);
    }
  }

  Object handleError(Object error) {
    if (error is DioError) {
      final Map<String, dynamic> response = error.response != null
          ? jsonDecode(error.response.toString())
          : {'code': 'error unidentified'} ;
      throw ServerException(message: response['code']);
    } else {
      throw ServerException(message: 'not working');
    }
  }
}