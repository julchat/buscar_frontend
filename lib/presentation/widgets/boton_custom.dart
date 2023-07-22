import 'package:flutter/material.dart';

class BotonCustomConIcono extends StatelessWidget {
  final void Function()? onPressed;
  final String contenido;
  final IconData icono;
  const BotonCustomConIcono(
      {super.key,
      required this.onPressed,
      required this.contenido,
      required this.icono});

    @override
    Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
        icon: Icon(icono, size: 40),
        onPressed: onPressed,
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(40, 65))),
            label: Text(
          contenido,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ));
  }
}

class BotonCustomSinIcono extends StatelessWidget {
  final void Function()? onPressed;
  final String contenido;

  const BotonCustomSinIcono(
      {super.key,
      required this.onPressed,
      required this.contenido});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(40, 65))),
            child: Text(
          contenido,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ));
  }
}

class BotonCustomSinIconoXL extends StatelessWidget{
  final void Function()? onPressed;
  final String contenido;

  const BotonCustomSinIconoXL(
      {super.key,
      required this.onPressed,
      required this.contenido});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(450, 100))),
            child: Text(
          contenido,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ));
  }
}
