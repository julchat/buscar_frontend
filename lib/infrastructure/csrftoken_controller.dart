import 'package:get/get.dart';

class CsrfTokenController extends GetxController {
  RxString csrfToken = ''.obs;
  RxString sessionId = ''.obs;

  void setCsrfToken(String token) {
    csrfToken.value = token;
  }
}
