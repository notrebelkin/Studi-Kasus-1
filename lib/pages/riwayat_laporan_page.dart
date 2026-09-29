import 'package:flutter/material.dart';

class RiwayatLaporanPage extends StatelessWidget {
  const RiwayatLaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Laporan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Lampu jalan mati'),
              subtitle: Text('Kec. Utara - 12 Jan'))),
          Card(child: ListTile(title: Text('Sampah menumpuk'),
              subtitle: Text('Kec. Selatan - 20 Jan'))),
          Card(child: ListTile(title: Text('Jalan berlubang'),
              subtitle: Text('Kec. Timur - 02 Feb'))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
            IconButton(icon: const Icon(Icons.filter_alt), onPressed: () {}),
            const SizedBox(width: 40),
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}