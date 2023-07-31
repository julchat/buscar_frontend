import 'dart:convert';

import 'package:flutter/material.dart';

class Objeto {
  String nombre;
  bool disponible;
  ImageProvider<Object> foto;

  // Constructor privado, ya que usaremos factory methods para crear instancias
  Objeto._({
    required this.nombre,
    required this.disponible,
    required this.foto,
  });

  // Factory method para crear una instancia de Objeto desde una URL
  factory Objeto.fromUrl({
    required String nombre,
    required bool disponible,
    required String imageUrl,
  }) {
    return Objeto._(
      nombre: nombre,
      disponible: disponible,
      foto: NetworkImage(imageUrl),
    );
  }

  // Factory method para crear una instancia de Objeto desde base64
  factory Objeto.fromBase64({
    required String nombre,
    required bool disponible,
    required String fotoBase64,
  }) {
    return Objeto._(
      nombre: nombre,
      disponible: disponible,
      foto: MemoryImage(base64Decode(fotoBase64)),
    );
  }
}
