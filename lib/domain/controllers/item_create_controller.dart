import 'dart:io';

import 'package:buscar_app/domain/controllers/bind_objects_controller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ItemCreateController extends GetxController {
  final RxList<File> capturedPhotos = <File>[].obs;
  final RxBool isCapturing = false.obs;
  final BindObjectsController proxPaso = Get.find<BindObjectsController>();


  void addCapturedPhoto(String path) {
    final File imageToAdd = File(path);
    capturedPhotos.add(imageToAdd);
    proxPaso.agregarFoto((imageToAdd));
  }

  // Método para eliminar una foto de la lista
  void removePhoto(File image, int index) {
    capturedPhotos.remove(image);
    proxPaso.quitarFoto(index);
  }

  void deletePhotos() {
    capturedPhotos.value = <File>[];
    proxPaso.resetState();
  }

  Future<void> startCapture2() async {
    final pickedPhotos = await ImagePicker().pickMultiImage();
    for(XFile element in pickedPhotos) {
      addCapturedPhoto(element.path);
    }
  }

  Future<void> startCapture() async {
    isCapturing.value = true;
    readInstructions();
    while (isCapturing.value) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) {
        stopCapture(); // Detener captura si el usuario cancela
      } else {
        addCapturedPhoto(pickedFile.path);
      }
      // Agregar solo si pickedFile no es nulo
    }
  }

  void stopCapture() {
    isCapturing.value = false;
  }

  void readInstructions() async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage('es');
    while (isCapturing.isTrue) {
      await tts.speak('Presione el botón de atrás para finalizar las capturas');
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  void setNombresUsados(List<String> nombresUsados) {
    proxPaso.setNombresUsados(nombresUsados);
  }
}

