import 'package:dio/dio.dart';

import '../../../export.dart';

class DioException implements Exception {
  ErrorMessage errorMessage= ErrorMessage();

  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = ErrorMessage(debug:"Request to the server was cancelled.", release:"Request to the server was cancelled.");
        break;
      case DioErrorType.connectTimeout:
        errorMessage = ErrorMessage(debug:"Connection timed out.", release:"Connection timed out.");
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = ErrorMessage(debug:"Receiving timeout occurred.", release:"Receiving timeout occurred.");
        break;
      case DioErrorType.sendTimeout:
        errorMessage = ErrorMessage(debug:"Request send timeout.", release:"Request send timeout.");
        break;
      case DioErrorType.response:
        errorMessage = _handleStatusCode(dioError.response?.statusCode, dioError.response?.data['message'].toString(), dioError.response?.data['errors'].cast<String>());
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage = ErrorMessage(debug:"No Internet.", release:"No Internet.");
          break;
        }
        errorMessage = ErrorMessage(debug:"Unexpected error occurred.", release:"Unexpected error occurred.");
        break;
      default:
        errorMessage = ErrorMessage(debug:"Something went wrong.", release:"Something went wrong.");
        break;
    }
  }

  ErrorMessage _handleStatusCode(int? statusCode, message, errors) {
    switch (statusCode) {
      case 400:
        return ErrorMessage(errors: errors, debug:message, release:"Bad request.");
      case 401:
        return ErrorMessage(errors: errors, debug:message, release:"Authentication failed.");
      case 403:
        return ErrorMessage(errors: errors, debug:message, release:"The authenticated user is not allowed to access the specified API endpoint.");
      case 404:
        return ErrorMessage(errors: errors, debug:message, release:"The requested resource does not exist.");
      case 405:
        return ErrorMessage(errors: errors, debug:message, release:"Method not allowed. Please check the Allow header for the allowed HTTP methods.");
      case 415:
        return ErrorMessage(errors: errors, debug:message, release:"Unsupported media type. The requested content type or version number is invalid.");
        case 422:
        return ErrorMessage(errors: errors, debug:message, release:"Data validation failed.");
      case 429:
        return ErrorMessage(errors: errors, debug:message, release:"Too many requests.");
      case 500:
        return ErrorMessage(errors: errors, debug:message, release:"Internal server error.");
      default:
        return ErrorMessage(errors: errors, debug:message, release:"Oops something went wrong!");
    }
  }

/*  @override
  String toString() => errorMessage;*/
}

