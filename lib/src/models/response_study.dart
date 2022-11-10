class ResponseStudy {
  int responseCode;
  String responseMsg;

  ResponseStudy(this.responseCode, this.responseMsg);

  factory ResponseStudy.fromJson(dynamic json) {
    return ResponseStudy(json['status'] as int, json['comment'] as String);
  }
}
