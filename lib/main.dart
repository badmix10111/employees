// Importing necessary packages and files
import 'package:employees/View/usersDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:employees/Helper/locator.dart';

import 'package:go_router/go_router.dart';

import 'Repository/usersDetailsRepo.dart';
import 'View/failedPage.dart';
import 'View/listOfUsers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  late GoRouter goRouter; // Declare goRouter as a global variable

  // Custom error widget for handling errors
  ErrorWidget.builder =
      (FlutterErrorDetails details) => SomethingWentWrongScreen();

  // Initializing dependencies
  setup();

  // Setting preferred device orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // Creating an instance of GoRouter
  final goRouter = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            const MaterialPage(child: MyHomePage(title: 'Employees')),
      ),
      GoRoute(
        path: '/detail/:userId',
        pageBuilder: (context, state) {
          final userId = state.params['userId'];

          // Creating a MaterialPage with the DetailScreen widget
          return MaterialPage(
            child: DetailScreen(
              userId: userId!,
              usersDetailsRepo:
                  UsersDetailsRepo(), // Provide the necessary UsersDetailsRepo instance
            ),
          );
        },
      ),
      // Other routes
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Employees',

      // Configuring the routerDelegate and routeInformationParser for MaterialApp
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
    );
  }
}
