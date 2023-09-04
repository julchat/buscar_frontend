class DimensionRectangulo {
  final double xmin;
  final double xmax;
  final double ymin;
  final double ymax;
  final double precision;

  const DimensionRectangulo(
      {required this.xmin,
      required this.xmax,
      required this.ymin,
      required this.ymax,
      required this.precision});

    DimensionRectangulo._({
    required this.xmin,
    required this.xmax,
    required this.ymin,
    required this.ymax,
    required this.precision
  });

        factory DimensionRectangulo.fromJson({
    required Map<String, dynamic> ubicaciones,
  }) {
      return DimensionRectangulo._(
        xmin: ubicaciones['xmin'],
        xmax: ubicaciones['xmax'],
        ymin: ubicaciones['ymin'],
        ymax: ubicaciones['ymax'],
        precision: ubicaciones['precision']
      );
  }
}