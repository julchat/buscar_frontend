import 'dart:convert';
import 'dart:io';

String codificarFotoEnBase64(File archivoFoto) {
  try {
    if (archivoFoto.existsSync()) {
      final List<int> bytes = archivoFoto.readAsBytesSync();
      final String base64Image = base64Encode(bytes);
      return base64Image;
    }
  } catch (e) {
    print('Error al codificar la imagen en Base64: $e');
  }
  return ''; // Devuelve una cadena vacía o un valor por defecto si hay un error o el archivo no existe
}