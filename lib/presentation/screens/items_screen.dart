import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:buscar_app/presentation/widgets/boton_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../domain/controllers/items_controller.dart';
import '../../domain/objeto.dart';
import '../widgets/objeto_en_lista.dart';

class ItemsScreen extends GetView<ItemsController> {
  const ItemsScreen({super.key});
  final double tamanioItems = 85;

  @override
  Widget build(BuildContext context) {
    controller.conseguirObjetos();
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
                controller.agregarObjeto();
              },
              tooltip: 'Añadir objeto',
            ),
          ],
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Expanded(child: Obx(() {
                  switch (controller.estadoPantalla.value) {
                    case (EstadoPantalla.inicial):
                      return const SizedBox();
                    case (EstadoPantalla.carga):
                      return dibujarCarga();
                    case (EstadoPantalla.vacio):
                      return dibujarVacio();
                    case (EstadoPantalla.objetos):
                      return dibujarObjetos();
                    case (EstadoPantalla.error):
                      return dibujarError();
                  }
                })))));
  }

  Widget dibujarCarga() {
    return const Center(
        child: Tooltip(
      message: 'Cargando. Por favor espere',
      child: SpinKitFadingCircle(size: 250.0, color: Colors.yellow),
    ));
  }

  Widget dibujarVacio() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'NO HAY UN NINGÚN OBJETO \n\n AGREGUE SU PRIMER OBJETO DESDE EL BOTÓN DE "\+" \n',
          style: TextStyle(
              color: Colors.yellow, fontSize: 40, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget dibujarError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'HA OCURRIDO UN ERROR \n\n POR FAVOR REINTENTE MÁS TARDE \n',
          style: TextStyle(
              color: Colors.yellow, fontSize: 40, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        BotonCustomSinIconoXL(
            onPressed: () => (controller.conseguirObjetos()),
            contenido: 'REINTENTAR')
      ],
    );
  }

  ListView dibujarObjetos() {
    return ListView.builder(
        itemCount: controller.itemsList.length,
        itemBuilder: ((context, index) {
          final Objeto objeto = controller.itemsList[index];
          return Column(children: [
            SizedBox(height: tamanioItems / 2),
            SizedBox(
                height: tamanioItems,
                child: ObjetoEnLista(
                    objeto: objeto,
                    tamanioItems: tamanioItems,
                    controller: controller))
          ]);
        }));
  }
}
