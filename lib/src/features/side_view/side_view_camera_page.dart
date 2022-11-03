import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:cattle_app/src/features/side_view/side_view_preview_page.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_const.dart';

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
                      SideViewPreviewPage(imagePath: image.path),
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