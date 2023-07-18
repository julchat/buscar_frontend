import 'dart:async';

import 'package:buscar_app/infrastructure/respuesta.dart';
import 'package:http/http.dart' as http;

enum HttpMethod {
  get,
  post,
  delete,
}

class ConectorBackend {
  late Uri uri;
  final HttpMethod method;
  final String? body;

  ConectorBackend({required ruta, required this.method, this.body}) {
    uri = Uri.https('http://127.0.0.1:8000', ruta);
  }

  Future<Respuesta> hacerRequest() async {
    Respuesta respuesta = Respuesta();
    try {
      switch (method) {
        case (HttpMethod.get):
          respuesta = Respuesta(
              respuestaExistente:
                  await http.get(uri).timeout(const Duration(seconds: 40)));
        case (HttpMethod.post):
          respuesta = Respuesta(
              respuestaExistente: await http
                  .post(uri, body: body)
                  .timeout(const Duration(seconds: 40)));
        case (HttpMethod.delete):
          respuesta = Respuesta(
              respuestaExistente: await http
                  .delete(uri, body: body)
                  .timeout(const Duration(seconds: 40)));
      }
      respuesta.finalizarOk();
    } on TimeoutException {
      respuesta.finalizarTimeOut();
    }
    return respuesta;
  }

    /* enviarMensajeSincronico() async {
    try {
      Response response = await hacerRequest();

      if (response.statusCode == 200) {
        return Respuesta(respuestaExistente: response, finalizada: true);
      }
    } on TimeoutException {
      return Respuesta(finalizada: true);
    }
  }*/

  /*enviarMensajeAsincronico() async {
    Respuesta respuesta;
    try {
      respuesta = Respuesta(respuestaExistente: hacerRequest());
      respuesta.finalizar();
    } on TimeoutException {
      respuesta = Respuesta(finalizada: true);
    }
    return respuesta;
  }*/
}
