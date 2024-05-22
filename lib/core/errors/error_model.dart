class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map jsonData,int? statusCode) {
    return ErrorModel(
      errorMessage: jsonData["message"],
      status: statusCode ?? 400,
    );
  }
}
