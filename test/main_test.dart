// // // import 'package:employees/Model/listOfUsersModel.dart';
// // // import 'package:employees/View/UsersDetails.dart';
// // // import 'package:employees/View/listOfUsers.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_test/flutter_test.dart';
// // // import 'package:employees/main.dart';

// // // void main() {
// // //   testWidgets('MyApp displays the main page', (WidgetTester tester) async {
// // //     // Pump MyApp widget into the test environment
// // //     await tester.pumpWidget(MyApp());

// // //     // Verify that the main page is displayed
// // //     expect(find.text('Employees'), findsOneWidget);
// // //     expect(find.byType(MyHomePage), findsOneWidget);
// // //   });
// // //   testWidgets('MyApp navigates to the detail page when the button is tapped',
// // //       (WidgetTester tester) async {
// // //     // Build MyApp
// // //     await tester.pumpWidget(MyApp());

// // //     // Find the button
// // //     final buttonFinder = find.byKey(const ValueKey('detail_button'));

// // //     // Tap the button
// // //     await tester.tap(buttonFinder);
// // //     await tester.pump();

// // //     // Verify navigation
// // //     expect(find.text('DetailPage'), findsOneWidget);
// // //   });
// // //   // testWidgets('MyApp navigates to detail page', (WidgetTester tester) async {
// // //   //   // Pump MyApp widget into the test environment
// // //   //   await tester.pumpWidget(MyApp());

// // //   //   // Wait for the navigation to complete
// // //   //   await tester.pumpAndSettle();

// // //   //   // Tap on a user card to navigate to the detail page
// // //   //   await tester.tap(find.byType(ListOfUsers));
// // //   //   await tester.pumpAndSettle();

// // //   //   // Verify that the detail page is displayed
// // //   //   expect(find.byType(DetailScreen), findsOneWidget);
// // //   // });
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:employees/main.dart';

// // void main() {
// //   testWidgets('Main App Test', (WidgetTester tester) async {
// //     await tester.pumpWidget(MyApp());

// //     // Verify the initial route is '/'
// //     expect(find.text('Employees'), findsOneWidget);

// //     // Tap on a user card
// //     await tester.tap(find.byType(ListTile).first);
// //     await tester.pumpAndSettle();

// //     // Verify the detail screen is pushed
// //     expect(find.text('User Details'), findsOneWidget);

// //     // Go back to the main screen
// //     await tester.tap(find.byIcon(Icons.arrow_back));
// //     await tester.pumpAndSettle();

// //     // Verify the main screen is displayed again
// //     expect(find.text('Employees'), findsOneWidget);
// //   });
// // }
// import 'package:employees/View/UsersDetails.dart';
// import 'package:employees/View/listOfUsers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:employees/main.dart';
// import 'package:go_router/go_router.dart';

// void main() {
//   testWidgets('App initializes and renders MyHomePage',
//       (WidgetTester tester) async {
//     // Build the app
//     await tester.pumpWidget(MyApp());

//     // Verify that the MyHomePage widget is rendered
//     expect(find.text('Employees'), findsOneWidget);
//   });
//   testWidgets('App has correct title', (WidgetTester tester) async {
//     await tester.pumpWidget(MyApp());

//     // Verify that the app title is set correctly
//     expect(find.text('Employees'), findsOneWidget);
//   });
//   testWidgets('Navigate to detail screen', (WidgetTester tester) async {
//     late GoRouter goRouter; // Declare goRouter as a local variable

//     await tester.pumpWidget(
//       Builder(
//         builder: (context) {
//           goRouter = GoRouter(
//             routes: [
//               GoRoute(
//                 path: '/',
//                 pageBuilder: (context, state) =>
//                     const MaterialPage(child: MyHomePage(title: 'Employees')),
//               ),
//               GoRoute(
//                 path: '/detail/:userId',
//                 pageBuilder: (context, state) {
//                   final userId = state.params['userId'];
//                   return MaterialPage(child: DetailScreen(userId!));
//                 },
//               ),
//             ],
//           );
//           return MaterialApp.router(
//             debugShowCheckedModeBanner: false,
//             title: 'Employees',
//             routerDelegate: goRouter.routerDelegate,
//             routeInformationParser: goRouter.routeInformationParser,
//           );
//         },
//       ),
//     );

//     // Navigate to the detail screen
//     goRouter.go('/detail/123');
//     await tester.pumpAndSettle();

//     // Verify that the DetailScreen widget is rendered
//     expect(find.byType(DetailScreen), findsOneWidget);

//     // Verify that the correct user ID is passed to the DetailScreen
//     expect(find.text('User ID: 123'), findsOneWidget);
//   });
// }
import 'package:employees/Model/listOfUsersModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employees/main.dart';
import 'package:employees/View/UsersDetails.dart';
import 'package:employees/View/listOfUsers.dart';

void main() {
  testWidgets('App initializes and renders MyHomePage',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(MyApp());

    // Verify that the MyHomePage widget is rendered
    expect(find.text('Employees'), findsOneWidget);
  });

  testWidgets('App has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Verify that the app title is set correctly
    expect(find.text('Employees'), findsOneWidget);
  });

  testWidgets('MyHomePage displays loading indicator when fetching users',
      (WidgetTester tester) async {
    // Create a mock implementation of fetching users that takes some time
    bool fetchingUsers = true;
    Future<List<String>> fetchUsers() async {
      await Future.delayed(Duration(seconds: 2)); // Simulate loading delay
      fetchingUsers = false;
      return []; // Return an empty list for simplicity
    }

    // Build the app
    final myApp = MyApp();
    await tester.pumpWidget(myApp);

    // Verify that the loading indicator is displayed initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the fetching to complete
    await tester.pumpAndSettle();

    // Verify that the loading indicator is no longer displayed
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
  // testWidgets('Tapping on user card navigates to detail screen',
  //     (WidgetTester tester) async {
  //   await tester.pumpWidget(MyApp());

  //   // Tap on a user card
  //   await tester.tap(find.byType(ListTile).first);
  //   await tester.pumpAndSettle();

  //   // Verify that the detail screen is pushed
  //   expect(find.text('User Details'), findsOneWidget);

  //   // Go back to the main screen
  //   await tester.tap(find.byIcon(Icons.arrow_back));
  //   await tester.pumpAndSettle();

  //   // Verify that the main screen is displayed again
  //   expect(find.text('Employees'), findsOneWidget);
  // });

