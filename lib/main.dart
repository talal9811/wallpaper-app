import 'package:flutter/material.dart';
import 'package:josequal/router/router.dart';
import 'package:provider/provider.dart';

import 'provider/favorite_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AppRouter>(create: (_) => AppRouter()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: Consumer2<AppRouter, FavoriteProvider>(
          builder: (contx, router, fav, _) {
        return Builder(
          builder: (context) {
            return MaterialApp.router(
              theme: ThemeData.dark(
                useMaterial3: true,
              ),
              title: "App",
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              routeInformationParser: AppRouter.router.routeInformationParser,
              routerDelegate: AppRouter.router.routerDelegate,
            );
          },
        );
      }),
    );
  }
}
