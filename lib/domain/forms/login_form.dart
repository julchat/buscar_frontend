class LoginForm {
  final String contrasenia;
  final String usuario;

  LoginForm({required this.contrasenia, required this.usuario});

  Map<String, String> aMap() {
    return{'email': usuario, 'password': contrasenia};
  }
}