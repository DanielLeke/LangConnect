import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:langconnect/utilities/camera_service.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> with WidgetsBindingObserver {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeControllerFuture = _initializeCamera(); // Assign the future here
  }

  Future<void> _initializeCamera() async {
    try {
      // Get the list of available cameras
      final cameras = await Cameraservice().getAvailableCameras();
      if (cameras.isNotEmpty) {
        // Initialize the camera controller with the first available camera
        _cameraController = CameraController(
          cameras[0],
          ResolutionPreset.high,
        );
        await Cameraservice().initializeCamera(_cameraController);
        setState(() {}); // Rebuild the widget after initialization
      } else {
        throw Exception("No cameras found");
      }
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  IconData icon = Icons.flash_on_rounded;

  void changeIcon(IconData newIcon) {
    setState(() {
      icon = newIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture, // Use the future here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print("Error in FutureBuilder: ${snapshot.error}");
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          if (!_cameraController.value.isInitialized) {
            return const Center(child: CircularProgressIndicator());
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final screenAspectRatio =
                  constraints.maxWidth / constraints.maxHeight;

              return Stack(
                children: [
                  // CameraPreview as the background
                  AspectRatio(
                    aspectRatio: screenAspectRatio,
                    child: CameraPreview(_cameraController),
                  ),

                  // Take Picture button positioned at the bottom center
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const TakePicture(),
                          PutOnFlash(
                            controller: _cameraController,
                            changeIcon: changeIcon,
                            icon: icon,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    Cameraservice().dispose(_cameraController);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class TakePicture extends StatelessWidget {
  const TakePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Add functionality to take a picture
      },
      icon: const Icon(
        Icons.camera_alt,
        color: Colors.white,
      ),
    );
  }
}

class PutOnFlash extends StatefulWidget {
  final Function(IconData) changeIcon;
  final IconData icon;
  final CameraController controller;
  const PutOnFlash({
    super.key,
    required this.changeIcon,
    required this.icon,
    required this.controller,
  });

  @override
  State<PutOnFlash> createState() => _PutOnFlashState();
}

class _PutOnFlashState extends State<PutOnFlash> {
  late IconData _icon;

  @override
  void initState() {
    super.initState();
    _icon = widget.icon;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Cameraservice cameraservice = Cameraservice();
        // Toggle the icon
        if (_icon == Icons.flash_on_rounded) {
          widget.changeIcon(Icons.flash_off_rounded);
          setState(() {
            _icon = Icons.flash_off_rounded;
          });
        } else {
          widget.changeIcon(Icons.flash_on_rounded);
          setState(() {
            _icon = Icons.flash_on_rounded;
          });
        }
        await cameraservice.toggleFlash(
          widget.controller,
          _icon == Icons.flash_on_rounded ? FlashMode.torch : FlashMode.off,
        );
        const Duration(seconds: 3);
        await cameraservice.toggleFlash(
          widget.controller,
          _icon == Icons.flash_on_rounded ? FlashMode.always : FlashMode.off,
        );
      },
      icon: Icon(
        _icon,
        color: Colors.white,
      ),
    );
  }
}
