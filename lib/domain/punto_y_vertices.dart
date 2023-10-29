class Punto {
  double coordenadaX;
  double coordenadaY;

  Punto({required this.coordenadaX, required this.coordenadaY});
}

class ParVertices {
  Punto verticeViejo;
  Punto verticeNuevo;

  ParVertices({Punto? verticeViejo, Punto? verticeNuevo})
      : verticeViejo = verticeViejo ?? Punto(coordenadaX: -1, coordenadaY: -1),
        verticeNuevo = verticeNuevo ?? Punto(coordenadaX: -1, coordenadaY: -1);
}

class VerticesProcesados {
  int xmin;
  int xmax;
  int ymin;
  int ymax;

  int anchoFoto;
  int altoFoto;

  VerticesProcesados(
      {required this.xmin,
      required this.xmax,
      required this.ymin,
      required this.ymax,
      required this.anchoFoto,
      required this.altoFoto});
}
