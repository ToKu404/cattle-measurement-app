class SiluetResponse {
  final int id;
  final String siluet;
  final int status;

  const SiluetResponse({
    required this.id,
    required this.siluet,
    required this.status,
  });

  factory SiluetResponse.fromJson(Map<String, dynamic> json) {
    return SiluetResponse(
      id: json['id'],
      siluet: json['siluet'],
      status: json['status'],
    );
  }
}
