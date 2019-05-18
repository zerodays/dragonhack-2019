import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'api.dart';
import 'scanned_plant_view.dart';
import 'history_page.dart';

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
    return Scaffold(
      body: Column(children: [
        Container(height: 24.0,),
        AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
        Expanded(
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => HistoryPage()));
                    },
                    icon: Icon(Icons.history, color: Theme.of(context).accentColor,),
                  ),
                  FloatingActionButton(
                    child: Icon(Icons.panorama_fish_eye, color: Theme.of(context).backgroundColor,),
                    onPressed: () async {
                      String filename = join(
                        (await getTemporaryDirectory()).path,
                        '${DateTime.now()}.jpg',
                      );

                      await controller.takePicture(filename);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ScannedPlantView(() async {
                                return sendImage(filename);
                              }, filename)));
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.switch_camera, color: Theme.of(context).accentColor),
                  )
                ],
              )),
        )
      ]),
    );
  }
}
