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