import 'dart:convert';

import 'package:buscar_app/domain/controllers/items_controller.dart';
import 'package:buscar_app/infrastructure/conector_backend.dart';
import 'package:buscar_app/presentation/screens/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/objeto.dart';
import '../../infrastructure/respuesta.dart';
import '../screens/loading_screen.dart';
import '../screens/object_gallery_screen.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
        GestureDetector(
            onTap: () {
              verFotos();
            },
            child: Container(
                width: tamanioItems * 0.8,
                height: tamanioItems * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow, width: 4),
                ),
                child: Image(
                  alignment: Alignment.center,
                  image: objeto.foto,
                  fit: BoxFit.cover,
                ))),
        SizedBox(width: tamanioItems * 0.2),
        Expanded(child: 
        GestureDetector(
            onTap: () {
              verFotos();
            },
            
              child: AutoSizeText(
                objeto.nombre,
                style:
                    TextStyle(color: Colors.yellow, fontSize: tamanioItems / 3),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )),
        SizedBox(width: tamanioItems * 0.1),
        FittedBox(
          fit: BoxFit.contain,
          child: IconButton(
            iconSize: tamanioItems * 0.7,
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
            iconSize: tamanioItems * 0.7,
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
                          // ignore: sized_box_for_whitespace
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
                            onPressed: () async {
                              Navigator.of(context).pop();
                              await eliminarObjeto();
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

  Future<void> eliminarObjeto() async {
    Get.to(() => const LoadingScreen());
    Respuesta respuesta = await ConectorBackend(
            method: HttpMethod.delete,
            ruta: 'borrar_objeto_flutter/${objeto.nombre}/')
        .hacerRequest();
    Get.off(() => const ItemsScreen());
    Get.find<ItemsController>().conseguirObjetos();
    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      abrirSnackbar(
          'OBJETO ELIMINADO', '${objeto.nombre} HA SIDO ELIMINADO CON ÉXITO');
    } else {
      abrirSnackbar('NO SE PUDO ELIMINAR',
          'HUBO UN ERROR AL QUERER ELIMINAR ${objeto.nombre}');
    }
  }

  void abrirSnackbar(String titulo, String body) {
    
    SnackbarController snackbar = Get.snackbar(titulo, body,
        colorText: Colors.black,
        backgroundColor: Colors.cyan,
        messageText: Text(body,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: Colors.black)),
        duration: const Duration(seconds: 10),
        snackPosition: SnackPosition.BOTTOM);
  }

  void verFotos() async {
    Get.to(() => const LoadingScreen());
    Respuesta respuesta = await ConectorBackend(
            ruta: 'mostrar_objeto_flutter/${objeto.nombre}/',
            method: HttpMethod.get)
        .hacerRequest();
        
    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      final jsonData = json.decode(respuesta.respuestaExistente!.body);
      List<String> fotosPuras = List<String>.from(jsonData['fotos']);
      List<ImageProvider<Object>> fotosProcesadas = [];
      for (String foto in fotosPuras) {
        fotosProcesadas.add(MemoryImage(base64Decode(foto)));
      }
      
      Get.off(ObjectGalleryScreen(
          fotos: fotosProcesadas, nombreObjeto: objeto.nombre));
    } else {
      Get.off(const ItemsScreen());
      abrirSnackbar('ERROR', 'NO HAY FOTOS PARA ${objeto.nombre}');
    }
  }
}
