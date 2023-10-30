import 'dart:convert';
import 'dart:io';

import 'package:buscar_app/domain/controllers/bind_objects_controller.dart';
import 'package:buscar_app/domain/controllers/object_confirmation_controller.dart';
import 'package:buscar_app/domain/controllers/search_result_controller.dart';
import 'package:buscar_app/infrastructure/csrftokenandsession_controller.dart';
import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:buscar_app/presentation/screens/login_screen.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_create.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_register.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_login.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_logout.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_search.dart';
import 'package:buscar_app/presentation/screens/result_screens/successful_create.dart';
import 'package:buscar_app/presentation/screens/result_screens/successful_register.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../infrastructure/respuesta.dart';
import '../objeto.dart';

class LoadingController extends GetxController {
  var isLoading = true.obs;
  var csrfTokenAndSessionController = Get.find<CsrfTokenAndSessionController>();

  void handleServerResponseRegister(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      Get.off(() => const SuccessfulRegister());
    } else if (respuesta.estado == EstadoRespuesta.finalizadaMal) {
      mensajeError = respuesta.respuestaExistente?.body;
      Get.off(FailedRegister(mensajeDeError: mensajeError));
    } else {
      mensajeError = 'Hubo un problema de conexión';
      Get.off(FailedRegister(mensajeDeError: mensajeError));
    }
  }

  void handleServerResponseLogin(
      Respuesta respuesta, String email, String password) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      final body = json.decode(respuesta.respuestaExistente!.body);
      final String token = body['token'];
      final String session = body['session'];
      csrfTokenAndSessionController.setCsrfToken(token);
      csrfTokenAndSessionController.setSessionId(session);
      escribirCredenciales(email, password);
      Get.off(() => const HomeScreen());
    } else if (respuesta.estado == EstadoRespuesta.finalizadaMal) {
      mensajeError = respuesta.respuestaExistente?.body;
      Get.off(() => FailedLogin(mensajeDeError: mensajeError));
    } else {
      mensajeError = 'HUBO UN PROBLEMA DE CONEXIÓN';
      Get.off(() => FailedLogin(mensajeDeError: mensajeError));
    }
  }

  void handleServerResponseLogout(Respuesta respuesta) {
    String? mensajeError;

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      csrfTokenAndSessionController.setSessionId("");
      borrarCredenciales();
      Get.offAll(() => const LoginScreen());
    } else if (respuesta.estado == EstadoRespuesta.finalizadaMal) {
      mensajeError = respuesta.respuestaExistente?.body;
      Get.off(() => FailedLogout(mensajeDeError: mensajeError));
    } else {
      mensajeError = 'HUBO UN PROBLEMA DE CONEXIÓN';
      Get.off(() => FailedLogout(mensajeDeError: mensajeError));
    }
  }

  void handleServerResponseSearchItem(
      Respuesta respuesta, File foto, Objeto objeto) {
    String? mensajeError;
    print(foto.path.split('/').last);

    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      Get.find<SearchResultController>()
          .procesarRespuesta(respuesta, foto, objeto);
    } else if (respuesta.estado == EstadoRespuesta.finalizadaMal) {
      mensajeError = respuesta.respuestaExistente?.body;
      Get.off(() => FailedSearch(mensajeDeError: mensajeError));
    } else if (respuesta.estado == EstadoRespuesta.timeOut) {
      Get.off(() =>
          const FailedSearch(mensajeDeError: 'HUBO UN PROBLEMA DE CONEXIÓN'));
    }
  }

  void handleServerResponseCreateItem(
      ObjectConfirmationController controller, ResultadoEnvio resultado) {
    if (resultado == ResultadoEnvio.exito) {
      controller.entrenarObjeto();
      controller.clear();
      Get.find<BindObjectsController>().resetState();
      Get.off(() => const SuccessfulCreate());
    } else if (resultado == ResultadoEnvio.falloTimeOut) {
      Get.off(() => FailedCreate(
            controller: controller,
            mensajeDeError: 'HUBO UN PROBLEMA DE CONEXIÓN',
          ));
    } else if (resultado == ResultadoEnvio.falloInesperado) {
      Get.off(() => FailedCreate(
            controller: controller,
            mensajeDeError: 'OCURRIÓ UN ERROR INESPERADO',
          ));
    }
  }

  void escribirCredenciales(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('correo', email);
    await prefs.setString('contrasenia', password);
  }

  void borrarCredenciales() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('correo');
    await prefs.remove('contrasenia');
  }
}
