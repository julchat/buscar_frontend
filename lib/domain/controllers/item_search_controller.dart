import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../objeto.dart';
import 'dart:io';


class ItemSearchController extends GetxController {
  final Rx<File?> _imageFile = Rx<File?>(null);
  final Rx<Objeto?> _objeto = Rx<Objeto?>(null);

  File? get imageFile => _imageFile.value;
  Objeto? get objeto => _objeto.value;

  // Función para abrir la cámara y tomar una foto
  Future<void> openCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
    }
  }

  // Función para abrir la galería y seleccionar una foto
  Future<void> openGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
    }
  }

  // Función para asignar el objeto después de realizar la búsqueda
  void setObjeto(Objeto objeto) {
    _objeto.value = objeto;
  }

  // Función para limpiar la foto tomada y el objeto después de realizar la búsqueda
  void clearImageAndObjeto() {
    _imageFile.value = null;
    _objeto.value = null;
  }
}
