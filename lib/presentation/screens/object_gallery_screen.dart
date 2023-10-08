import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ObjectGalleryScreen extends StatelessWidget {
  final List<ImageProvider<Object>> fotos;
  final String nombreObjeto;

  const ObjectGalleryScreen({
    Key? key,
    required this.fotos,
    required this.nombreObjeto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FOTOS DE $nombreObjeto'),
        centerTitle: true,
          leading: IconButton(
          padding: const EdgeInsets.only(bottom: 1, left: 5),
          icon: const Icon(Icons.arrow_back),
          iconSize: 55,
          onPressed: () {
            Get.back();
          },
        tooltip: 'Regresar al catálogo')),
        body: Column(
        children: [
          const SizedBox(height: 15), // Espacio adicional sobre la primera fila de fotos
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: fotos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 6.0),
                    ),
                    child: Image(
                      image: fotos[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}