import 'dart:convert';
import 'dart:io';

import 'package:buscar_app/infrastructure/csrftokenandsession_controller.dart';
import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:buscar_app/presentation/screens/login_screen.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_register.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_login.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_logout.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_search.dart';
import 'package:buscar_app/presentation/screens/result_screens/successful_register.dart';
import 'package:get/get.dart';
import '../../infrastructure/respuesta.dart';
import '../../presentation/screens/search_result_screen.dart';
import '../objeto.dart';

class LoadingController extends GetxController {
  var isLoading = true.obs;
  var csrfTokenAndSessionController = Get.find<CsrfTokenAndSessionController>();

  void handleServerResponseRegister(Respuesta respuesta) {
    String? mensajeError;

      if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
        Get.off(() => const SuccessfulRegister());
      } 
      else if(respuesta.estado == EstadoRespuesta.finalizadaMal){
        mensajeError = respuesta.respuestaExistente?.body;
        Get.off(FailedRegister(mensajeDeError: mensajeError));
      }
    else {
      mensajeError = 'Hubo un problema de conexión';
      Get.off(FailedRegister(mensajeDeError: mensajeError));
    }
  }

  void handleServerResponseLogin(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
        final body = json.decode(respuesta.respuestaExistente!.body);
        final String token = body['token'];
        final String session = body['session'];
        csrfTokenAndSessionController.setCsrfToken(token);
        csrfTokenAndSessionController.setSessionId(session);
        Get.off(() => const HomeScreen());
      } 
    else if(respuesta.estado == EstadoRespuesta.finalizadaMal) {
        mensajeError = respuesta.respuestaExistente?.body;
        Get.off(() => FailedLogin(mensajeDeError: mensajeError));
    }
    else {
      mensajeError = 'HUBO UN PROBLEMA DE CONEXIÓN';
      Get.off(() => FailedLogin(mensajeDeError: mensajeError));
    }
  }

  void handleServerResponseLogout(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
        csrfTokenAndSessionController.setSessionId("");
        Get.off(() => const LoginScreen());
      } else if(respuesta.estado == EstadoRespuesta.finalizadaMal) {
        mensajeError = respuesta.respuestaExistente?.body;
        Get.off(() => FailedLogout(mensajeDeError: mensajeError));
      }
    else {
      mensajeError = 'HUBO UN PROBLEMA DE CONEXIÓN';
      Get.off(() => FailedLogout(mensajeDeError: mensajeError));
    }
  }

  void handleServerResponseSearchItem(
      Respuesta respuesta, File foto, Objeto objeto) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
        Get.off(() => (SearchResultScreen(
            respuesta: respuesta, foto: foto, objeto: objeto)));
      } else if (respuesta.estado == EstadoRespuesta.finalizadaMal) {
        mensajeError = respuesta.respuestaExistente?.body;
        Get.off(() => const FailedSearch());
      }
    else if(respuesta.estado == EstadoRespuesta.timeOut) {
      Get.off(() =>
          const FailedSearch(mensajeDeError: 'HUBO UN PROBLEMA DE CONEXIÓN'));
    }
  }
}
