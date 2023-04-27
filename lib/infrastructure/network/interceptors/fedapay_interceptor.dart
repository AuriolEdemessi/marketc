
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../services/hive_service.dart';

class FedaPayInterceptors extends Interceptor {
  FedaPayInterceptors();

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
  ) async {
    //String? token = await hive.getToken();
     options.headers['Accept'] = 'application/json';

   // if (token != null) options.headers['Authorization'] = "Bearer $token";

    String headers = "";
    options.headers.forEach((key, value) {
      headers += "$key: $value | ";
    });

    log("┌------------------------------------------------------------------------------");
    log('''| [DIO] Request: ${options.method} ${options.uri}
      | ${options.data.toString()}
      | Headers:$headers''') ;
    log("├------------------------------------------------------------------------------");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("| [DIO] Response [code ${response.statusCode}]: ${response.data.toString()}");
    log("└------------------------------------------------------------------------------");
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log("| [DIO] Error: ${err.error}: ${err.response?.toString()}");
    log("└------------------------------------------------------------------------------");
    super.onError(err, handler);
  }
}
