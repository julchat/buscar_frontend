import 'package:buscar_app/domain/controllers/loading_controller.dart';
import 'package:buscar_app/presentation/screens/loading_screen.dart';
import 'package:buscar_app/presentation/widgets/boton_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/controllers/object_confirmation_controller.dart';
import '../widgets/custom_text_form_field.dart';

class ObjectConfirmationScreen extends GetView<ObjectConfirmationController> {
  const ObjectConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIRMAR OBJETO'),
        centerTitle: true,
        leading: IconButton(
          padding: const EdgeInsets.only(bottom: 1, left: 5),
          icon: const Icon(Icons.arrow_back),
          iconSize: 55,
          onPressed: () {
            Get.back();
          },
          tooltip: 'Volver hacia delimitación de fotos',
        ),
      ),
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 0, horizontal: 40.0),
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Container(
                  alignment: Alignment.center,
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(
                          255, 2, 8, 97), // Color del borde externo (cian)
                      width: 10.0, // Ancho del borde externo
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(
                            255, 241, 43, 1), // Color del borde interno (negro)
                        spreadRadius: 10, // Cuanto se expande el sombreado
                        blurRadius: 0, // Qué tan borroso es el sombreado
                      ),
                    ],
                  ),
                  child: controller.primeraImagen),
              const SizedBox(height: 100),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: CustomTextFormField(
                  label: 'NOMBRE OBJETO',
                  onChanged: (value) => controller.nombreObjeto.value = value,
                  validator: (value) {
                    if (controller.nombreNoValido()) {
                      return 'AL MENOS TRES CARACTERES';
                    }
                    if (controller.nombreUsado()) {
                      return 'YA TIENE UN OBJETO CON ESE NOMBRE';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 100),
              BotonCustomSinIconoXL(
                  onPressed: () {
                    if (!controller.nombreNoValido() &&
                        !controller.nombreUsado()) {
                      controller.crearObjeto();
                    }
                  },
                  contenido: 'AÑADIR OBJETO')
            ],
          ))),
    );
  }
}
