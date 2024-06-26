import 'package:dio/dio.dart';

import 'error_model.dart';

//!ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException(this.errorModel);
}

//!CacheExeption
class CacheExeption implements Exception {
  final String errorMessage;

  CacheExeption({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

handleDioException(DioException e) {
  int statusCode = e.response?.statusCode ?? -1;
  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(
          ErrorModel.fromJson(e.response!.data, statusCode));
    case DioExceptionType.badCertificate:
      throw BadCertificateException(
          ErrorModel.fromJson(e.response!.data, statusCode));
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(
          ErrorModel.fromJson(e.response!.data, statusCode));

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
          ErrorModel.fromJson(e.response!.data, statusCode));

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
          ErrorModel.fromJson(e.response!.data, statusCode));

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw BadResponseException(
              ErrorModel.fromJson(e.response!.data, statusCode));

        case 401: //unauthorized
          throw UnauthorizedException(
              ErrorModel.fromJson(e.response!.data, statusCode));

        case 403: //forbidden
          throw ForbiddenException(
              ErrorModel.fromJson(e.response!.data, statusCode));

        case 404: //not found
          throw NotFoundException(
              ErrorModel.fromJson(e.response!.data, statusCode));

        case 409: //cofficient

          throw CofficientException(
              ErrorModel.fromJson(e.response!.data, statusCode));

        case 504: // Bad request

          throw BadResponseException(
              ErrorModel(status: 504, errorMessage: e.response!.data));
      }
      break;

    case DioExceptionType.cancel:
      throw CancelException(
          ErrorModel(errorMessage: e.toString(), status: 500));

    case DioExceptionType.unknown:
      throw UnknownException(
          ErrorModel(errorMessage: e.toString(), status: 500));
  }
}
