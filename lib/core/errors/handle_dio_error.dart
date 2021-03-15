import 'dart:io';
import 'package:dio/dio.dart';
import 'package:customerapp/core/errors/base_error.dart';
import 'package:customerapp/core/errors/socket_error.dart';
import 'package:customerapp/core/errors/timeout_error.dart';
import 'package:customerapp/core/errors/unauthorized_error.dart';
import 'package:customerapp/core/errors/unknown_error.dart';

import 'bad_request_error.dart';
import 'cancel_error.dart';
import 'conflict_error.dart';
import 'forbidden_error.dart';
import 'http_error.dart';
import 'internal_server_error.dart';
import 'net_error.dart';
import 'not_found_error.dart';

class Errors {

  static BaseError handleDioError(DioError error) {
    print('error.type = ${(error.type) }');
    if (error.type == DioErrorType.DEFAULT ||
        error.type == DioErrorType.RESPONSE) {
      if (error is SocketException) return SocketError();
      if (error.type == DioErrorType.RESPONSE) {
        print(error.response.statusCode);
        switch (error.response.statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();

          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.SEND_TIMEOUT ||
        error.type == DioErrorType.RECEIVE_TIMEOUT) {
      return TimeoutError();
    } else if (error.type == DioErrorType.CANCEL) {
      return CancelError();
    } else
      return UnknownError();
  }
}