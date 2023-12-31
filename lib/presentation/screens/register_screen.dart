import 'package:buscar_app/domain/forms/register_form.dart';
import 'package:buscar_app/presentation/screens/loading_screen.dart';
import 'package:buscar_app/presentation/screens/login_screen.dart';
import 'package:buscar_app/presentation/widgets/custom_text_form_field.dart';
import 'package:buscar_app/presentation/widgets/texto_terminos_y_servicios.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/infrastructure/conector_backend.dart';
import 'package:get/get.dart';

import '../../domain/controllers/loading_controller.dart';
import '../../infrastructure/respuesta.dart';
//import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NUEVO USUARIO'),
        centerTitle: true,
          leading: IconButton(
          padding: const EdgeInsets.only(bottom: 1, left: 5),
          icon: const Icon(Icons.arrow_back),
          iconSize: 55,
          onPressed: () {
            Get.off(() => const LoginScreen());
          },
          tooltip: 'Volver hacia atrás',
        ),
      ),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

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
              const _RegisterForm(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String passwordRepetida = '';

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
                final emailRegExp = RegExp(
                  r'^[a-zA-Z0-9ñ]+([\.-]?[a-zA-Z0-9ñ]+)*@([a-zA-Z0-9ñ]+([\.-]?[a-zA-Z0-9ñ]+)*)+\.[a-zA-Z]{2,4}$',
                );

                if (!emailRegExp.hasMatch(value)) {
                  return 'NO TIENE FORMATO DE CORREO';
                }
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
                if (value.length < 6) return 'MÁS DE 6 CARACTERES';
                final contraseniaRegExpMayusc = RegExp(r'^(?=.*?[A-Z])');
                final contraseniaRegExpMinusc = RegExp(r'^(?=.*?[a-z])');
                final contraseniaRegExpDigito = RegExp(r'^(?=.*?[0-9])');
                //r'^
                //(?=.*[A-Z])       // Al menos una mayúscula
                //(?=.*[a-z])       // Al menos una minúscula
                //(?=.*?[0-9])      // Al menos un dígito
                if (!contraseniaRegExpMayusc.hasMatch(value)) {
                  return 'La contraseña debe tener al menos una mayúscula'
                      .toUpperCase();
                }
                if (!contraseniaRegExpMinusc.hasMatch(value)) {
                  return 'La contraseña debe tener al menos una minúscula'
                      .toUpperCase();
                }
                if (!contraseniaRegExpDigito.hasMatch(value)) {
                  return 'La contraseña debe tener al menos un dígito'
                      .toUpperCase();
                }
                return null;
              },
            ),
            const SizedBox(height: 50),
            CustomTextFormField(
              label: 'REPITA CONTRASEÑA',
              obscureText: true,
              onChanged: (value) => passwordRepetida = value,
              validator: (value) {
                if (value != password) {
                  return 'LAS CONTRASEÑAS DEBEN COINCIDIR';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            const Center(child: PrivacyPolicyLinkAndTermsOfService()),
            const SizedBox(height: 30),
            FilledButton.tonalIcon(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (!isValid) return;

                  Get.off(() => const LoadingScreen());

                  Map<String, String> jsonRegistro =
                      RegisterForm(usuario: email, contrasenia: password)
                          .aMap();
                  ConectorBackend conector = ConectorBackend(
                      ruta: '/register_flutter/',
                      method: HttpMethod.post,
                      body: jsonRegistro);

                  Respuesta respuesta = await conector.hacerRequest();
                  LoadingController loadingController = Get.find();
                  loadingController.handleServerResponseRegister(respuesta);
                },
                icon: const Icon(Icons.person, size: 40),
                label: const Text('CREAR USUARIO',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(40, 65)))),
          ],
        ));
  }
}
