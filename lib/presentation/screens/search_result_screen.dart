import 'dart:io';

import 'package:buscar_app/domain/controllers/search_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/objeto.dart';
import '../../infrastructure/respuesta.dart';

class SearchResultScreen extends GetView<SearchResultController> {
  final Respuesta respuesta;
  final Objeto objeto;
  final File foto;

  const SearchResultScreen(
      {super.key,
      required this.respuesta,
      required this.objeto,
      required this.foto});

  @override
  Widget build(BuildContext context) {
    print(respuesta.respuestaExistente!.body);
    throw UnimplementedError();
  }
}
