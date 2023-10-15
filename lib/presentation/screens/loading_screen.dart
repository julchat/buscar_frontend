import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../domain/controllers/loading_controller.dart';

class LoadingScreen extends GetView<LoadingController> {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Tooltip(
        message: 'Cargando. Por favor espere',
        child: SpinKitFadingCircle(size: 250.0, color: Colors.yellow),
      ),
    ));
  }
}
