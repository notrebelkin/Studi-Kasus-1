import 'package:flutter/material.dart';
import '../pages/beranda_page.dart';
import '../pages/layanan_page.dart';
import '../pages/warga_page.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

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

  void _pindahTujuan(int indeks) {
    setState(() => _indeksAktif = indeks);
  }

  void _bukaMenuPendukung(String route) {
    Navigator.pop(context); // tutup drawer dulu
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
          padding: EdgeInsets.all(16),
          child: Text('Nusantara Cerdas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          leading: const Icon(Icons.settings),
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layarLebar = constraints.maxWidth >= 600;

        final konten = _halaman[_indeksAktif];

        if (layarLebar) {
          // Layout lebar: NavigationRail di kiri
          return Scaffold(
            drawer: _buildDrawer(),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _indeksAktif,
                  onDestinationSelected: _pindahTujuan,
                  labelType: NavigationRailLabelType.all,
                  leading: IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.grid_view_outlined),
                      selectedIcon: Icon(Icons.grid_view),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person_outline),
                      selectedIcon: Icon(Icons.person),
                      label: Text('Warga'),
                    ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: konten),
              ],
            ),
          );
        }

        // Layout sempit: NavigationBar di bawah
        return Scaffold(
          drawer: _buildDrawer(),
          body: konten,
          bottomNavigationBar: NavigationBar(
            selectedIndex: _indeksAktif,
            onDestinationSelected: _pindahTujuan,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.grid_view_outlined),
                selectedIcon: Icon(Icons.grid_view),
                label: 'Layanan',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Warga',
              ),
            ],
          ),
        );
      },
    );
  }
}