import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:cattle_app/src/features/back_view/back_view_preview_page.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_const.dart';
import '../../services/tilt.dart';

class BackViewCameraPage extends StatefulWidget {
  final CameraDescription cameraDescription;
  const BackViewCameraPage({super.key, required this.cameraDescription});

  @override
  State<BackViewCameraPage> createState() => _BackViewCameraPageState();
}

class _BackViewCameraPageState extends State<BackViewCameraPage> {
  late CameraController _controller;
  late Future<void> _initializedController;
  String degree = '0';
  ValueNotifier<int> height = ValueNotifier(100);

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameraDescription,
      ResolutionPreset.high,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _initializedController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: _initializedController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: 1 / _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    _controller.buildPreview(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width *
                            1.5 /
                            _controller.value.aspectRatio,
                        height: MediaQuery.of(context).size.width *
                            1.5 /
                            _controller.value.aspectRatio,
                        decoration: ShapeDecoration(
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(
                                    width: 1, color: Colors.white))),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width *
                            1.5 /
                            _controller.value.aspectRatio,
                        height: MediaQuery.of(context).size.width *
                            1.5 /
                            _controller.value.aspectRatio,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: 100,
                            height: 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                          Colors.black54, BlendMode.srcOut),
                      child: Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    1.5 /
                                    _controller.value.aspectRatio,
                                height: MediaQuery.of(context).size.width *
                                    1.5 /
                                    _controller.value.aspectRatio,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: ValueListenableBuilder(
                              valueListenable: height,
                              builder: (context, val, _) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Palette.gray4.withOpacity(.6),
                                    borderRadius: BorderRadius.circular(
                                      24.0,
                                    ),
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: 200,
                                    divisions: 40,
                                    thumbColor: Palette.primary,
                                    inactiveColor: Palette.gray2,
                                    label: '${height.value} cm',
                                    activeColor: Palette.secondary,
                                    value: val.toDouble(),
                                    onChanged: (value) {
                                      setState(() {
                                        height.value = value.toInt();
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            right: 10,
                            bottom: 10,
                            child: StreamBuilder<Tilt>(
                              stream: DeviceTilt(
                                samplingRateMs: 20,
                                initialTilt: const Tilt(0, 0),
                                filterGain: 0.1,
                              ).stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data != null) {
                                  degree =
                                      '${snapshot.data!.xDegrees.round().toString()}°';
                                }
                                return Container(
                                  width: 60,
                                  height: 60,
                                  padding: EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    color: Palette.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      degree,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Palette.primary,
              ),
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: FloatingActionButton(
          onPressed: () async {
            try {
              await _initializedController;
              await _controller.setFlashMode(FlashMode.off);
              final image = await _controller.takePicture();
              if (!mounted) {
                return;
              }
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      BackViewPreviewPage(imagePath: image.path),
                ),
              );
            } catch (e) {
              log(e.toString());
            }
          },
          backgroundColor: Palette.secondary,
          child: const Icon(Icons.camera_alt),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
