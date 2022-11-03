import 'package:cattle_app/core/constants/color_const.dart';
import 'package:cattle_app/core/routes/app_routes.dart';
import 'package:cattle_app/src/models/configuration_entity.dart';
import 'package:cattle_app/src/repositories/data_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/input_widget.dart';

class CattleIdPage extends StatefulWidget {
  const CattleIdPage({
    super.key,
  });

  @override
  State<CattleIdPage> createState() => _CattleIdPageState();
}

class _CattleIdPageState extends State<CattleIdPage> {
  final TextEditingController cattleId = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cattleId.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID Sapi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input #Id Sapi',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            InputField(
              controller: cattleId,
              hint: 'Contoh: 123',
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              onPressed: () async {
                final berat = cattleId.text;

                if (berat.isNotEmpty) {
                  final provider = context.read<DataHandler>();
                  provider.setIdSapi(berat);
                  Navigator.pushNamed(context, AppRoute.sideViewIntro);
                } else {
                  const snackBar = SnackBar(
                    content: Text('Input Data Konfigurasi Salah'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Lanjut',
                  style: TextStyle(fontSize: 14, color: Palette.gray1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
