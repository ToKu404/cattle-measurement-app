import 'package:cattle_app/core/constants/color_const.dart';
import 'package:cattle_app/src/models/configuration_entity.dart';
import 'package:cattle_app/src/repositories/menu_handler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatefulWidget {
  final ConfigurationEntity? configurationEntity;
  const ConfigurationPage({
    super.key,
    required this.configurationEntity,
  });

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final TextEditingController imageLength = TextEditingController();
  final TextEditingController imageWidth = TextEditingController();
  final TextEditingController objectDistance = TextEditingController();
  final TextEditingController objectRealLength = TextEditingController();
  final TextEditingController objectImageLength = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    imageLength.dispose();
    imageWidth.dispose();
    objectDistance.dispose();
    objectRealLength.dispose();
    objectImageLength.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.configurationEntity != null) {
      final data = widget.configurationEntity!;

      imageLength.text = data.panjang;
      imageWidth.text = data.lebar;
      objectDistance.text = data.panjang;
      objectRealLength.text = data.panjangMeter;
      objectImageLength.text = data.panjangPixel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfigurasi'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resolusi Gambar (Pixel)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputField(
                        controller: imageLength,
                        hint: 'Panjang',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputField(
                        controller: imageWidth,
                        hint: 'Lebar',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Jarak Kamera Dengan Object (meter)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            _InputField(
              controller: objectDistance,
              hint: 'Contoh: 100',
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Panjang Object (meter)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            _InputField(
              controller: objectRealLength,
              hint: 'Contoh: 100',
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Panjang Object (pixel)',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            _InputField(
              controller: objectImageLength,
              hint: 'Contoh: 100',
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
                final panjang = imageLength.text;
                final lebar = imageWidth.text;
                final jarak = objectDistance.text;
                final panjangMeter = objectRealLength.text;
                final panjangPixel = objectImageLength.text;
                if (panjang.isNotEmpty &&
                    lebar.isNotEmpty &&
                    jarak.isNotEmpty &&
                    panjangMeter.isNotEmpty &&
                    panjangPixel.isNotEmpty) {
                  final provider = context.read<MenuHandler>();
                  final config = ConfigurationEntity(
                      panjang: panjang,
                      jarak: jarak,
                      lebar: lebar,
                      panjangMeter: panjangMeter,
                      panjangPixel: panjangPixel);
                  provider.setConfigurationData(config);
                  final data = await provider.getConfigurationData();
                  if (data.jarak.isNotEmpty) {
                    const snackBar = SnackBar(
                      content: Text('Data Berhasil Disimpan'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pop(context);
                  }
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
                  'Simpan',
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
