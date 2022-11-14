import 'dart:convert';
import 'package:cattle_app/core/routes/app_routes.dart';
import 'package:cattle_app/src/models/response_image.dart';
import 'package:cattle_app/src/repositories/data_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../core/constants/color_const.dart';
import '../../../core/services/web_service.dart';
import '../../../widgets/input_widget.dart';
import '../../models/siluet_response.dart';

class SideViewPreviewPage extends StatefulWidget {
  final String imagePath;
  final int distance;

  const SideViewPreviewPage(
      {super.key, required this.imagePath, required this.distance});

  @override
  State<SideViewPreviewPage> createState() => _SideViewPreviewPageState();
}

class _SideViewPreviewPageState extends State<SideViewPreviewPage> {
  Future<SiluetResponse>? _future;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _future = post();
    controller.text = (widget.distance / 100).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<SiluetResponse>(
          future: _future,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Palette.secondary,
                        child: Column(
                          children: [
                            const Text(
                              'Pratinjau',
                              style: TextStyle(
                                color: Palette.gray1,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              color: Colors.black,
                              height: 320,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                snapshot.data!.siluet,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Jarak Samping (m)',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            InputField(
                              controller: controller,
                              hint: 'Contoh: 123',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  final provider = context.read<DataHandler>();
                                  provider.setJarakSamping(
                                      controller.text.toString());
                                  Navigator.pushNamed(
                                      context, AppRoute.backViewIntro);
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text(
                                        'Input Jarak Samping Terlebih Dahulu'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Palette.primary,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Palette.gray1,
                                ),
                              ),
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Ambil Ulang',
                                  style: TextStyle(color: Palette.secondary),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center();
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
    );
  }

  Future<bool?> errorCapture() {
    return Alert(
      context: context,
      closeFunction: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      type: AlertType.error,
      title: "Terjadi Kesalahan",
      style: const AlertStyle(
          titleStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              height: 1),
          descStyle: TextStyle(fontSize: 14, color: Palette.gray3, height: 1)),
      desc: 'Terjadi kesalahan proses pencitraan',
      buttons: [
        DialogButton(
          color: Palette.primary,
          child: const Text(
            "Ambil Ulang",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  Future<SiluetResponse> post() async {
    try {
      final provider = context.read<DataHandler>();
      final uri = Uri.parse('${WebService.baseUrl}/uploadsamping');
      final request = http.MultipartRequest('POST', uri)
        ..fields['kode'] = WebService.code
        ..files.add(
            await http.MultipartFile.fromPath('sapiFoto', widget.imagePath));
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseStatus =
            ResponseImage.fromJson(jsonDecode(response.body));
        if (responseStatus.responseCode == 1) {
          final data = SiluetResponse.fromJson(jsonDecode(response.body));
          provider.setIdFotoSamping(data.id.toString());
          return data;
        } else {
          throw Exception('Failed to send request');
        }
      } else {
        throw Exception('Failed to send request');
      }
    } catch (e) {
      errorCapture();
      throw Exception();
    }
  }
}
