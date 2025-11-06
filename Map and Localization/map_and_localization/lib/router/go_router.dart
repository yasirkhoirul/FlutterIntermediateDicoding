import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:map_and_localization/screen/first_home.dart';
import 'package:map_and_localization/screen/home.dart';
import 'package:map_and_localization/screen/maps.dart';

final globalkeynav = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: '/', //lokasi awal
  navigatorKey: globalkeynav,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return FirstHome(navigationShell: navigationShell);
      },

      branches: [
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellHome'),
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) {
                return const Home();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shellmap'),
          routes: [
            GoRoute(
              builder: (context, state) {
                return const Maps();
              },
              path: '/maps',
            ),
          ],
        ),
      ],
    ),
  ],
);
