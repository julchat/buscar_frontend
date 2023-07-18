import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../domain/controllers/loading_controller.dart';

class LoadingScreen extends GetView<LoadingController> {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: SpinKitFadingCircle(
                  size: 50.0,
                  color: Colors.blue,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
