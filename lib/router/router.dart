import 'package:go_router/go_router.dart';
import 'package:josequal/api/models/wallpaper_model.dart';
import 'package:josequal/views/main/bottom_nav.dart';
import 'package:josequal/views/view_wallpaper.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BottomNavigation(),
      ),
      GoRoute(
        name: "view",
        path: '/view',
        builder: (context, state) =>
            WallpaperDetailsScreen(wallpaper: state.extra as WallpaperModel),
      ),
      // Define other routes here
    ],
  );
}
