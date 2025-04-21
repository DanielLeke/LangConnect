import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:langconnect/utilities/camera_service.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  late CameraController? _cameraController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShowCamera(_cameraController!),
        TakePicture(),
      ],
    );
  }
}

class ShowCamera extends StatefulWidget {
  const ShowCamera(CameraController cameraController, {
    super.key,
  });

  @override
  State<ShowCamera> createState() => _ShowCameraState();
}

class _ShowCameraState extends State<ShowCamera> {
  Cameraservice cameraservice = Cameraservice();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cameraservice.getAvailableCameras(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CameraDescription>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<CameraDescription> cameras = snapshot.data!;
            if (cameras.isNotEmpty) {
              CameraController cameraController =
                  CameraController(cameras[0], ResolutionPreset.high);
              return FutureBuilder(
                  future: cameraservice.initializeCamera(cameraController),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      return CameraPreview(
                        cameraController,
                        child: Stack(
                          children: [
                            CameraPreview(cameraController),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                icon: const Icon(Icons.camera),
                                onPressed: () async {
                                  try {
                                    XFile picture = await cameraservice
                                        .takePicture(cameraController);
                                    // Handle the picture taken (e.g., display it, save it, etc.)
                                  } catch (e) {
                                    print("Error taking picture: $e");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  });
            } else {
              return const Center(child: Text('No cameras found'));
            }
          } else {
            return const Center(child: Text('No cameras found'));
          }
        });
  }
}

class TakePicture extends StatelessWidget {
  const TakePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {}, icon: const Icon(Icons.camera));
  }
}
