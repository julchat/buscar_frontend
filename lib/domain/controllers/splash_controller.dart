import 'dart:convert';

import 'package:buscar_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/conector_backend.dart';
import '../../infrastructure/respuesta.dart';
import '../../presentation/screens/home_screen.dart';
import '../forms/login_form.dart';

class SplashController extends GetxController {
  get csrfTokenAndSessionController => null;

  Future<void> fetchCsrfToken() async {
    final respuesta =
        await ConectorBackend(ruta: 'csrf_token/', method: HttpMethod.get)
            .getCsrfToken();

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
        LecturaCredenciales credenciales = LecturaCredenciales();
        credenciales.leerCredenciales();
      if (!credenciales.resultadoOk) {
        Get.off(() => const LoginScreen());
      } else {
        Map<String, String> jsonRegistro = LoginForm(usuario: credenciales.correo, contrasenia: credenciales.contrasenia).aMap();
        final respuestaLogin = await ConectorBackend(
                ruta: 'login_flutter', method: HttpMethod.post, body: jsonRegistro).hacerRequest();
        manejarRespuestaLogin(respuestaLogin);
      }
    } else {
      String mensajeTitulo = 'error';
      String mensajeContenido = 'error';

      if (respuesta.estado == EstadoRespuesta.finalizadaMal) {
        mensajeTitulo = 'ERROR';
        mensajeContenido = 'OCURRIÓ UN ERROR INESPERADO';
      }

      if (respuesta.estado == EstadoRespuesta.timeOut) {
        mensajeTitulo = 'ERROR DE CONEXIÓN';
        mensajeContenido =
            'OCURRIÓ UN ERROR DE CONEXIÓN \nPOR FAVOR VERIFIQUE SU ACCESO A INTERNET';
      }

      Get.dialog(
        AlertDialog(
          title: Text(mensajeTitulo, style: const TextStyle(fontSize: 30)),
          content: Text(mensajeContenido, style: const TextStyle(fontSize: 18)),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Cerrar el diálogo
                fetchCsrfToken(); // Reintentar la llamada
              },
              child: const Text('REINTENTAR', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      );
    }
  }

  void manejarRespuestaLogin(Respuesta respuesta) {
    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      final body = json.decode(respuesta.respuestaExistente!.body);
      final String token = body['token'];
      final String session = body['session'];
      csrfTokenAndSessionController.setCsrfToken(token);
      csrfTokenAndSessionController.setSessionId(session);
      Get.off(() => const HomeScreen());
    } else {
      Get.off(() => const LoginScreen());
    }
  }
}

class LecturaCredenciales {
  bool resultadoOk = false;
  String correo = '';
  String contrasenia = '';

  LecturaCredenciales();
  void leerCredenciales() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? correoLeido = prefs.getString('correo');
    final String? contraseniaLeida = prefs.getString('contrasenia');

    if (correoLeido != null && contraseniaLeida != null) {
      resultadoOk = true;
      correo = correoLeido;
      contrasenia = contraseniaLeida;
    }

  }
}
