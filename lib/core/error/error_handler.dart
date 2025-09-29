import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:team_intelligence/core/error/exceptions.dart';
import 'package:team_intelligence/core/error/failures.dart';

class ErrorHandler {
  static Failure handleException(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(message: exception.message);
    }
    return UnknownFailure();
  }

  static Exception handleDioError(
    DioException error, {
    required String context,
  }) {
    final statusCode = error.response?.statusCode;
    String message;

    final responseData = error.response?.data;
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('message')) {
      message = responseData['message'].toString();
    } else {
      message = statusCode == 401 ? 'Unauthorized access' : 'An error occurred';
    }

    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      message = 'Connection timeout, check your internet';
      dev.log(
        '$context Error: $message',
        name: context,
        error: error,
        stackTrace: error.stackTrace,
      );
      return NetworkException(message: message);
    }

    if (responseData == null ||
        (responseData is Map && !responseData.containsKey('message'))) {
      switch (statusCode) {
        case 400:
          message = 'Invalid request data';
          break;
        case 401:
          message = 'Unauthorized access';
          break;
        case 403:
          message = 'Access forbidden';
          break;
        case 404:
          message = 'Resource not found';
          break;
        case 409:
          message = 'Conflict error, resource already exists';
          break;
        case 500:
          message = 'Server error, please try again later';
          break;
      }
    }

    dev.log(
      '$context Error: $message (Status: $statusCode)',
      name: context,
      error: error,
      stackTrace: error.stackTrace,
    );

    return statusCode == 401
        ? UnauthorizedException(message: message, statusCode: statusCode)
        : ServerException(message: message, statusCode: statusCode);
  }
}
