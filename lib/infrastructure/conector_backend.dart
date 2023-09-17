import 'dart:async';

import 'package:buscar_app/infrastructure/respuesta.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'csrftokenandsession_controller.dart';

enum HttpMethod {
  get,
  post,
  delete,
}

class ConectorBackend {
  final HttpMethod method;
  late Uri uri;
  final Map<String, String>? body;

  ConectorBackend({required ruta, required this.method, this.body}) {
    uri = Uri.http('192.168.0.159:8000', ruta);
  }

  Future<Respuesta> hacerRequest() async {
    Respuesta respuesta = Respuesta();
    final csrfTokenAndSessionController =
        Get.find<CsrfTokenAndSessionController>();
    String token = csrfTokenAndSessionController.csrfToken.value;
    String session = csrfTokenAndSessionController.sessionId.value;

    Map<String, String>? headers = {
      'csrftoken': token,
      'X-CSRFToken': token,
      'Cookie': 'csrftoken=$token; sessionid=$session'
    };
    if (body != null) {
      body?["csrfmiddlewaretoken"] = token;
    }

    try {
      switch (method) {
        case (HttpMethod.get):
          respuesta = Respuesta(
              respuestaExistente: await http
                  .get(uri, headers: headers)
                  .timeout(const Duration(seconds: 40)));
        case (HttpMethod.post):
          respuesta = Respuesta(
              respuestaExistente: await http
                  .post(uri, body: body, headers: headers)
                  .timeout(const Duration(seconds: 200)));
        case (HttpMethod.delete):
          respuesta = Respuesta(
              respuestaExistente: await http
                  .delete(uri, body: body, headers: headers)
                  .timeout(const Duration(seconds: 40)));
      }

      if (respuesta.respuestaExistente!.statusCode >= 200 &&
          respuesta.respuestaExistente!.statusCode < 400) {
        respuesta.finalizarOk();
      } else {
        respuesta.finalizarMal();
      }
    } on TimeoutException {
      respuesta.finalizarTimeOut();
    }
    return respuesta;
  }

  Future<Respuesta> getCsrfToken() async {
    Respuesta respuestaARetornar = Respuesta();
    try{
      respuestaARetornar = Respuesta(respuestaExistente: await http.get(uri).timeout(const Duration(seconds: 40)));
      if (respuestaARetornar.respuestaExistente!.statusCode == 200) {

      final token = respuestaARetornar.respuestaExistente!.body; // Obtén el valor del token CSRF desde la respuesta
      final csrfTokenController = Get.find<CsrfTokenAndSessionController>();
      csrfTokenController.setCsrfToken(
          token); // Ac
      respuestaARetornar.finalizarOk();
      } else{
      respuestaARetornar.finalizarMal();
      }
    } on TimeoutException {
      respuestaARetornar.finalizarTimeOut();
    }
    return respuestaARetornar;    
    }
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

