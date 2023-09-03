import 'dart:convert';

import 'package:flutter/material.dart';

class Objeto {
  int id;
  String nombre;
  bool detectable;
  ImageProvider<Object> foto;

  // Constructor privado, ya que usaremos factory methods para crear instancias
  Objeto._({
    required this.id,
    required this.nombre,
    required this.detectable,
    required this.foto,
  });

  // Factory method para crear una instancia de Objeto desde una URL
  factory Objeto.fromUrl({
    required int id,
    required String nombre,
    required bool detectable,
    required String imageUrl,
  }) {
    return Objeto._(
      id: id,
      nombre: nombre,
      detectable: detectable,
      foto: NetworkImage(imageUrl),
    );
  }

  // Factory method para crear una instancia de Objeto desde base64
  factory Objeto.fromBase64({
    required int id,
    required String nombre,
    required bool detectable,
    required String fotoBase64,
  }) {
    return Objeto._(
      id: id,
      nombre: nombre,
      detectable: detectable,
      foto: MemoryImage(base64Decode(fotoBase64)),
    );
  }

  factory Objeto.fromJson({
    required Map<String, dynamic> objeto,
  }) {
    if (objeto['primerafoto'] == 'error') {
      // Si 'primerafoto' es igual a 'error', establece una imagen por defecto
      return Objeto._(
        id: objeto['id'],
        nombre: objeto['nombre'],
        detectable: objeto['detectable'],
        foto: const AssetImage('assets/images/buscartransparente.png'),
      );
    } else {
      // Si 'primerafoto' es una cadena Base64 válida, decódifícala y úsala como imagen
      return Objeto._(
        id: objeto['id'],
        nombre: objeto['nombre'],
        detectable: objeto['detectable'],
        foto: MemoryImage(base64Decode(objeto['primerafoto'])),
      );
    }
  }
}
