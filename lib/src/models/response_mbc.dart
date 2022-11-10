class ResponseMbc {
  String responseCode;
  String responseMsg;

  ResponseMbc(this.responseCode, this.responseMsg);

  factory ResponseMbc.fromJson(dynamic json) {
    return ResponseMbc(
        json['responsecode'] as String, json['responsemsg'] as String);
  }
}
