import "package:buscar_app/presentation/widgets/boton_custom.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../domain/controllers/bind_objects_controller.dart";
import 'package:flutter_tts/flutter_tts.dart';

class BindObjectsScreen extends GetView<BindObjectsController> {
  const BindObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DELIMITAR OBJETO'),
        centerTitle: true,
        leading: IconButton(
            padding: const EdgeInsets.only(bottom: 1, left: 5),
            icon: const Icon(Icons.arrow_back),
            iconSize: 55,
            onPressed: () {
              Get.back();
            },
            tooltip: 'Volver hacia delimitación de fotos'),
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
                'Oprima en dos ubicaciones de la foto para marcar donde se encuentra el objeto en la foto. Utilizando los botones de anterior y siguiente, se podrá desplazar por cada una de las fotos. Podrá reiniciar el rectángulo de un punto con el botón de Reiniciar Marco.',
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 65),
          BotonCustomSinIcono(
            onPressed: () {
              controller.reiniciarMarco();
            },
            contenido: 'REINICIAR MARCO',
          ),
          const SizedBox(height: 25),
          Expanded(child: LayoutBuilder(builder: (context, constraints) {
            controller.setAnchoExpanded(constraints.maxWidth);
            controller.setAltoExpanded(constraints.maxHeight);
            return GestureDetector(
              onTapDown: (details) {
                double x = details.localPosition.dx;
                double y = details.localPosition.dy;
                controller.agregarPunto(x, y);
              },
              child: Semantics(
                button: false,
                label: 'Imagen número ${controller.indiceActual + 1}',
                tooltip:
                    'Para delimitar el objeto en la foto, deberá primero desactivar el lector de pantalla',
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Obx(
                      () => Image(
                        image: controller.fotoActual.value.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Obx(() {
                      return Positioned(
                        left: controller.margin.value.left,
                        top: controller.margin.value.top,
                        child: Container(
                          width: controller.boxWidth.value,
                          height: controller.boxHeight.value,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 3),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            );
          })),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BotonCustomSinIcono(
                onPressed: () {
                  controller.anteriorFoto();
                },
                contenido: ("ANTERIOR"),
              ),
              BotonCustomSinIcono(
                  onPressed: () {
                    controller.siguienteFoto();
                  },
                  contenido: ("SIGUIENTE")),
            ],
          ),
          const SizedBox(height: 55)
        ],
      ),
    );
  }
}
