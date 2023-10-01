import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/controllers/item_create_controller.dart';
import 'bind_objects_screen.dart';

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
