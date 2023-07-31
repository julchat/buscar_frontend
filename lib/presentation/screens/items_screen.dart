import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/controllers/items_controller.dart';
import '../../domain/objeto.dart';
import '../widgets/objeto_en_lista.dart';

class ItemsScreen extends GetView<ItemsController> {
  const ItemsScreen({super.key});
  final double tamanioItems = 85;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CATÁLOGO'),
          centerTitle: true,
          leading: IconButton(
            padding: const EdgeInsets.only(bottom: 1, left: 5),
            icon: const Icon(Icons.arrow_back),
            iconSize: 55,
            onPressed: () {
              Get.off(() => const HomeScreen());
            },
            tooltip: 'Volver hacia menú',
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 60,
              padding: const EdgeInsets.only(bottom: 10),
              onPressed: () {
                // Aquí puedes poner la función que deseas que se ejecute cuando se presione el botón '+'
              },
              tooltip: 'Añadir objeto',
            ),
          ],
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: controller.itemsList.length,
                      itemBuilder: ((context, index) {
                        final Objeto objeto = controller.itemsList[index];
                        return Column(children: [
                          SizedBox(height: tamanioItems/2),
                          SizedBox(
                              height: tamanioItems, child: ObjetoEnLista(objeto: objeto, tamanioItems: tamanioItems, controller: controller))
                        ]);
                      })))
            ],
          ),
        )));
  }
}
