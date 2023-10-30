import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

import '../../domain/controllers/item_create_controller.dart';

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
            return AlertaObjetos(controller: controller, flecha: false);
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AGREGAR OBJETO'),
          centerTitle: true,
          leading: IconButton(
              padding: const EdgeInsets.only(bottom: 1, left: 5),
              icon: const Icon(Icons.arrow_back),
              iconSize: 55,
              onPressed: () async {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertaObjetos(controller: controller, flecha: true);
                  },
                );
              },
              tooltip: 'Regresar a catálogo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                var tts = FlutterTts();
                tts.setLanguage('es');
                tts.speak(
                    'Oprima en dos ubicaciones de la foto para marcar donde se encuentra el objeto en la foto. Utilizando los botones de anterior y siguiente, se podrá desplazar por cada una de las fotos. Podrá reiniciar el rectángulo de un punto con el botón de Reiniciar Marco.');
              },
              tooltip:
                  'Agregue imágenes con la cámara o desde galería. Oprima sobre una imagen para eliminarla',
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.startCapture();
                          // Navegar a la siguiente etapa
                        },
                        child: const Text('CAPTURAR CON CÁMARA',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(
                      width: 25, // Ajustar el tamaño del espacio
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.startCapture2(); // Volver a capturar fotos
                        },
                        child: const Text('AGREGAR DE GALERÍA',
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  //physics: const PageScrollPhysics(),
                  itemCount: controller.capturedPhotos.length,
                  itemBuilder: (context, index) {
                    final indexmasuno = index + 1;
                    final image = controller.capturedPhotos[index];
                    return Semantics(
                        label: 'Imagen $indexmasuno',
                        tooltip: 'Oprima para eliminar' ,
                        button: true,
                        child: GestureDetector(
                            onTap: () {
                              controller.removePhoto(
                                  image, index); // Eliminar foto al presionarla
                            },
                            child: Image.file(image)));
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.capturedPhotos.length >= 5) {
                  controller.irAProxPaso();
                } else {
                  abrirSnackbar(
                      'FALTAN FOTOS', 'DEBEN HABER AL MENOS CINCO FOTOS');
                }
                // image:
                //   Image.file(archivo)));
              },
              child: const SizedBox(
                width: double.infinity, // Ocupar el ancho de la columna
                child: Center(
                  child: Text('CONTINUAR',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center),
                ),
              ),
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }

  void abrirSnackbar(String titulo, String body) {
    Get.snackbar(titulo, body,
        colorText: Colors.black,
        backgroundColor: Colors.cyan,
        messageText: Semantics(
            liveRegion: true,
            child: Text(body,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black))),
        duration: const Duration(seconds: 6),
        snackPosition: SnackPosition.BOTTOM);
  }
}

class AlertaObjetos extends StatelessWidget {
  const AlertaObjetos(
      {super.key, required this.controller, required this.flecha});

  final ItemCreateController controller;
  final bool flecha;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('SALIR DE LA CAPTURA'),
      content: const Text(
          '¿REALMENTE QUIERES SALIR? \n PERDERÁS TODAS TUS CAPTURAS'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Continuar
          },
          child: const Text('CONTINUAR CON ALTA'),
        ),
        TextButton(
          onPressed: () {
            controller.stopCapture();
            controller.deletePhotos();

            Navigator.of(context).pop(true);
            if (flecha) {
              Navigator.of(context).pop(true);
            } // Salir
          },
          child: const Text('IR A MENÚ'),
        ),
      ],
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
