import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  var isLoading = true.obs;

  void handleServerResponse() {
    // Aquí recibes la respuesta del servidor
    // ...

    // Dependiendo de la respuesta, redirige a una pantalla u otra
    if (true) {
      // Redirige a la pantalla A
      Get.off(const HomeScreen());
    } else {
      // Redirige a la pantalla B
      Get.offNamed('/pantalla_b');
    }

    // Detiene la animación de carga
    isLoading.value = false;
  }
}
