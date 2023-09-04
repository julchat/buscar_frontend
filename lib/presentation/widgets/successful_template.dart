import 'package:flutter/material.dart';

import 'boton_custom.dart';

class SuccessfulTemplate extends StatelessWidget {
  final String textoDeResultado;
  final String textoDeBoton;
  final void Function() onPressed;
  const SuccessfulTemplate(
      {super.key,
      required this.textoDeBoton,
      required this.textoDeResultado,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
            padding: const EdgeInsets.all(20),
            child: 
            Center (child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Tooltip(message: 'Éxito', child: Icon(Icons.check, size: 300, color: Colors.yellow)),
        const SizedBox(height: 50),
        Center(child: Text(textoDeResultado, style: const TextStyle(color: Colors.yellow, fontSize: 40, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
        const SizedBox(height: 50),
        BotonCustomSinIcono(onPressed: onPressed, contenido: textoDeBoton)
      ],
    )))));
  }
}
