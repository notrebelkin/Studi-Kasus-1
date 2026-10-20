import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/favorit_bloc.dart';
import 'bloc/pengajuan_bloc.dart';
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
      ],
      child: MaterialApp(
        title: 'Nusantara Cerdas',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.teal,
        ),
        initialRoute: AppRoutes.beranda,
        routes: AppRoutes.daftarRoute(),
        onGenerateRoute: AppRoutes.bentukRoute,
        onUnknownRoute: AppRoutes.routeTidakDikenal,
      ),
    );
  }
}