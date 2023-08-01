import 'package:buscar_app/domain/controllers/loading_controller.dart';
import 'package:buscar_app/presentation/screens/loading_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import '../../infrastructure/conector_backend.dart';
import '../objeto.dart';
import 'dart:io';

class ItemSearchController extends GetxController {
  final Rx<File?> _imageFile = Rx<File?>(null);
  final Rx<Objeto?> _objeto = Rx<Objeto?>(null);

  File? get imageFile => _imageFile.value;
  Objeto? get objeto => _objeto.value;

  // Función para abrir la cámara y tomar una foto
  Future<void> openCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);

      iniciarBusqueda();

    }
  }

  void iniciarBusqueda() async{
          Get.off(() => const LoadingScreen());
      ConectorBackend servidor = ConectorBackend(
          ruta: '/buscar_objeto',
          body: <String, String>{},
          method: HttpMethod.post);
      Get.find<LoadingController>()
          .handleServerResponseSearchItem(await servidor.hacerRequest());
  }

  // Función para abrir la galería y seleccionar una foto
  Future<void> openGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _imageFile.value = File(pickedFile.path);
    }
  }

  // Función para asignar el objeto después de realizar la búsqueda
  void setObjeto(Objeto objeto) {
    _objeto.value = objeto;
  }

  void clearImage() {
    _imageFile.value = null;
  }

  // Función para limpiar la foto tomada y el objeto después de realizar la búsqueda
  void clearImageAndObjeto() {
    _imageFile.value = null;
    _objeto.value = null;
  }
}
