import 'package:camera/camera.dart';
import 'package:cattle_app/src/features/side_view/side_view_preview_page.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../../core/constants/color_const.dart';
import '../../services/tilt.dart';

class SideViewCameraPage extends StatefulWidget {
  final CameraDescription cameraDescription;
  const SideViewCameraPage({
    super.key,
    required this.cameraDescription,
  });

  @override
  State<SideViewCameraPage> createState() => _SideViewCameraPageState();
}

class _SideViewCameraPageState extends State<SideViewCameraPage> {
  late CameraController _controller;
  late Future<void> _initializedController;
  double res = 0;

  String degree = '0';
  ValueNotifier<int> height = ValueNotifier(100);
  ValueNotifier<bool> isHeightShow = ValueNotifier(false);

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
              return ValueListenableBuilder(
                  valueListenable: height,
                  builder: (context, valHeight, _) {
                    return Stack(
                      children: [
                        AspectRatio(
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
                                          width: 1, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          1.5 /
                                          _controller.value.aspectRatio,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              1.5 /
                                              _controller.value.aspectRatio,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: 100,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 4,
                                      left: 4,
                                      child: StreamBuilder<Tilt>(
                                        stream: DeviceTilt(
                                          samplingRateMs: 20,
                                          initialTilt: const Tilt(0, 0),
                                          filterGain: 0.1,
                                        ).stream,
                                        builder: (context, snapshot) {
                                          String der = '';
                                          int degre = 0;
                                          if (snapshot.hasData &&
                                              snapshot.data != null) {
                                            res = (valHeight /
                                                cos(snapshot.data!.xRadian));
                                            der = snapshot.data!.xDegrees
                                                .round()
                                                .toString();

                                            if (der.isNotEmpty) {
                                              degre = int.parse(der);
                                            }

                                            degree =
                                                '${res.round().toString()} cm';
                                          }
                                          return degre < 90
                                              ? Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Palette.primary
                                                        .withOpacity(
                                                      .7,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    degree,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                 
                                  ],
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              _controller.value.aspectRatio,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.5 /
                                              _controller.value.aspectRatio,
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 10,
                                bottom: 10,
                                child: ValueListenableBuilder(
                                    valueListenable: isHeightShow,
                                    builder: (context, isShow, _) {
                                      return Column(
                                        children: [
                                          if (isShow)
                                            RotatedBox(
                                              quarterTurns: -1,
                                              child: AnimatedContainer(
                                                duration: Duration(
                                                  seconds: 1,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12),
                                                  ),
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Palette.gray1),
                                                ),
                                                child: Slider(
                                                  min: 0,
                                                  max: 200,
                                                  divisions: 40,
                                                  thumbColor: Palette.primary,
                                                  inactiveColor: Palette.gray2,
                                                  activeColor:
                                                      Palette.secondary,
                                                  value: valHeight.toDouble(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      height.value =
                                                          value.toInt();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          InkWell(
                                            onTap: () =>
                                                isHeightShow.value = !isShow,
                                            child: Container(
                                              padding: const EdgeInsets.all(
                                                12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(.85),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  12,
                                                ),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Palette.gray1),
                                              ),
                                              child: Text(
                                                '${(height.value / 100).toStringAsFixed(1)} m',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            
                            ],
                          ),
                        ),
                        // Container(
                        //   height: MediaQuery.of(context).size.height,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: Center(
                        //     child: Container(
                        //       width: MediaQuery.of(context).size.width *
                        //           1.5 /
                        //           _controller.value.aspectRatio,
                        //       height: MediaQuery.of(context).size.width *
                        //           1.5 /
                        //           _controller.value.aspectRatio,
                        //       child: Stack(
                        //         children: [
                        //           Center(
                        //             child: Container(
                        //               height: 4,
                        //               width: 150,
                        //               decoration: BoxDecoration(
                        //                   color: Colors.red,
                        //                   border: Border.all(
                        //                     width: .5,
                        //                     color: Colors.white,
                        //                   ),
                        //                   borderRadius:
                        //                       BorderRadius.circular(12)),
                        //             ),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    );
                  });
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
                  builder: (context) => SideViewPreviewPage(
                    imagePath: image.path,
                    distance: res.round(),
                  ),
                ),
              );
            } catch (e) {
              debugPrint(e.toString());
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
