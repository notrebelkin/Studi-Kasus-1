import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';

class StatistikLayananPage extends StatelessWidget {
  const StatistikLayananPage({super.key});

  @override
  Widget build(BuildContext context) {
    final perBidang = context.watch<PengajuanModel>().jumlahPerBidang;
    final bidang = perBidang.keys.toList();
    final nilai = perBidang.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Layanan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Jumlah Pengajuan per Bidang',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (nilai.isEmpty
                          ? 5
                          : (nilai.reduce((a, b) => a > b ? a : b) + 2))
                      .toDouble(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, meta) => Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(bidang[v.toInt()],
                              style: const TextStyle(fontSize: 11)),
                        ),
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: List.generate(bidang.length, (i) {
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: nilai[i].toDouble(),
                          width: 28,
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.teal,
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text('Total pengajuan: ${context.watch<PengajuanModel>().totalPengajuan}'),
          ],
        ),
      ),
    );
  }
}