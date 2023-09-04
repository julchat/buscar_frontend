import 'package:buscar_app/presentation/widgets/boton_custom.dart';
import 'package:flutter/material.dart';

class NeutralTemplate extends StatelessWidget {
  final String textoDeResultado;
  final String textoDeBoton;
  final void Function() onPressed;
  final String? textoDeBoton2;
  final void Function()? onPressedBoton2;
  final String? textoDeBoton3;
  final void Function()? onPressedBoton3;
  const NeutralTemplate({
    super.key,
    required this.textoDeBoton,
    required this.textoDeResultado,
    required this.onPressed,
    this.textoDeBoton2,
    this.onPressedBoton2,
    this.textoDeBoton3,
    this.onPressedBoton3,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Center(
                        child: Text(
                      textoDeResultado,
                      style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(height: 50),
                    BotonCustomSinIcono(
                        onPressed: onPressed, contenido: textoDeBoton),
                    if (textoDeBoton2 != null)
                      SizedBoxWithBotonCustomSinIcono(tamanioBox: 30, onPressed: onPressedBoton2!, contenido: textoDeBoton2!),
                    if (textoDeBoton3 != null)
                      SizedBoxWithBotonCustomSinIcono(tamanioBox: 30, onPressed: onPressedBoton3!, contenido: textoDeBoton3!),
                  ],
                )))));
  }
}

class SizedBoxWithBotonCustomSinIcono extends StatelessWidget {
  final double tamanioBox;
  final void Function() onPressed;
  final String contenido;
  const SizedBoxWithBotonCustomSinIcono(
      {super.key,
      required this.tamanioBox,
      required this.onPressed,
      required this.contenido});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: tamanioBox),
        BotonCustomSinIcono(onPressed: onPressed, contenido: contenido)
      ],
    );
  }
}