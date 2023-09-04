import 'package:buscar_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/conector_backend.dart';
import '../../infrastructure/respuesta.dart';

class SplashController extends GetxController {

  Future<void> fetchCsrfToken() async {
    final respuesta =
        await ConectorBackend(ruta: 'csrf_token/', method: HttpMethod.get)
            .getCsrfToken();

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      Get.off(() =>
          const LoginScreen()); // Cambia '/nextScreen' por la ruta de la siguiente pantalla
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
}
