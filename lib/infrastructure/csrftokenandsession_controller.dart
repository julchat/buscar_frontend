import 'package:get/get.dart';

class CsrfTokenAndSessionController extends GetxController {
  RxString csrfToken = ''.obs;
  RxString sessionId = ''.obs;

  void setCsrfToken(String token) {
    csrfToken.value = token;
    print('nuevo token: $token');
  }

  void setSessionId(String session) {
    sessionId.value = session;
    print('nuevo sesion: $session');
  }

  String getCsrfToken() {
    return csrfToken.value;
  }
}
