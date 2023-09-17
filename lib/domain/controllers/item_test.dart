import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Punto {
  double coordenadaX;
  double coordenadaY;

  Punto({required this.coordenadaX, required this.coordenadaY});
}

class ParVertices {
  Punto verticeViejo;
  Punto verticeNuevo;

  ParVertices({required this.verticeViejo, required this.verticeNuevo});
}

class BindObjectsController extends GetxController {
  List<Image> listaDeFotos = [];
  List<ParVertices> listaDePuntos = [];
  late Rx<Image> fotoActual;
  late Rx<ParVertices> puntosActuales;
  int indiceActual = 0;
  bool cargado = false;

  @override
  void onInit() {
    super.onInit();
    fotoActual = Rx<Image>(Image.asset('assets/images/buscartransparente.png'));
    puntosActuales = Rx<ParVertices>(
      ParVertices(
        verticeViejo: Punto(coordenadaX: -1, coordenadaY: -1),
        verticeNuevo: Punto(coordenadaX: -1, coordenadaY: -1),
      ),
    );

    // Inicializa tus datos, carga fotos y puntosActuales (con valores mockup) de la misma longitud.
    // Asegúrate de que ambas listas tengan la misma longitud.
  }

  void setearFotos(List<String> archivos) {
    if (cargado == false) {
      for (var archivo in archivos) {
        listaDeFotos.add(Image.file(File(archivo)));
        listaDePuntos.add(ParVertices(
            verticeViejo: Punto(coordenadaX: -1, coordenadaY: -1),
            verticeNuevo: Punto(coordenadaX: -1, coordenadaY: -1)));
      }
      indiceActual = 0;
      fotoActual.value = listaDeFotos.first;
      puntosActuales.value = listaDePuntos.first;
      cargado = true;
    }
  }

  void resetState() {
    listaDeFotos.clear();
    listaDePuntos.clear();
    fotoActual(Image.asset('assets/images/buscartransparente.png'));
    puntosActuales(
      ParVertices(
        verticeViejo: Punto(coordenadaX: -1, coordenadaY: -1),
        verticeNuevo: Punto(coordenadaX: -1, coordenadaY: -1),
      ),
    );
    indiceActual = 0;
    cargado = false;
  }

  void siguienteFoto() {
    if (indiceActual < listaDeFotos.length - 1) {
      listaDePuntos[indiceActual] = puntosActuales.value;
      indiceActual++;
      fotoActual(listaDeFotos[indiceActual]);
      puntosActuales(listaDePuntos[indiceActual]);
    }
  }

  void anteriorFoto() {
    if (indiceActual > 0) {
      listaDePuntos[indiceActual] = puntosActuales.value;
      indiceActual--;
      fotoActual(listaDeFotos[indiceActual]);
      puntosActuales(listaDePuntos[indiceActual]);
    }
  }

  void agregarPunto(double x, double y) {
    final nuevosPuntos = puntosActuales.value;
    nuevosPuntos.verticeViejo = nuevosPuntos.verticeNuevo;
    nuevosPuntos.verticeNuevo = Punto(coordenadaX: x, coordenadaY: y);
    puntosActuales(nuevosPuntos);
  }
}

class BindObjectsScreen extends StatelessWidget {
  final BindObjectsController controller = Get.put(BindObjectsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DELIMITAR OBJETO"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navegar hacia atrás
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help),
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
              controller.resetState();
            },
            child: Text("LIMPIAR PUNTOS"),
          ),
          GestureDetector(
            onTapDown: (details) {
              double x = details.localPosition.dx;
              double y = details.localPosition.dy;
              controller.agregarPunto(x, y);
            },
            child: Container(
              width: double.infinity,
              height: double.infinity, // Ajusta la altura según tus necesidades
              child: CustomPaint(
                painter: RectanglePainter(controller.puntosActuales),
                child: Obx(
                  () => Image(
                    image: controller.fotoActual.value.image,
                    fit: BoxFit.contain,
                  ),
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
                child: Text("ANTERIOR"),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.siguienteFoto();
                },
                child: Text("SIGUIENTE"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  final Rx<ParVertices> puntos;

  RectanglePainter(this.puntos);

  @override
  void paint(Canvas canvas, Size size) {
    if (puntos.value.verticeViejo.coordenadaX != -1) {
      final paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      final rect = Rect.fromLTRB(
        puntos.value.verticeViejo.coordenadaX,
        puntos.value.verticeViejo.coordenadaY,
        puntos.value.verticeNuevo.coordenadaX,
        puntos.value.verticeNuevo.coordenadaY,
      );

      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
