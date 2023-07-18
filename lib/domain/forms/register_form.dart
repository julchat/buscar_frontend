import 'dart:convert';

class RegisterForm {
  final String contrasenia;
  final String usuario;

  RegisterForm({required this.contrasenia, required this.usuario});

  String aJson() {
    return jsonEncode(this);
  }
}
