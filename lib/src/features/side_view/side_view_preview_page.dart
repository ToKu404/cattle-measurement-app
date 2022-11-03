import 'dart:convert';
import 'package:cattle_app/core/routes/app_routes.dart';
import 'package:cattle_app/src/repositories/data_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../core/constants/color_const.dart';
import '../../../core/services/web_service.dart';
import '../../../widgets/input_widget.dart';
import '../../models/siluet_response.dart';

class SideViewPreviewPage extends StatefulWidget {
  final String imagePath;

  const SideViewPreviewPage({super.key, required this.imagePath});

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SiluetResponse>(
        future: _future,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Palette.secondary,
                        child: SafeArea(
                          child: Column(children: [
                            const Padding(padding: EdgeInsets.only(top: 64.0)),
                            const Text(
                              'Pratinjau',
                              style: TextStyle(
                                color: Palette.gray1,
                                fontSize: 32.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      '${snapshot.data?.siluet}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Input Jarak Samping',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                InputField(
                                  controller: controller,
                                  hint: 'Contoh: 123',
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (controller.text.isNotEmpty) {
                                      final provider =
                                          context.read<DataHandler>();
                                      provider.setJarakSamping(
                                          controller.text.toString());
                                      Navigator.pushNamed(
                                          context, AppRoute.backViewIntro);
                                    } else {
                                      const snackBar = SnackBar(
                                        content: Text(
                                            'Input Jarak belakang Terlebih Dahulu'),
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
                                      style:
                                          TextStyle(color: Palette.secondary),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  Future<SiluetResponse> post() async {
    final provider = context.read<DataHandler>();
    final uri = Uri.parse('${WebService.baseUrl}/uploadsamping');
    final request = http.MultipartRequest('POST', uri)
      ..fields['kode'] = WebService.code
      ..files
          .add(await http.MultipartFile.fromPath('sapiFoto', widget.imagePath));
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      final data = SiluetResponse.fromJson(jsonDecode(response.body));
      provider.setIdFotoSamping(data.id.toString());
      return data;
    } else {
      throw Exception('Faild to send request');
    }
  }
}
