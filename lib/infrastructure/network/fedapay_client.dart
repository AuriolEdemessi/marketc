import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../export.dart';

@injectable
class FedapayClient {
  BaseOptions dioOptions = BaseOptions(
      baseUrl: getIt.get<FlavorConfig>().fedapayUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      contentType: Headers.jsonContentType);
  final Dio _dio = Dio();

  FedapayClient() {
    _dio.options = dioOptions;
    _dio.interceptors.add(FedaPayInterceptors());
  }

  Future<Response> get(
      {required String pathUrl,
      required String token,
      params,
      String? path}) async {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = "Bearer $token";
      String headers = "";
      options.headers.forEach((key, value) {
        headers += "$key: $value | ";
      });
      log("┌------------------------------------------------------------------------------");
      log('''| [DIO] Request: ${options.method} ${options.uri}
      | ${options.data.toString()}
      | Headers:$headers''');
      log("├------------------------------------------------------------------------------");

      return handler.next(options);
    }, onResponse: (response, handler) {
      log("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
      log("└------------------------------------------------------------------------------");
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));
    return await _dio.get(pathUrl);
  }

  Future<Response> post(
      {required String pathUrl, required String token, jsonBody}) async {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = "Bearer $token";
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (DioError err, handler) {
      return handler.next(err);
    }));
    return await _dio.post(pathUrl, data: jsonBody);
  }

  Future<Response> put({required String pathUrl, jsonBody}) async {
    return await _dio.put(pathUrl, data: jsonBody);
  }

  Future<Response> delete({required String pathUrl, jsonBody}) async {
    return await _dio.delete(pathUrl, data: jsonBody);
  }
}
