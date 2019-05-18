import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'api.dart';
import 'scanned_plant_view.dart';

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
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Stack(alignment: Alignment.center, children: [
      AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      ),
      Padding(
          padding: EdgeInsets.all(32.0),
          child: FloatingActionButton(
            child: Icon(Icons.panorama_fish_eye),
            onPressed: () async {
              String filename = join(
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.jpg',
              );

              await controller.takePicture(filename);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ScannedPlantView(() async {
                        return sendImage(filename);
                      }, filename)));
            },
          ))
    ]);
  }
}
