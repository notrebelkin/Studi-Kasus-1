import 'package:flutter/material.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  static const _pilar = [
    ('Smart Governance', Icons.account_balance, Colors.blue),
    ('Smart Economy', Icons.trending_up, Colors.orange),
    ('Smart Mobility', Icons.directions_bus, Colors.green),
    ('Smart Environment', Icons.eco, Colors.teal),
    ('Smart People', Icons.people, Colors.purple),
    ('Smart Living', Icons.home_work, Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => Navigator.pushNamed(context, '/tidak-ada-route'),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: _pilar.map((p) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(p.$2, size: 42, color: p.$3),
                  const SizedBox(height: 8),
                  Text(p.$1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}