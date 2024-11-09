class NetworkResponse {
  final bool isSuccess;
  final int StatusCode;
  dynamic ResponseData;
  String errorMessage;

  NetworkResponse(
      {required this.isSuccess,
      required this.StatusCode,
      this.ResponseData,
      this.errorMessage='Something Went Wrong!'});
}
