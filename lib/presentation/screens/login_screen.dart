import 'package:buscar_app/presentation/screens/loading_screen.dart';
import 'package:buscar_app/presentation/screens/register_screen.dart';
import 'package:buscar_app/presentation/screens/splash_screen.dart';
import 'package:buscar_app/presentation/widgets/boton_custom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';

import '../../domain/controllers/loading_controller.dart';
import '../../domain/forms/login_form.dart';
import '../../infrastructure/conector_backend.dart';
import '../../infrastructure/respuesta.dart';

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
                return null;
              },
            ),
            const SizedBox(height: 30),

          
            BotonCustomConIcono(onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) return;

                  Get.off(const LoadingScreen());
                  Map<String, String> jsonRegistro =
                      LoginForm(usuario: email, contrasenia: password)
                          .aMap();
                  ConectorBackend conector = ConectorBackend(
                      ruta: '/login_flutter/',
                      method: HttpMethod.post,
                      body: jsonRegistro);

                  Respuesta respuesta = await conector.hacerRequest();
                  LoadingController loadingController = Get.find();
                  loadingController.handleServerResponseLogin(respuesta);
                }
            , contenido: 'INICIAR SESIÓN', icono: Icons.door_sliding),
           

            const SizedBox(height: 30),

            BotonCustomConIcono(onPressed: () => Get.to(() => const RegisterScreen()),
            contenido: 'NUEVO USUARIO',
            icono: Icons.person_add_alt_1,),

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

