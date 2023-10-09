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

  DimensionRectangulo._(
      {required this.xmin,
      required this.xmax,
      required this.ymin,
      required this.ymax,
      required this.precision});

  factory DimensionRectangulo.fromJson(
      {required Map<String, dynamic> ubicaciones, required double accuraccy}) {
    return DimensionRectangulo._(
        xmin: ubicaciones['xmin'].toDouble(),
        xmax: ubicaciones['xmax'].toDouble(),
        ymin: ubicaciones['ymin'].toDouble(),
        ymax: ubicaciones['ymax'].toDouble(),
        precision: accuraccy);
  }
 
}
