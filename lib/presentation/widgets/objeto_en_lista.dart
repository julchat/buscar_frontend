import 'package:buscar_app/domain/controllers/items_controller.dart';
import 'package:flutter/material.dart';

import '../../domain/objeto.dart';

class ObjetoEnLista extends StatelessWidget {
  final Objeto objeto;
  final double tamanioItems;
  final ItemsController controller;

  const ObjetoEnLista(
      {super.key,
      required this.objeto,
      required this.tamanioItems,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: tamanioItems * 0.20),
        Container(
          width: tamanioItems,
          height: tamanioItems,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.yellow, width: 4),
          ),
          child: Image(
            alignment: Alignment.center,
            image: objeto.foto,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: tamanioItems * 0.2),
        Expanded(
          child: Text(
            objeto.nombre,
            style: TextStyle(color: Colors.yellow, fontSize: tamanioItems / 3),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: tamanioItems * 0.1),
        FittedBox(
          fit: BoxFit.contain,
          child: IconButton(
            iconSize: tamanioItems * 2,
            icon: const Icon(Icons.search, color: Colors.yellow),
            onPressed: () {
              if (objeto.detectable) {
                controller.buscarObjeto(objeto);
              } else {
                controller.abrirSnackbar(objeto);
              }
            },
          ),
        ),
        FittedBox(
          fit: BoxFit.contain,
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.yellow),
            iconSize: tamanioItems * 2,
            onPressed: () {
              // Agrega la lógica para eliminar el objeto
            },
          ),
        ),
      ],
    );
  }
}
