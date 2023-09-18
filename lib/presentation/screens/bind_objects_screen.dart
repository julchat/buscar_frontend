import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../domain/controllers/bind_objects_controller.dart";

class BindObjectsScreen extends GetView<BindObjectsController> {
  const BindObjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DELIMITAR OBJETO", textAlign: TextAlign.center),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navegar hacia atrás
          },
        ),
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
          ElevatedButton(
            onPressed: () {
              controller.reiniciarMarco();
            },
            child: const Text("REINICIAR MARCO"),
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
              ElevatedButton(
                onPressed: () {
                  controller.anteriorFoto();
                },
                child: const Text("ANTERIOR"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.siguienteFoto();
                },
                child: const Text("SIGUIENTE"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}