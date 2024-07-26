
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reservation_app/src/data/model/building_model.dart';
import 'package:reservation_app/src/presentation/pages/confirm_reservation/confirm_reservation.dart';
import 'package:reservation_app/src/presentation/utils/routes/route_name.dart';

import '../../pages/botnavbar/botnavbar.dart';
import '../../pages/building/building.dart';
import '../../pages/detail_building/detail_building.dart';
import '../../pages/history/history.dart';
import '../../pages/home/home.dart';
import '../../pages/login/login.dart';
import '../../pages/profile/profile.dart';
import '../../pages/reservation/reservation.dart';
import '../../pages/splash/splash.dart';

final _navigatorHome = GlobalKey<NavigatorState>();
final _navigatorRoom = GlobalKey<NavigatorState>();
final _navigatorReservation = GlobalKey<NavigatorState>();
final _navigatorReport = GlobalKey<NavigatorState>();
final _navigatorProfile = GlobalKey<NavigatorState>();

final GoRouter routeApp = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: Routes().login,
      builder: (context, state) => const LoginPage(),
    ),

    ///navigation with parent widget
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BotNavBar(
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _navigatorHome,
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              name: Routes().home,
              builder: (context, state) {
                return const HomePage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorRoom,
          routes: <RouteBase>[
            GoRoute(
                path: '/building',
                name: Routes().building,
                builder: (context, state) {
                  return const BuildingPage();
                },
                routes: [
                  GoRoute(
                    path: 'detailBuilding',
                    name: Routes().detailBuilding,
                    builder: (context, state) {
                      return DetailBuilding(
                        building: state.extra as BuildingModel,
                      );
                    },
                  )
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorReservation,
          routes: <RouteBase>[
            GoRoute(
                path: '/reservation',
                name: Routes().reservation,
                builder: (context, state) {
                  return const ReservationPage();
                },
                routes: [
                  GoRoute(
                    path: 'confirmReservation',
                    name: Routes().confirmReservation,
                    builder: (context, state) {
                      return const ConfirmReservationPage();
                    },
                  )
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorReport,
          routes: <RouteBase>[
            GoRoute(
              path: '/report',
              name: Routes().report,
              builder: (context, state) {
                return const HistoryPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorProfile,
          routes: <RouteBase>[
            GoRoute(
              path: '/profile',
              name: Routes().profile,
              builder: (context, state) {
                return const ProfilePage();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
