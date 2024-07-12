class ResponseModel<R> {
  R? response;
  bool error;
  String? errorMessage;

  ResponseModel({this.response, this.errorMessage, this.error = false});
}
