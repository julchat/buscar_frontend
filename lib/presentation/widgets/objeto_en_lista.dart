import 'package:buscar_app/domain/controllers/items_controller.dart';
import 'package:buscar_app/presentation/screens/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("ELIMINAR OBJETO",
                        style: TextStyle(fontSize: 20)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 30.0),
                    content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 500,
                            height: 500,
                            child: Image(image: objeto.foto),
                            // Aquí puedes agregar la imagen dentro del Container.
                          ),
                          const SizedBox(height: 4),
                          Text("¿DESEA ELIMINAR ${objeto.nombre}?",
                              style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 10)
                        ]),
                    actions: <Widget>[
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              // Cerrar el diálogo.
                              Navigator.of(context).pop();
                            },
                            child: const Text("CANCELAR",
                                style: TextStyle(fontSize: 20)),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.off(() => const ItemsScreen());
                              Navigator.of(context).pop();
                            },
                            child: const Text("CONFIRMAR",
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
