import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Buscar App!!',style: TextStyle(fontSize: 30)),
        Icon(Icons.handshake, size: 150),
      ],) ,));
  }
}