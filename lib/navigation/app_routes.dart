import 'package:flutter/material.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/detail_layanan_page.dart';
import '../pages/warga_page.dart';
import '../pages/riwayat_laporan_page.dart';
import '../pages/pengaturan_kota_page.dart';
import '../pages/tentang_aplikasi_page.dart';
import '../pages/route_tidak_dikenal_page.dart';
import '../navigation/kerangka_navigasi.dart';

class AppRoutes {
  // Konstanta nama route
  static const String beranda = '/';
  static const String layanan = '/layanan';
  static const String detailLayanan = '/layanan/detail';
  static const String warga = '/warga';
  static const String riwayatLaporan = '/warga/riwayat';
  static const String pengaturanKota = '/pengaturan';
  static const String tentangAplikasi = '/tentang';
  static const String tidakDikenal = '/tidak-dikenal';

  // Daftar route (untuk properti routes pada MaterialApp)
  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      layanan: (context) => const LayananPage(),
      warga: (context) => const WargaPage(),
      riwayatLaporan: (context) => const RiwayatLaporanPage(),
      pengaturanKota: (context) => const PengaturanKotaPage(),
      tentangAplikasi: (context) => const TentangAplikasiPage(),
    };
  }

  // Untuk onGenerateRoute (menangani route dengan arguments)
  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    switch (settings.name) {
      case detailLayanan:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => DetailLayananPage(data: data),
          settings: settings,
        );
      default:
        return null; // biarkan routes yang menangani
    }
  }

  // Untuk onUnknownRoute
  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => RouteTidakDikenalPage(namaRoute: settings.name ?? ''),
      settings: settings,
    );
  }
}