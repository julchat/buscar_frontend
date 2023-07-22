import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_register.dart';
import 'package:get/get.dart';

import '../../infrastructure/respuesta.dart';
import '../../presentation/screens/result_screens/failed_login.dart';
import '../../presentation/screens/result_screens/successful_register.dart';

class LoadingController extends GetxController {
  var isLoading = true.obs;

  void handleServerResponseRegister(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      if (respuesta.respuestaExistente?.statusCode == 200) {
        Get.off(const SuccessfulRegister());
      } else {
        mensajeError = respuesta.respuestaExistente?.body;
        Get.off(FailedRegister(mensajeDeError: mensajeError));
      }
    } else {
      mensajeError = 'Hubo un problema de conexión';
      Get.off(FailedRegister(mensajeDeError: mensajeError));
    }
    // Detiene la animación de carga
    //isLoading.value = false;
  }

  void handleServerResponseLogin(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      if (respuesta.respuestaExistente?.statusCode == 200) {
        Get.off(() => const HomeScreen());
      } else {
        mensajeError = respuesta.respuestaExistente?.body;
        Get.off(() => FailedLogin(mensajeDeError: mensajeError));
      }
    } else {
      mensajeError = 'HUBO UN PROBLEMA DE CONEXIÓN';
      Get.off(() => FailedRegister(mensajeDeError: mensajeError));
    }
    // Detiene la animación de carga
    //isLoading.value = false;
  }
}
