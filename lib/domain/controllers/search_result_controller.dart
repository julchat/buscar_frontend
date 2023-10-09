import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:buscar_app/infrastructure/respuesta.dart';
import 'package:buscar_app/presentation/screens/result_screens/search_result_screen.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;

import '../objeto.dart';
import '../dimension_rectangulo.dart';

enum Ubicacion {
  inferiorIzquierda,
  inferiorDerecha,
  centroIzquierda,
  centroDerecha,
  superiorIzquierda,
  superiorDerecha,
  error,
  noEncontrada,
}

extension UbicacionExtension on Ubicacion {
  String get name {
    return switch (this) {
      Ubicacion.inferiorIzquierda => 'INFERIOR IZQUIERDO',
      Ubicacion.inferiorDerecha => 'INFERIOR DERECHO',
      Ubicacion.centroIzquierda => 'CENTRAL IZQUIERDO',
      Ubicacion.centroDerecha => 'CENTRAL DERECHO',
      Ubicacion.superiorIzquierda => 'SUPERIOR IZQUIERDO',
      Ubicacion.superiorDerecha => 'SUPERIOR DERECHO',
      Ubicacion.error => 'ERROR',
      Ubicacion.noEncontrada => 'NO ENCONTRADA'
    };
  }
}

class DimensionFoto {
  final double ancho;
  final double alto;

  const DimensionFoto({required this.ancho, required this.alto});
}

class UbicacionConPrecision {
  final Ubicacion ubicacion;
  final double precision;

  const UbicacionConPrecision(
      {required this.ubicacion, required this.precision});
}

class SearchResultController extends GetxController {
  void procesarRespuesta(Respuesta respuesta, File foto, Objeto objeto) async {
    UbicacionConPrecision ubicacion = await calcularPosicion(respuesta, foto);
    Get.off(() => SearchResultScreen(
        ubicacion: ubicacion.ubicacion, precision: ubicacion.precision, objeto: objeto));
  }

  Future<UbicacionConPrecision> calcularPosicion(
      Respuesta respuesta, File foto) async {
    final body = json.decode(respuesta.respuestaExistente!.body);

    if (body['encontrado'] == 'False') {
      return const UbicacionConPrecision(
          ubicacion: Ubicacion.noEncontrada, precision: 0);
    } else if (body['encontrado'] == 'True') {
      DimensionFoto dimensiones = await getImageDimensions(foto);
      DimensionRectangulo rectangulo =
          DimensionRectangulo.fromJson(ubicaciones: body['ubicaciones'], accuraccy: body['precision']);
      double centroX = (rectangulo.xmin + rectangulo.xmax) / 2;
      double centroY = (rectangulo.ymin + rectangulo.ymax) / 2;

      Ubicacion ubicacionEncontrado = Ubicacion.error;

      if (dimensiones.alto * 0.33 > centroY && dimensiones.ancho * 0.5 > centroX)ubicacionEncontrado = Ubicacion.inferiorIzquierda;
      if (dimensiones.alto * 0.33 > centroY && dimensiones.ancho * 0.5 <= centroX) ubicacionEncontrado = Ubicacion.inferiorDerecha;
      if (dimensiones.alto * 0.33 <= centroY && dimensiones.alto * 0.66 > centroY && dimensiones.ancho * 0.5 > centroX) ubicacionEncontrado = Ubicacion.centroIzquierda;
      if (dimensiones.alto * 0.33 <= centroY && dimensiones.alto * 0.66 > centroY && dimensiones.ancho * 0.5 <= centroX) ubicacionEncontrado = Ubicacion.centroDerecha;
      if (dimensiones.alto * 0.66 <= centroY && dimensiones.ancho * 0.5 > centroX) ubicacionEncontrado = Ubicacion.superiorIzquierda;
      if (dimensiones.alto * 0.66 <= centroY && dimensiones.ancho * 0.5 <= centroX) ubicacionEncontrado = Ubicacion.superiorDerecha;

      return UbicacionConPrecision(
          ubicacion: ubicacionEncontrado, precision: rectangulo.precision);
    } else {
      return const UbicacionConPrecision(
          ubicacion: Ubicacion.error, precision: 0);
    }
  }
}

Future<DimensionFoto> getImageDimensions(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  final image = img.decodeImage(Uint8List.fromList(bytes));

  if (image != null) {
    final width = image.width;
    final height = image.height;

    return DimensionFoto(alto: height.toDouble(), ancho: width.toDouble());
  } else {
    throw Exception('No se pudo decodificar la imagen.');
  }
}
