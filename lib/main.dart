import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/favorit_model.dart';
import 'models/pengajuan_model.dart';
import 'models/chat_model.dart';
import 'navigation/app_routes.dart';

void main() => runApp(const NusantaraCerdasApp());

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoritModel()),
        ChangeNotifierProvider(create: (_) => PengajuanModel()),
        ChangeNotifierProvider(create: (_) => ChatModel()),
      ],
      child: MaterialApp(
        title: 'Nusantara Cerdas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    );
  }
}