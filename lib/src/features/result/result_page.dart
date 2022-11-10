import 'dart:convert';

import 'package:cattle_app/src/models/response_image.dart';
import 'package:cattle_app/src/repositories/data_handler.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../core/constants/color_const.dart';
import '../../../core/services/web_service.dart';
import '../../models/result_response.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<ResultResponse>? _future;

  @override
  void initState() {
    super.initState();
    _future = post();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primary,
      body: FutureBuilder(
        future: _future,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hasi Prediksi',
                      style: TextStyle(
                        color: Palette.gray1,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                            color: Colors.black.withOpacity(.1),
                          ),
                        ],
                        color: Palette.gray1,
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildConfigurationCard(
                                  title: 'Prediksi Berat',
                                  data: '${snapshot.data!.beratBadan}',
                                ),
                              ]),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                buildConfigurationCard(
                                  title: 'Prediksi Lingkar Badan',
                                  data: '${snapshot.data!.lingkarBadan}',
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                buildConfigurationCard(
                                  title: 'Prediksi Panjang',
                                  data: '${snapshot.data!.panjang}',
                                ),
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Palette.gray1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () =>
                          Navigator.popUntil(context, (route) => route.isFirst),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Kembali',
                          style:
                              TextStyle(fontSize: 14, color: Palette.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Gagal menghitung berat badan'),
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.error.toString().substring(10),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                          child: Text(
                            'Kembali Ke Menu Utama',
                            style: TextStyle(
                              color: Palette.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }

  buildConfigurationCard({required String title, required String data}) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: Palette.secondary.withOpacity(.75)),
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                height: 1,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              data,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Palette.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ResultResponse> post() async {
    try {
      final provider = context.read<DataHandler>();

      final uri = Uri.parse('${WebService.baseUrl}/hitungberat');
      final request = http.MultipartRequest('POST', uri)
        ..fields['kode'] = WebService.code
        ..fields['idfotosamping'] = provider.resultEntity.idFotoSamping
        ..fields['jaraksamping'] = provider.resultEntity.jarakSamping
        ..fields['idfotobelakang'] = provider.resultEntity.idFotoBelakang
        ..fields['jarakbelakang'] = provider.resultEntity.jarakBelakang
        ..fields['idsapi'] = provider.resultEntity.idSapi
        ..fields['panjanggambar'] = provider.resultEntity.panjangGambar
        ..fields['jarakkamera'] = provider.resultEntity.jarakKamera
        ..fields['panjangmeter'] = provider.resultEntity.panjangMeter
        ..fields['panjangpixel'] = provider.resultEntity.panjangPixel
        ..fields['beratsapi'] = provider.resultEntity.beratSapi;
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseBody = ResponseImage.fromJson(jsonDecode(response.body));

        if (responseBody.responseCode == 1) {
          return ResultResponse.fromJson(jsonDecode(response.body));
        } else {
          throw Exception('Terdapat Masalah pada Hasil Prediksi');
        }
      } else {
        throw Exception('Terdapat Masalah pada Hasil Prediksi');
      }
    } catch (e) {
      throw Exception('Terdapat Masalah');
    }
  }
}
