class ResponseImage {
  int responseCode;

  ResponseImage(this.responseCode);

  factory ResponseImage.fromJson(dynamic json) {
    return ResponseImage(json['status'] as int);
  }
}
