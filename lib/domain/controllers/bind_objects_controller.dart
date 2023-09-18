import 'dart:math';

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

  ParVertices({Punto? verticeViejo, Punto? verticeNuevo})
      : verticeViejo = verticeViejo ?? Punto(coordenadaX: -1, coordenadaY: -1),
        verticeNuevo = verticeNuevo ?? Punto(coordenadaX: -1, coordenadaY: -1);
}

class BindObjectsController extends GetxController {
  List<Image> listaDeFotos = [];
  List<ParVertices> listaDePuntos = [];
  late Rx<Image> fotoActual;
  late Rx<ParVertices> puntosActuales;
  Rx<EdgeInsets> margin = const EdgeInsets.all(0).obs;
  Rx<double> boxWidth = (0.0).obs;
  Rx<double> boxHeight = (0.0).obs;
  int indiceActual = 0;

  @override
  void onInit() {
    super.onInit();
    fotoActual = Rx<Image>(Image.asset('assets/images/buscartransparente.png'));
    puntosActuales = Rx<ParVertices>(
      ParVertices(),
    );

    // Inicializa tus datos, carga fotos y puntosActuales (con valores mockup) de la misma longitud.
    // Asegúrate de que ambas listas tengan la misma longitud.
  }

  void resetState() {
    listaDeFotos.clear();
    listaDePuntos.clear();
    fotoActual(Image.asset('assets/images/buscartransparente.png'));
    puntosActuales(
      ParVertices(),
    );
    indiceActual = 0;
    boxWidth.value = 0.0;
    boxHeight.value = 0.0;
    margin.value = const EdgeInsets.all(0);
  }

  void siguienteFoto() {
    if (indiceActual < listaDeFotos.length - 1) {
      listaDePuntos[indiceActual] = puntosActuales.value;
      indiceActual++;
      cargarContenido();
    }
  }

  void anteriorFoto() {
    if (indiceActual > 0) {
      listaDePuntos[indiceActual] = puntosActuales.value;
      indiceActual--;
      cargarContenido();
    }
  }

  void agregarPunto(double x, double y) {
    final nuevosPuntos = puntosActuales.value;
    nuevosPuntos.verticeViejo = nuevosPuntos.verticeNuevo;
    nuevosPuntos.verticeNuevo = Punto(coordenadaX: x, coordenadaY: y);
    puntosActuales(nuevosPuntos);
    armarCaja();
  }

  void armarCaja() {
    final nuevosPuntos = puntosActuales.value;
    if (nuevosPuntos.verticeViejo.coordenadaX != -1) {
      margin(EdgeInsets.fromLTRB(
        min(nuevosPuntos.verticeViejo.coordenadaX,
            nuevosPuntos.verticeNuevo.coordenadaX),
        min(nuevosPuntos.verticeViejo.coordenadaY,
            nuevosPuntos.verticeNuevo.coordenadaY),
        0,
        0,
      ));
      boxWidth(max(nuevosPuntos.verticeViejo.coordenadaX,
              nuevosPuntos.verticeNuevo.coordenadaX) -
          min(nuevosPuntos.verticeViejo.coordenadaX,
              nuevosPuntos.verticeNuevo.coordenadaX));

      boxHeight(max(nuevosPuntos.verticeViejo.coordenadaY,
              nuevosPuntos.verticeNuevo.coordenadaY) -
          min(nuevosPuntos.verticeViejo.coordenadaY,
              nuevosPuntos.verticeNuevo.coordenadaY));
    } else {
      margin(const EdgeInsets.all(0));
      boxWidth(0);
      boxHeight(0);
    }
  }

  void agregarFoto(Image imageToAdd) {
    listaDeFotos.add(imageToAdd);
    listaDePuntos.add(ParVertices());

    if (listaDeFotos.length == 1) {
      indiceActual = 0;
      cargarContenido();
    }
  }

  void quitarFoto(int index) {
    listaDeFotos.removeAt(index);
    listaDePuntos.removeAt(index);
    if ((indiceActual < index) || (indiceActual == index && index != 0)) {
      indiceActual--;
    }
    cargarContenido();
  }

  void cargarContenido() {
    fotoActual(listaDeFotos[indiceActual]);
    puntosActuales(listaDePuntos[indiceActual]);
    armarCaja();
  }

  void reiniciarMarco() {
    puntosActuales(ParVertices());
    armarCaja();
  }
}


