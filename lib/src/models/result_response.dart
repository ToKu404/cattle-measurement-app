class ResultResponse {
  final String? beratBadan;
  final String? lingkarBadan;
  final String? panjang;
  final int? status;

  const ResultResponse({
    required this.beratBadan,
    required this.lingkarBadan,
    required this.panjang,
    required this.status,
  });

  factory ResultResponse.fromJson(Map<String, dynamic> json) {
    return ResultResponse(
        beratBadan: json['beratbadan'],
        lingkarBadan: json['lingkarbadan'],
        panjang: json['panjang'],
        status: json['status']);
  }
}
