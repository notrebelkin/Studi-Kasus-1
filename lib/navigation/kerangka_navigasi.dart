import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/pengajuan_model.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksAktif = 0;

  static const List<Widget> _halaman = [
    BerandaPage(),
    LayananPage(),
    WargaPage(),
  ];

  static const List<String> _judul = ['Beranda', 'Layanan', 'Warga'];

  void _pindahTujuan(int indeks) {
    if (indeks == _indeksAktif) return;
    setState(() => _indeksAktif = indeks);
  }

  void _bukaMenuPendukung(String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  void _keluar() {
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return NavigationDrawer(
      selectedIndex: _indeksAktif,
      onDestinationSelected: (i) {
        Navigator.pop(context);
        _pindahTujuan(i);
      },
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            children: [
              Icon(Icons.location_city, color: Colors.teal),
              SizedBox(width: 12),
              Text('Nusantara Cerdas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.grid_view_outlined),
          selectedIcon: Icon(Icons.grid_view),
          label: Text('Layanan'),
        ),
        const NavigationDrawerDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: Text('Warga'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings_outlined),
          title: const Text('Pengaturan Kota'),
          onTap: () => _bukaMenuPendukung(AppRoutes.pengaturanKota),
        ),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Tentang Aplikasi'),
          onTap: () => _bukaMenuPendukung(AppRoutes.tentangAplikasi),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Keluar'),
          onTap: _keluar,
        ),
      ],
    );
  }

  /// HANYA menerima parameter `total`.
  /// TIDAK memanggil context.select di sini.
  Widget _ikonWarga(IconData icon, int total) {
    if (total == 0) return Icon(icon);
    return Badge(
      label: Text('$total'),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ context.select dipanggil di sini, di dalam build()
    final total = context.select<PengajuanModel, int>(
      (m) => m.totalPengajuan,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final layarLebar = constraints.maxWidth >= 600;
        final konten = _halaman[_indeksAktif];

        if (layarLebar) {
          return Scaffold(
            key: KerangkaNavigasi.scaffoldKey,
            drawer: _buildDrawer(),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _indeksAktif,
                  onDestinationSelected: _pindahTujuan,
                  labelType: NavigationRailLabelType.all,
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    tooltip: 'Menu',
                    onPressed: () => KerangkaNavigasi
                        .scaffoldKey.currentState
                        ?.openDrawer(),
                  ),
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.grid_view_outlined),
                      selectedIcon: Icon(Icons.grid_view),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: _ikonWarga(Icons.person_outline, total),
                      selectedIcon: _ikonWarga(Icons.person, total),
                      label: const Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: konten),
              ],
            ),
          );
        }

        return Scaffold(
          key: KerangkaNavigasi.scaffoldKey,
          drawer: _buildDrawer(),
          body: konten,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _indeksAktif,
            onDestinationSelected: _pindahTujuan,
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              const NavigationDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view),
                label: 'Layanan',
              ),
              NavigationDestination(
                icon: _ikonWarga(Icons.person_outline, total),
                selectedIcon: _ikonWarga(Icons.person, total),
                label: 'Warga',
              ),
            ],
          ),
        );
      },
    );
  }
}