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
  static const String beranda = '/';
  static const String layanan = '/layanan';
  static const String detailLayanan = '/layanan/detail';
  static const String warga = '/warga';
  static const String detailPengajuan = '/warga/detail-pengajuan';
  static const String formPengajuan = '/warga/form-pengajuan';
  static const String tanyaPetugas = '/warga/tanya-petugas';
  static const String lokasiKantor = '/warga/lokasi-kantor';
  static const String statistikLayanan = '/warga/statistik';
  static const String riwayatLaporan = '/warga/riwayat';
  static const String pengaturanKota = '/pengaturan';
  static const String tentangAplikasi = '/tentang';

  static Map<String, WidgetBuilder> daftarRoute() {
    return {
      beranda: (context) => const KerangkaNavigasi(),
      layanan: (context) => const LayananPage(),
      warga: (context) => const WargaPage(),
      formPengajuan: (context) => const FormPengajuanPage(),
      tanyaPetugas: (context) => const TanyaPetugasPage(),
      lokasiKantor: (context) => const LokasiKantorPage(),
      statistikLayanan: (context) => const StatistikLayananPage(),
      riwayatLaporan: (context) => const RiwayatLaporanPage(),
      pengaturanKota: (context) => const PengaturanKotaPage(),
      tentangAplikasi: (context) => const TentangAplikasiPage(),
    };
  }

  static Route<dynamic>? bentukRoute(RouteSettings settings) {
    if (settings.name == detailLayanan) {
      final data = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (_) => DetailLayananPage(data: data),
        settings: settings,
      );
    }
    if (settings.name == detailPengajuan) {
      final data = settings.arguments as Pengajuan;
      return MaterialPageRoute(
        builder: (_) => DetailPengajuanPage(pengajuan: data),
        settings: settings,
      );
    }
    return null;
  }

  static Route<dynamic> routeTidakDikenal(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => RouteTidakDikenalPage(namaRoute: settings.name ?? ''),
      settings: settings,
    );
  }
}