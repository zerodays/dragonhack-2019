import 'package:flutter/material.dart';
import 'package:camera/camera.dart';


List<CameraDescription> allCameras;


class CameraView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CameraViewState();
  }
}

class CameraViewState extends State<CameraView> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(allCameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }

}