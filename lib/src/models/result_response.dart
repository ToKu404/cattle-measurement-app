class ResultResponse {
  final int beratBadan;
  final int lingkarBadan;
  final int panjang;
  final int status;
  final int tinggi;

  const ResultResponse({
    required this.beratBadan,
    required this.lingkarBadan,
    required this.panjang,
    required this.status,
    required this.tinggi,
  });

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    return ResultResponse(
      beratBadan: json['beratbadan'],
      lingkarBadan: json['lingkarbadan'],
      panjang: json['panjang'],
      status: json['status'],
      tinggi: json['tinggi'],
    );
  }
}
