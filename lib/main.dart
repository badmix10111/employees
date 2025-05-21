import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';
import 'package:go_router/go_router.dart';

import 'package:employees/Helper/locator.dart';
import 'package:employees/Repository/usersDetailsRepo.dart';
import 'package:employees/View/listOfUsers.dart';
import 'package:employees/View/usersDetails.dart';
import 'package:employees/View/failedPage.dart';

void main() async {
  // 1) Initialize Flutter bindings in this zone
  WidgetsFlutterBinding.ensureInitialized();

  // 2) If any uncaught Flutter error happens, restart the app
  FlutterError.onError = (details) {
    Restart.restartApp();
  };

  // 3) Set up dependency injection (get_it)
  setup();

  // 4) Lock orientation (flutter/services)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 5) Finally run the app
  runApp(MyApp());
}

class AppRoutes {
  static const employees = '/employees';
  static const detail = '/detail/:userId';
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late final GoRouter _router = GoRouter(
    initialLocation: AppRoutes.employees,
    // On bad route or build error, show our fallback screen
    errorBuilder: (_, __) => const SomethingWentWrongScreen(),
    routes: [
      GoRoute(
        path: AppRoutes.employees,
        builder: (_, __) => const ListOfUsersPage(),
      ),
      GoRoute(
        path: AppRoutes.detail,
        builder: (ctx, state) {
          final userId = state.pathParameters['userId']!;
          return DetailScreen(
            userId: userId,
            usersDetailsRepo: UsersDetailsRepo(),
          );
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Employee Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
