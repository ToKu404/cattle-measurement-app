import 'package:cattle_app/core/constants/color_const.dart';
import 'package:cattle_app/core/routes/app_routes.dart';
import 'package:cattle_app/src/repositories/data_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CattleWeightPage extends StatefulWidget {
  const CattleWeightPage({
    super.key,
  });

  @override
  State<CattleWeightPage> createState() => _CattleWeightPageState();
}

class _CattleWeightPageState extends State<CattleWeightPage> {
  final TextEditingController cattleWight = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cattleWight.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berat Sapi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Input Berat Sapi',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            _InputField(
              controller: cattleWight,
              hint: 'Contoh: 80kg',
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
                final berat = cattleWight.text;

                if (berat.isNotEmpty) {
                  final provider = context.read<DataHandler>();
                  provider.setBeratSapi(berat);
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

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const _InputField({Key? key, required this.controller, required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {},
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      cursorColor: Palette.primary,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.gray4, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Palette.primary, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
