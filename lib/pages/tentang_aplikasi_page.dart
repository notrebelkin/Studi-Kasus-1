import 'package:flutter/material.dart';
class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});
  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: AppBar(title: const Text('Tentang Aplikasi')),
        body: const Center(child: Text('Nusantara Cerdas Mobile v1.0')));
}