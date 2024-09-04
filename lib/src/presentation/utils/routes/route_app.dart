import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/model/building_model.dart';
import '../../../data/model/extracurricular_model.dart';
import '../../../data/model/user_model.dart';
import '../../pages/authentication/login.dart';
import '../../pages/botnavbar/botnavbar.dart';
import '../../pages/building/add_building.dart';
import '../../pages/building/page_building.dart';
import '../../pages/building/detail_building.dart';
import '../../pages/building/edit_building.dart';
import '../../pages/extracurricular/add_extracurricular.dart';
import '../../pages/extracurricular/detail_extracurricular.dart';
import '../../pages/extracurricular/edit_extracurricular.dart';
import '../../pages/history/history.dart';
import '../../pages/home/home.dart';
import '../../pages/profile/page_add_user.dart';
import '../../pages/profile/page_edit_user.dart';
import '../../pages/profile/page_profile.dart';
import '../../pages/report/report.dart';
import '../../pages/reservation/confirm_reservation.dart';
import '../../pages/reservation/reservation.dart';
import '../../pages/splash/splash.dart';
import 'route_name.dart';

//User
final _navigatorHome = GlobalKey<NavigatorState>();
final _navigatorBuilding = GlobalKey<NavigatorState>();
final _navigatorReservation = GlobalKey<NavigatorState>();
final _navigatorHistory = GlobalKey<NavigatorState>();
final _navigatorProfile = GlobalKey<NavigatorState>();

//Admin
final _navigatorHomeAdmin = GlobalKey<NavigatorState>();
final _navigatorBuildingAdmin = GlobalKey<NavigatorState>();
final _navigatorReportAdmin = GlobalKey<NavigatorState>();
final _navigatorProfileAdmin = GlobalKey<NavigatorState>();

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

    ///Navigation bottom bar for User
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
          navigatorKey: _navigatorBuilding,
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
                ),
                GoRoute(
                  path: 'detailExtracurricular',
                  name: Routes().detailExtracurricular,
                  builder: (context, state) {
                    return DetailExtracurricularPage(
                      extracurricular: state.extra as ExtracurricularModel,
                    );
                  },
                ),
              ],
            ),
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
                    // onExit: (context, state) {
                    //   BlocProvider.of<ReservationBuildingBloc>(context)
                    //       .add(InitialBuildingAvail());
                    //   return true;
                    // },
                    builder: (context, state) {
                      return ConfirmReservationPage(
                        building: state.extra as BuildingModel,
                        dateStart:
                            state.uri.queryParameters["dateStart"] as String,
                        dateEnd: state.uri.queryParameters["dateEnd"] as String,
                      );
                    },
                  )
                ]),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorHistory,
          routes: <RouteBase>[
            GoRoute(
              path: '/history',
              name: Routes().history,
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

    ///Navigation bottom bar for Admin
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BotNavBar(
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _navigatorHomeAdmin,
          routes: <RouteBase>[
            GoRoute(
              path: '/homeAdmin',
              name: Routes().homeAdmin,
              builder: (context, state) {
                return const HomePage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorBuildingAdmin,
          routes: <RouteBase>[
            GoRoute(
              path: '/buildingAdmin',
              name: Routes().buildingAdmin,
              builder: (context, state) {
                return const BuildingPage();
              },
              routes: [
                GoRoute(
                  path: 'detailBuildingAdmin',
                  name: Routes().detailBuildingAdmin,
                  builder: (context, state) {
                    return DetailBuilding(
                      building: state.extra as BuildingModel,
                    );
                  },
                ),
                GoRoute(
                  path: 'createBuilding',
                  name: Routes().createBuilding,
                  builder: (context, state) {
                    return const AddBuildingPage();
                  },
                  routes: [
                    GoRoute(
                      path: 'editBuilding',
                      name: Routes().editBuilding,
                      builder: (context, state) {
                        return EditBuildingPage(
                          building: state.extra as BuildingModel,
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: 'createExtracurricular',
                  name: Routes().createExtracurricular,
                  builder: (context, state) {
                    return const AddExtracurricularPage();
                  },
                  routes: [
                    GoRoute(
                      path: 'editExtracurricular',
                      name: Routes().editExtracurricular,
                      builder: (context, state) {
                        return EditExtracurricularPage(
                          exschool: state.extra as ExtracurricularModel,
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorReportAdmin,
          routes: <RouteBase>[
            GoRoute(
              path: '/reportAdmin',
              name: Routes().reportAdmin,
              builder: (context, state) {
                return const ReportPage();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _navigatorProfileAdmin,
          routes: <RouteBase>[
            GoRoute(
              path: '/profileAdmin',
              name: Routes().profileAdmin,
              builder: (context, state) {
                return const ProfilePage();
              },
              routes: [
                GoRoute(
                  path: 'addUser',
                  name: Routes().addUser,
                  builder: (context, state) {
                    return AddUserPage(
                      userModel: state.extra as UserModel,
                    );
                  },
                ),
                GoRoute(
                  path: 'editUser',
                  name: Routes().editUser,
                  builder: (context, state) {
                    return EditUserPage(
                      userModel: state.extra as UserModel,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    )
  ],
);

// GoRouter routeApp(String role) {
//   return GoRouter(
//     routes: <RouteBase>[
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const SplashScreen(),
//       ),
//       GoRoute(
//         path: '/login',
//         name: Routes().login,
//         builder: (context, state) => const LoginPage(),
//       ),
//
//       ///navigation with parent widget
//       (role == "1")
//           ? StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
//           return BotNavBar(
//             navigationShell: navigationShell,
//           );
//         },
//         branches: <StatefulShellBranch>[
//           StatefulShellBranch(
//             navigatorKey: _navigatorHome,
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/home',
//                 name: Routes().home,
//                 builder: (context, state) {
//                   return const HomePage();
//                 },
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _navigatorRoom,
//             routes: <RouteBase>[
//               GoRoute(
//                   path: '/building',
//                   name: Routes().building,
//                   builder: (context, state) {
//                     return const BuildingPage();
//                   },
//                   routes: [
//                     GoRoute(
//                       path: 'detailBuilding',
//                       name: Routes().detailBuilding,
//                       builder: (context, state) {
//                         return DetailBuilding(
//                           building: state.extra as BuildingModel,
//                         );
//                       },
//                     )
//                   ]),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _navigatorReport,
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/report',
//                 name: Routes().report,
//                 builder: (context, state) {
//                   return const ReportPage();
//                 },
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _navigatorProfile,
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/profile',
//                 name: Routes().profile,
//                 builder: (context, state) {
//                   return const ProfilePage();
//                 },
//               ),
//             ],
//           ),
//         ],
//       )
//           : StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
//           return BotNavBar(
//             navigationShell: navigationShell,
//           );
//         },
//         branches: <StatefulShellBranch>[
//           StatefulShellBranch(
//             navigatorKey: _navigatorHome,
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/home',
//                 name: Routes().home,
//                 builder: (context, state) {
//                   return const HomePage();
//                 },
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _navigatorRoom,
//             routes: <RouteBase>[
//               GoRoute(
//                   path: '/building',
//                   name: Routes().building,
//                   builder: (context, state) {
//                     return const BuildingPage();
//                   },
//                   routes: [
//                     GoRoute(
//                       path: 'detailBuilding',
//                       name: Routes().detailBuilding,
//                       builder: (context, state) {
//                         return DetailBuilding(
//                           building: state.extra as BuildingModel,
//                         );
//                       },
//                     )
//                   ]),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _navigatorReservation,
//             routes: <RouteBase>[
//               GoRoute(
//                   path: '/reservation',
//                   name: Routes().reservation,
//                   builder: (context, state) {
//                     return const ReservationPage();
//                   },
//                   routes: [
//                     GoRoute(
//                       path: 'confirmReservation',
//                       name: Routes().confirmReservation,
//                       onExit: (context, state) {
//                         BlocProvider.of<ReservationBuildingBloc>(context)
//                             .add(InitialBuildingAvail());
//                         return true;
//                       },
//                       builder: (context, state) {
//                         return ConfirmReservationPage(
//                           building: state.extra as BuildingModel,
//                           dateStart: state
//                               .uri.queryParameters["dateStart"] as String,
//                           dateEnd: state.uri.queryParameters["dateEnd"]
//                           as String,
//                         );
//                       },
//                     )
//                   ]),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _navigatorReport,
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/history',
//                 name: Routes().history,
//                 builder: (context, state) {
//                   return const HistoryPage();
//                 },
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             navigatorKey: _navigatorProfile,
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/profile',
//                 name: Routes().profile,
//                 builder: (context, state) {
//                   return const ProfilePage();
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     ],
//   );
// }
