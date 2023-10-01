import "package:buscar_app/presentation/widgets/boton_custom.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../domain/controllers/bind_objects_controller.dart";

class BindObjectsScreen extends GetView<BindObjectsController> {
  const BindObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                title: const Text('CONFIRMAR OBJETO'),
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
              // Mostrar ventana modal de ayuda
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 90),
          BotonCustomSinIcono(
            onPressed: () {
              controller.reiniciarMarco();
            },
            contenido: 'REINICIAR MARCO',
          ),
          Expanded(
            child: GestureDetector(
              onTapDown: (details) {
                double x = details.localPosition.dx;
                double y = details.localPosition.dy;
                controller.agregarPunto(x, y);
              },
              child: Container(
                color: Colors
                    .transparent, // Cambia a color.transparent si quieres que el Container sea invisible
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
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ),
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
                contenido : ("SIGUIENTE")
              ),
            ],
          ),
          const SizedBox(height: 80)
        ],
      ),
    );
  }
}