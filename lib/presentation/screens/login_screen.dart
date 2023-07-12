import 'package:buscar_app/presentation/screens/register_screen.dart';
import 'package:buscar_app/presentation/screens/splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/custom_text_form_field.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('INICIAR SESIÓN'),
        centerTitle: true,
      ),
      body: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  @override
  Widget build(BuildContext context) {
    Image logoBuscar = Image.asset('assets/images/buscartransparente.png');
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 40),
              logoBuscar,
              const SizedBox(height: 40),
              const _LoginForm(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              label: 'CORREO ELECTRÓNICO',
              onChanged: (value) => email = value,
              validator: (value) {
                if (value == null || value.isEmpty) return 'CAMPO REQUERIDO';
                if (value.trim().isEmpty) return 'CAMPO REQUERIDO';
                //TODO: Validación de Mail contra DB.
                return null;
              },
            ),
            const SizedBox(height: 50),
            CustomTextFormField(
              label: 'CONTRASEÑA',
              obscureText: true,
              onChanged: (value) => password = value,
              validator: (value) {
                if (value == null || value.isEmpty) return 'CAMPO REQUERIDO';
                if (value.trim().isEmpty) return 'CAMPO REQUERIDO';
                //TODO: Validación de Contraseña contra DB
                return null;
              },
            ),
            const SizedBox(height: 30),
            FilledButton.tonalIcon(
                onPressed: () {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) return;
                  //TODO: Generar alguna persistencia de credenciales para logeo automatico o sessionID
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                  print('$email, $password');
                },
                icon: const Icon(Icons.door_sliding, size: 40),
                label: const Text('INICIAR SESIÓN',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(40, 65)))),
            const SizedBox(height: 30),
            FilledButton.tonalIcon(
                onPressed: () {
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen());
                },
                icon: const Icon(Icons.person_add_alt_1, size: 40),
                label: const Text('NUEVO USUARIO',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(40, 65)))),
            const SizedBox(height: 15),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text.rich(
                  TextSpan(
                    text: 'OLVIDÉ MI CONTRASEÑA',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SplashScreen()));
                      },
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                )))
          ],
        ));
  }
}
