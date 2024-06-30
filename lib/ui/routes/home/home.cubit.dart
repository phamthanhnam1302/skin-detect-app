import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health/ui/routes/home/home.state.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  late final CameraController camController;
  late final List<CameraDescription> _cams;
  int _currentCam = 0;

  Future<void> initialize() async {
    emit(state.copyWith(
      status: null,
    ));
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      _cams = await availableCameras();
      camController = CameraController(
        _cams[_currentCam],
        ResolutionPreset.max,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await camController.initialize();
    }
    emit(state.copyWith(
      status: status,
    ));
  }

  @override
  Future<void> close() async {
    await camController.dispose();
    await super.close();
  }

  void requestPermission() {
    Permission.camera.request().whenComplete(() {
      initialize();
    });
  }

  void openSettings() {
    openAppSettings().whenComplete(() {
      initialize();
    });
  }

  void switchCam() {
    _currentCam = (_currentCam + 1) % _cams.length;
    camController.setDescription(_cams[_currentCam]);
  }

  Future<String> capture() async {
    final value = await camController.takePicture();
    final cachePath = (await getApplicationCacheDirectory()).path;
    final path = join(
      cachePath,
      '${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await value.saveTo(path);
    return path;
  }
  
  Future<String?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: false,
    );
    return result?.files.firstOrNull?.path;
  }

  void pauseCam() {
    camController.pausePreview();
  }

  void resumeCam() {
    camController.resumePreview();
  }
}
