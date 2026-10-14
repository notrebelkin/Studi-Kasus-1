import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LokasiKantorPage extends StatefulWidget {
  const LokasiKantorPage({super.key});

  @override
  State<LokasiKantorPage> createState() => _LokasiKantorPageState();
}

class _LokasiKantorPageState extends State<LokasiKantorPage> {
  static const _kantor = [
    {
      'nama': 'Balai Kota Nusantara',
      'pos': LatLng(-6.200000, 106.816666),
    },
    {
      'nama': 'Kantor Dinas Kesehatan',
      'pos': LatLng(-6.210000, 106.820000),
    },
    {
      'nama': 'Kantor Dinas Perhubungan',
      'pos': LatLng(-6.190000, 106.830000),
    },
  ];

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    for (final k in _kantor) {
      _markers.add(Marker(
        markerId: MarkerId(k['nama'] as String),
        position: k['pos'] as LatLng,
        infoWindow: InfoWindow(title: k['nama'] as String),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lokasi Kantor')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _kantor.first['pos'] as LatLng,
          zoom: 14,
        ),
        markers: _markers,
      ),
    );
  }
}