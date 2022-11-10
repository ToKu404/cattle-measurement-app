import 'package:camera/camera.dart';
import 'package:cattle_app/src/features/back_view/back_view_camera_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/color_const.dart';
import '../../repositories/data_handler.dart';

class BackViewIntroPage extends StatefulWidget {
  const BackViewIntroPage({super.key});

  @override
  State<BackViewIntroPage> createState() => _BackViewIntroPageState();
}

class _BackViewIntroPageState extends State<BackViewIntroPage> {
  late CameraDescription _cameraDescription;
  final TextEditingController _cattleDistanceController =
      TextEditingController();
  ValueNotifier<int> cattleDistance = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      _cameraDescription = value.first;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cattleDistanceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder(
              valueListenable: cattleDistance,
              builder: (context, val, _) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 64.0,
                  ),
                  child: Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 64.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            const Text(
                              'Gambar Belakang',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    'assets/images/belakang.png',
                                    height: 250,
                                    width: 250,
                                  ),
                                  Positioned.fill(
                                      right: 0,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Foto dinyatakan valid jika terdapat garis seperti gambar',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16,
                                                height: 1,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BackViewCameraPage(
                                        cameraDescription: _cameraDescription),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Palette.primary,
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              child: const Text(
                                'Buka Kamera',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Palette.gray1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
