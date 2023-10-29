import 'package:buscar_app/infrastructure/conector_backend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../infrastructure/respuesta.dart';
import '../../presentation/screens/loading_screen.dart';
import '../filea64.dart';
import '../punto_y_vertices.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:xml/xml.dart' as xml;
import 'package:path/path.dart' as path;
import 'loading_controller.dart';

class ObjectConfirmationController extends GetxController {
  List<VerticesProcesados> listaDePuntos = [];
  Image primeraImagen = Image.asset('assets/images/buscartransparente.png');
  List<String> nombresUsados = [];
  List<File> listaDeFotosArch = [];

  Rx<String> nombreObjeto = "".obs;
  List<File> archivosEnEnvio = [];
  Future<Directory> appDirectorio = getApplicationDocumentsDirectory();
  void inicializar(Image primeraFoto, List<VerticesProcesados> listaDePuntos,
      List<String> nombresUsados, List<File> listaDeFotosArch) async {
    this.listaDePuntos = listaDePuntos;
    primeraImagen = primeraFoto;
    this.nombresUsados = nombresUsados;
    this.listaDeFotosArch = listaDeFotosArch;
  }

  bool nombreUsado() {
    return nombresUsados.contains(nombreObjeto.value.toUpperCase());
  }

  bool nombreNoValido() {
    return nombreObjeto.value.length < 3;
  }

  void crearObjeto() async {
    Get.offAll(() => const LoadingScreen());
    Directory appDirectory = await appDirectorio;
    File imagen;
    VerticesProcesados vertices;
    for (int i = 0; i < listaDeFotosArch.length; i++) {
      imagen = listaDeFotosArch.elementAt(i);
      vertices = listaDePuntos.elementAt(i);
      print("foto $i agarrada");

      var newFileName = '${nombreObjeto.value}$i';
      var newFileNameJPEG = '$newFileName.jpeg';
      var newFileNameXML = '$newFileName.xml';
      var newPathJPEG = '${appDirectory.path}/$newFileNameJPEG';
      var newPathXML = '${appDirectory.path}/$newFileNameXML';

      File imagenRenombrada = imagen.copySync(newPathJPEG);
      print("foto $i copiada");
      File imagenMetadata =
          armarXML(imagenRenombrada, newPathXML, newFileNameJPEG, newPathJPEG, vertices);

      archivosEnEnvio.add(imagenRenombrada);
      archivosEnEnvio.add(imagenMetadata);
    }
    print(archivosEnEnvio.length);
    enviarArchivos();
  }

  void enviarArchivos() async {
    //Map<File, Future<Respuesta>> respuestasF = {};
    Map<File, Respuesta> respuestas = {};

    for (File archivo in archivosEnEnvio) {
      ConectorBackend conectorBackend = ConectorBackend(
          ruta: 'crear_actualizar_objeto_flutter/',
          method: HttpMethod.post,
          body: {
            'miArchivo': codificarFotoEnBase64(archivo),
            'archivoNombre': path.basename(archivo.path).toString(),
            'objNombre': nombreObjeto.value
          });
      print('pase por el for');
      //respuestasF[archivo] = conectorBackend.hacerRequest();
      respuestas[archivo] = await conectorBackend.hacerRequest();
    }
    print('sali del for');
    bool hayFalloTimeout = false;
    bool hayFalloInesperado = false;
    List<File> archivosABorrar = [];
    Respuesta respuesta;
    for (File archivo in archivosEnEnvio) {
      //Future<Respuesta> respuestaF = respuestasF[archivo]!;
      //Respuesta respuesta = await respuestaF;

      respuesta = respuestas[archivo]!;

      if (respuesta.respuestaExistente!.statusCode == 200 &&
          respuesta.estado == EstadoRespuesta.finalizadaOk) {
        //respuestasF.remove(archivo);
        respuestas.remove(archivo);
        archivosABorrar.add(archivo);
        archivo.delete();
      } else {
        if (respuesta.estado == EstadoRespuesta.timeOut) {
          hayFalloTimeout = true;
        }
        if (respuesta.estado == EstadoRespuesta.finalizadaMal) {
          hayFalloInesperado = true;
        }
      }
    }

    for (File archivo in archivosABorrar) {
      archivosEnEnvio.remove(archivo);
    }

    ResultadoEnvio resultado = hayFalloTimeout
        ? ResultadoEnvio.falloTimeOut
        : (hayFalloInesperado
            ? ResultadoEnvio.falloInesperado
            : ResultadoEnvio.exito);

    LoadingController controllerCarga = Get.find<LoadingController>();
    controllerCarga.handleServerResponseCreateItem(this, resultado);
  }

  File armarXML(
      File imagen, String destino, String nombreJPEG, String rutaJPEG, VerticesProcesados vertices) {
    final builder = xml.XmlBuilder();
    builder.element('annotation', nest: () {
      builder.element('folder', nest: nombreObjeto.value);
      builder.element('filename', nest: nombreJPEG);
      builder.element('path', nest: rutaJPEG);
      builder.element('source', nest: () {
        builder.element('database', nest: 'Unknown');
      });
      builder.element('size', nest: () {
        builder.element('width', nest: vertices.anchoFoto);
        builder.element('height', nest: vertices.altoFoto);
        builder.element('depth', nest: 3);
      });
      builder.element('segmented', nest: 0);
      builder.element('object', nest: () {
        builder.element('name', nest: nombreObjeto.value);
        builder.element('pose', nest: 'Unspecified');
        builder.element('truncated', nest: 0);
        builder.element('difficult', nest: 0);
        builder.element('bndbox', nest: () {
          builder.element('xmin', nest: vertices.xmin);
          builder.element('ymin', nest: vertices.ymin);
          //Aca habría que tocar para poner las dimensiones del objeto
          builder.element('xmax', nest: vertices.xmax);
          builder.element('ymax', nest: vertices.ymax);
        });
      });
    });

    final xmlDocument = builder.buildDocument();

    final file = File(destino);
    file.writeAsStringSync(xmlDocument.toXmlString(pretty: true));

    return file;
  }

  void clear() {
    listaDePuntos = [];
    primeraImagen = Image.asset('assets/images/buscartransparente.png');
    nombresUsados = [];
    listaDeFotosArch = [];
    nombreObjeto = "".obs;
    archivosEnEnvio = [];
  }

  void entrenarObjeto() {
    ConectorBackend conector = ConectorBackend(
        ruta: 'rna_train_flutter/${nombreObjeto.value}/',
        method: HttpMethod.get);
    conector.hacerRequest();
  }
}

enum ResultadoEnvio { exito, falloTimeOut, falloInesperado }