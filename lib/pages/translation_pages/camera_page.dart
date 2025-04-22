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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture, // Use the future here
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Column(
            children: [
              Expanded(
                child: CameraPreview(_cameraController),
              ),
              const TakePicture(),
            ],
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
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
      icon: const Icon(Icons.camera_alt),
    );
  }
}
