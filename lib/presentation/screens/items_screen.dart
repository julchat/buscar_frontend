import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/controllers/items_controller.dart';

class ItemsScreen extends GetView<ItemsController> {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Hola', style: TextStyle(color: Colors.yellow));
  }
}
