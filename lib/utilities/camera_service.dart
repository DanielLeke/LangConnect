import 'package:camera/camera.dart';

class Cameraservice {
  Future<List<CameraDescription>> getAvailableCameras() async {
    try {
      return await availableCameras();
    } catch (e) {
      print("Error getting cameras: $e");
      return [];
    }
  }

  Future<void> initializeCamera(CameraController controller) async {
    try {
      await controller.initialize();
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  Future<XFile> takePicture(CameraController controller) async {
    try {
      if (!controller.value.isInitialized) {
        throw Exception("Camera is not initialized");
      }
      XFile picture = await controller.takePicture();
      return picture;
    } catch (e) {
      print("Error taking picture: $e");
      rethrow;
    }
  }

  Future<void> dispose (CameraController controller) async {
    await controller.dispose();
  }
}
