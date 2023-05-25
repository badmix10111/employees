// // import 'package:employees/View/failedPage.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:restart_app/restart_app.dart';
// // // import 'package:flutter_phoenix/flutter_phoenix.dart';

// // void main() {
// //   testWidgets('SomethingWentWrongScreen test', (WidgetTester tester) async {
// //     await tester.pumpWidget(
// //       MaterialApp(
// //         home: SomethingWentWrongScreen(),
// //       ),
// //     );

// //     expect(find.text('Refresh'), findsOneWidget);
// //     expect(find.byType(Image), findsOneWidget);

// //     await tester.tap(find.text('Refresh'));
// //     await tester.pump();

// //     // You can add additional assertions or verifications here
// //     // based on the expected behavior after tapping the refresh button.
// //     // For example, you could verify that the app is restarted or a certain
// //     // action is performed.

// //     // Uncomment the following lines if you want to verify the usage
// //     // of specific libraries or methods.

// //     // expect(Restart.restartAppCalled, true);
// //     // expect(Phoenix.rebirthCalled, true);
// //     // expect(MyApp.calledWithNull, true);
// //     // expect(MyApp.calledWithOpenPassedValue, true);
// //   });
// // }
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   // Your test cases go here
//   test('Test case 1', () {
//     // Test assertions
//   });

//   testWidgets('Test case 2', (WidgetTester tester) async {
//     // Widget test code
//   });
// }
import 'package:employees/View/failedPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restart_app/restart_app.dart';

void main() {
  testWidgets('SomethingWentWrongScreen test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SomethingWentWrongScreen(),
      ),
    );

    // Verify the presence of the 'Refresh' button
    expect(find.text('Refresh'), findsOneWidget);

    // Verify the presence of the background image
    expect(find.byType(Image), findsOneWidget);

    // Verify the button onPressed action
    await tester.tap(find.text('Refresh'));
    await tester.pumpAndSettle();
  });
}
