import 'package:camera/camera.dart';
import 'package:cattle_app/src/features/side_view/side_view_camera_page.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_const.dart';

class SideViewIntroPage extends StatefulWidget {
  const SideViewIntroPage({super.key});

  @override
  State<SideViewIntroPage> createState() => _SideViewIntroPageState();
}

class _SideViewIntroPageState extends State<SideViewIntroPage> {
  late CameraDescription _cameraDescription;
  final TextEditingController _cattleDistanceController =
      TextEditingController();

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
    // final args = ModalRoute.of(context)!.settings.arguments as PhotoCaptureArgs;

    return GestureDetector(
      onTap: () {
        FocusNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Palette.secondary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                        ),
                        Center(
                          child: const Text(
                            'Gambar Samping',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/samping.png',
                                height: 250,
                                width: 250,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Foto dinyatakan valid jika terdapat garis seperti gambar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
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
                                builder: (context) => SideViewCameraPage(
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
            ),
          ),
        ),
      ),
    );
  }
}
