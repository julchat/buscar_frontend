import 'dart:async';

import 'package:buscar_app/infrastructure/respuesta.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'csrftoken_controller.dart';

enum HttpMethod {
  get,
  post,
  delete,
}

class ConectorBackend {
  late Uri uri;
  final HttpMethod method;
  final Map<String,String>? body;

  ConectorBackend({required ruta, required this.method, this.body}) {
    uri = Uri.http('192.168.0.159:8000', ruta);
  }

  Future<Respuesta> hacerRequest() async {
    Respuesta respuesta = Respuesta();
    final csrfTokenController = Get.find<CsrfTokenController>();
    String token = csrfTokenController.csrfToken.value;

    Map<String, String>? headers = {
      'X-CSRFToken': token,
      'csrftoken': token,
      'Cookie' : 'csrftoken=$token'
    };
    if(body != null){
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
                  .timeout(const Duration(seconds: 40)));
        case (HttpMethod.delete):
          respuesta = Respuesta(
              respuestaExistente: await http
                  .delete(uri, body: body, headers: headers)
                  .timeout(const Duration(seconds: 40)));
      }
      respuesta.finalizarOk();
    } on TimeoutException {
      respuesta.finalizarTimeOut();
    }
    return respuesta;
  }

  Future<void> getCsrfToken() async {
    final response =  await http.get(uri).timeout(const Duration(seconds: 40));

    if (response.statusCode == 200) {
      final token =
          response.body; // Obtén el valor del token CSRF desde la respuesta

      final csrfTokenController = Get.find<CsrfTokenController>();
      csrfTokenController.setCsrfToken(
          token); // Actualiza el valor del token en el controlador
    } else {
      throw Exception('Error al obtener el token CSRF');
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
}
