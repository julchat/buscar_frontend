import 'dart:io';
import 'dart:math';

import 'package:buscar_app/domain/controllers/object_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/screens/object_confirmation_screen.dart';
import '../punto_y_vertices.dart';
import 'package:image/image.dart' as img;

class BindObjectsController extends GetxController {
  List<Image> listaDeFotos = [];
  List<ParVertices> listaDePuntos = [];
  List<File> listaDeFotosArch = [];
  late Rx<Image> fotoActual;
  late Rx<ParVertices> puntosActuales;
  Rx<EdgeInsets> margin = const EdgeInsets.all(0).obs;
  Rx<double> boxWidth = (0.0).obs;
  Rx<double> boxHeight = (0.0).obs;
  int indiceActual = 0;
  var isUltimaFoto = false.obs;
  double expandedWidth = 0.0;
  double expandedHeight = 0.0;
  List<(int, int)> listaDeDimensionesFotos = [];
  List<String> nombresUsados = [];

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
    listaDeFotosArch.clear();
    listaDeDimensionesFotos.clear();
    expandedWidth = 0.0;
    expandedHeight = 0.0;
    isUltimaFoto(false);
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
      if (indiceActual == listaDeFotos.length) {
        isUltimaFoto(true);
      }
      cargarContenido();
    } else {
      ObjectConfirmationController proxPaso =
          Get.find<ObjectConfirmationController>();
      List<VerticesProcesados> vertices = traducirPuntos();
      proxPaso.inicializar(
          listaDeFotos.first, vertices, nombresUsados, listaDeFotosArch);
      Get.to(() => const ObjectConfirmationScreen());
    }
  }

  void anteriorFoto() {
    if (indiceActual > 0) {
      listaDePuntos[indiceActual] = puntosActuales.value;
      indiceActual--;
      cargarContenido();
    }
  }

  void volverAPrincipio() {
    listaDePuntos[indiceActual] = puntosActuales.value;
    indiceActual = 0;
    cargarContenido();
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
    print(
        'Caja a armar en: (${nuevosPuntos.verticeViejo.coordenadaX};${nuevosPuntos.verticeViejo.coordenadaY}) , (${nuevosPuntos.verticeNuevo.coordenadaX};${nuevosPuntos.verticeNuevo.coordenadaY})');
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

  void agregarFoto(File imageToAdd) {
    listaDeFotos.add(Image.file(imageToAdd));
    listaDePuntos.add(ParVertices());
    listaDeFotosArch.add(imageToAdd);
    listaDeDimensionesFotos.add(armarImagenParaDimensiones(imageToAdd));

    if (listaDeFotos.length == 1) {
      indiceActual = 0;
      cargarContenido();
    }
  }

  void quitarFoto(int index) {
    listaDeFotos.removeAt(index);
    listaDePuntos.removeAt(index);
    listaDeFotosArch.removeAt(index);
    listaDeDimensionesFotos.removeAt(index);
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

  void setNombresUsados(List<String> nombresUsados) {
    this.nombresUsados = nombresUsados;
  }

  void setAltoExpanded(double maxHeight) {
    expandedHeight = maxHeight;
  }

  void setAnchoExpanded(double maxWidth) {
    expandedWidth = maxWidth;
  }

  List<VerticesProcesados> traducirPuntos() {
    double anchoFoto;
    double altoFoto;
    double escala;
    ParVertices verticesExp;
    (int, int) dimensionesFoto;
    List<VerticesProcesados> verticesFoto = [];

    double puntoX1;
    double puntoX2;
    double puntoY1;
    double puntoY2;

    for (int i = 0; i < listaDePuntos.length; i++) {
      verticesExp = listaDePuntos.elementAt(i);
      dimensionesFoto = listaDeDimensionesFotos.elementAt(i);
      anchoFoto = dimensionesFoto.$1.toDouble();
      altoFoto = dimensionesFoto.$2.toDouble();

      puntoY1 = max(verticesExp.verticeViejo.coordenadaY,
          0.0); //Por si alguno quedó en -1
      puntoY2 = max(verticesExp.verticeNuevo.coordenadaY, 0.0);
      puntoX1 = max(verticesExp.verticeViejo.coordenadaX, 0.0);
      puntoX2 = max(verticesExp.verticeNuevo.coordenadaX, 0.0);

      if (expandedWidth / expandedHeight >= anchoFoto / altoFoto) {
        //Cuando a la foto le sobra ancho
        escala = altoFoto / expandedHeight;
      } else {
        //Cuando a la foto le sobra alto
        escala = anchoFoto / expandedWidth;
        double ajusteAltura = (expandedHeight - (altoFoto / escala)) / 2;
        puntoY1 = puntoY1 - ajusteAltura;
        puntoY2 = puntoY2 - ajusteAltura; //Hago el ajuste
      }

      puntoY1 = puntoY1 * escala;
      puntoY2 = puntoY2 * escala;
      puntoX1 = puntoX1 * escala;
      puntoX2 = puntoX2 * escala;

      if (puntoY1 > puntoY2) {
        //Punto Y2 va a ser el ymax, por lo cual si puntoY1 es mayor los intercambio
        var aux = puntoY1;
        puntoY1 = puntoY2;
        puntoY2 = aux;
      }

      if (puntoX1 > puntoX2) {
        //Lo mismo para los x
        var aux = puntoX1;
        puntoX1 = puntoX2;
        puntoX2 = aux;
      }

      verticesFoto.add(VerticesProcesados(
          xmin: puntoX1.toInt(), xmax: puntoX2.toInt(), ymin: puntoY1.toInt(), ymax: puntoY2.toInt(), anchoFoto: anchoFoto.toInt(), altoFoto: altoFoto.toInt()));
    }
    return verticesFoto;
  }

  (int, int) armarImagenParaDimensiones(File archivo) {
    final image = img.decodeImage(archivo.readAsBytesSync());
    if (image != null) {
      return (image.width, image.height);
    } else {
      return (0, 0);
    }
  }
}
