import 'package:http/http.dart';

enum EstadoRespuesta { enCurso, finalizadaOk, timeOut, finalizadaMal }

class Respuesta {
  Response? respuestaExistente;
  EstadoRespuesta estado = EstadoRespuesta.enCurso;

  Respuesta({
    this.respuestaExistente,
    this.estado = EstadoRespuesta.enCurso,
  });

  void finalizarOk() {
    estado = EstadoRespuesta.finalizadaOk;
  }

  void finalizarTimeOut() {
    estado = EstadoRespuesta.timeOut;
  }

  void finalizarMal() {
    estado = EstadoRespuesta.finalizadaMal;
  }
}
