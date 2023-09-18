import 'dart:io';

import 'package:buscar_app/domain/controllers/bind_objects_controller.dart';
import 'package:buscar_app/presentation/screens/items_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../presentation/screens/bind_objects_screen.dart';

class ItemCreateController extends GetxController {
  final RxList<File> capturedPhotos = <File>[].obs;
  final RxBool isCapturing = false.obs;
  final BindObjectsController proxPaso = Get.find<BindObjectsController>();

  void addCapturedPhoto(String path) {
    final File imageToAdd = File(path);
    capturedPhotos.add(imageToAdd);
    proxPaso.agregarFoto(Image.file(imageToAdd));
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
    pickedPhotos.forEach((element) {
      addCapturedPhoto(element.path);
    });
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
}

class CapturePhotosScreen extends GetView<ItemCreateController> {
  const CapturePhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Agregar el WillPopScope para capturar el gesto de ir para atrás
      onWillPop: () async {
        // Mostrar el diálogo de confirmación al intentar salir
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('SALIR DE LA CAPTURA'),
              content: const Text(
                  '¿REALMENTE QUIERES SALIR? \n PERDERÁS TODAS TUS CAPTURAS'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Continuar
                  },
                  child: const Text('CONTINUAR'),
                ),
                TextButton(
                  onPressed: () {
                    controller.stopCapture();
                    controller.deletePhotos();

                    Navigator.of(context).pop(true); // Salir
                  },
                  child: const Text('SALIR'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CATÁLOGO'),
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.only(bottom: 1, left: 5),
            icon: const Icon(Icons.arrow_back),
            iconSize: 55,
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: 'Volver hacia el catálogo',
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.startCapture();
                        // Navegar a la siguiente etapa
                      },
                      child: const Text('CAPTURAR CON CÁMARA'),
                    ),
                  ),
                  const SizedBox(
                    width: 50, // Ajustar el tamaño del espacio
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.startCapture2(); // Volver a capturar fotos
                      },
                      child: const Text('AGREGAR DE GALERÍA'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.capturedPhotos.length,
                  itemBuilder: (context, index) {
                    final image = controller.capturedPhotos[index];
                    return GestureDetector(
                      onTap: () {
                        controller.removePhoto(
                            image, index); // Eliminar foto al presionarla
                      },
                      child: Image.file(image),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const BindObjectsScreen());
                // image:
                //   Image.file(archivo)));
              },
              child: const SizedBox(
                width: double.infinity, // Ocupar el ancho de la columna
                child: Center(
                  child: Text('CONTINUAR'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FotoEnLista extends StatelessWidget {
  final Image imagen;
  const FotoEnLista({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return imagen;
  }
}
