import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemCreateController extends GetxController {
  final RxList<String> capturedPhotos = <String>[].obs;
  final RxBool isCapturing = false.obs;

    Future<void> startCapture2() async {
      final pickedPhotos = await ImagePicker().pickMultiImage();
      pickedPhotos.forEach((element) {capturedPhotos.add(element.path);});
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
        capturedPhotos.add(pickedFile.path);
      }
      // Agregar solo si pickedFile no es nulo
    }
  }

  void stopCapture() {
    isCapturing.value = false;
  }

  void deletePhotos() {
    capturedPhotos.value = <String>[];
  }

  void readInstructions() async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage('es');
    while (isCapturing.isTrue) {
      await tts.speak('Presione el botón de atrás para finalizar las capturas');
      await Future.delayed(const Duration(seconds: 10));
    }
  }

  // Método para eliminar una foto de la lista
  void removePhoto(String imagePath) {
    capturedPhotos.remove(imagePath);
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
              title: Text('Salir de la Captura'),
              content: Text('Realmente quieres salir? Perderás todos tus objetos.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Continuar
                  },
                  child: Text('CONTINUAR'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Salir
                  },
                  child: Text('SALIR'),
                ),
              ],
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('CAPTURA DE FOTOS'),
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
                        controller.stopCapture();
                        // Navegar a la siguiente etapa
                      },
                      child: Text('CAPTURAR CON CÁMARA'),
                    ),
                  ),
                  SizedBox(
                    width: 50, // Ajustar el tamaño del espacio
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.startCapture(); // Volver a capturar fotos
                      },
                      child: Text('AGREGAR DE GALERÍA'),
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
                    final imagePath = controller.capturedPhotos[index];
                    return GestureDetector(
                      onTap: () {
                        controller.removePhoto(imagePath); // Eliminar foto al presionarla
                      },
                      child: Image.file(File(imagePath)),
                    );
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para el tercer botón
              },
              child: SizedBox(
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
