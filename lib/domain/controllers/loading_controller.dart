import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:buscar_app/presentation/screens/login_screen.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_register.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_login.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_logout.dart';
import 'package:buscar_app/presentation/screens/result_screens/successful_register.dart';
import 'package:get/get.dart';
import '../../infrastructure/respuesta.dart';

class LoadingController extends GetxController {
  var isLoading = true.obs;

  void handleServerResponseRegister(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      if (respuesta.respuestaExistente?.statusCode == 200) {
        Get.off(() => const SuccessfulRegister());
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
      Get.off(() => FailedLogin(mensajeDeError: mensajeError));
    }
    // Detiene la animación de carga
    //isLoading.value = false;
  }

  void handleServerResponseLogout(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      if (respuesta.respuestaExistente?.statusCode == 200) {
        Get.off(() => const LoginScreen());
      } else {
        mensajeError = respuesta.respuestaExistente?.body;
        Get.off(() => FailedLogout(mensajeDeError: mensajeError));
      }
    } else {
        mensajeError = 'HUBO UN PROBLEMA DE CONEXIÓN';
        Get.off(() => FailedLogout(mensajeDeError: mensajeError));
    }

    }
}

