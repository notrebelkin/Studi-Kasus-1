import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favorit_bloc.dart';
import 'bloc/pengajuan_bloc.dart';
import 'bloc/theme_bloc.dart';
import 'navigation/app_routes.dart';

void main() => runApp(const NusantaraCerdasApp());

class NusantaraCerdasApp extends StatelessWidget {
  const NusantaraCerdasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FavoritBloc()),
        BlocProvider(create: (_) => PengajuanBloc()),
        BlocProvider(create: (_) => ThemeBloc()), // Tambahan Modul VI
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Nusantara Cerdas',
            debugShowCheckedModeBanner: false,
            
            // Tema Terang
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: Brightness.light,
              ),
            ),
            
            // Tema Gelap
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
                brightness: Brightness.dark,
              ),
            ),
            
            themeMode: themeMode, // Terapkan mode tema
            
            initialRoute: AppRoutes.beranda,
            routes: AppRoutes.daftarRoute(),
            onGenerateRoute: AppRoutes.bentukRoute,
            onUnknownRoute: AppRoutes.routeTidakDikenal,
          );
        },
      ),
    );
  }
}