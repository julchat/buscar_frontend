class RegisterForm {
  final String contrasenia;
  final String usuario;

  RegisterForm({required this.contrasenia, required this.usuario});

  Map<String, String> aMap() {
    return{'email': usuario, 'password1': contrasenia, 'password2' : contrasenia, 'username': usuario};
  }
}
