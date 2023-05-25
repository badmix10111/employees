import 'package:employees/Helper/locator.dart';
import 'package:employees/View/UsersDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:employees/Model/usersDetailsModel.dart';
import 'package:employees/Repository/usersDetailsRepo.dart';

void main() {
  testWidgets('DetailScreen should populate data correctly',
      (WidgetTester tester) async {
    // Call setup function from your locator file
    setup();

    final userDetails = caseUsersDetails(
      data: Data(
        employeeAge: 61,
        employeeName: "Brielle Williamson",
        employeeSalary: 372000,
        profileImage: "",
      ),
    );

    // Unregister existing registration for UsersDetailsRepo
    GetIt.I.unregister<UsersDetailsRepo>();

    // Register a mock instance of UsersDetailsRepo for testing
    GetIt.I
        .registerSingleton<UsersDetailsRepo>(MockUsersDetailsRepo(userDetails));

    await tester.pumpWidget(
      MaterialApp(
        home: DetailScreen(
          userId: '6',
          usersDetailsRepo:
              GetIt.I.get<UsersDetailsRepo>(), // Use the registered instance
        ),
      ),
    );

    // Add print statements to check the execution flow
    print('Widget built successfully');
    await tester.pumpAndSettle();

    // Verify that the text widget displays the employee name
    expect(find.text("Brielle Williamson"), findsOneWidget);
    // Verify employee name

    // Verify age
    expect(find.text("61"), findsOneWidget);

    // Verify salary
    expect(find.text("R 372000"), findsOneWidget);

    // Verify no error message
    expect(find.text("try hitting refresh"), findsNothing);

    // Verify image
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('DetailScreen should show loading state',
      (WidgetTester tester) async {
    final userDetails = caseUsersDetails(
      data: Data(
        employeeAge: 30,
        employeeName: "John Doe",
        employeeSalary: 50000,
        profileImage: "profile.jpg",
      ),
    );

    // Register a mock instance of UsersDetailsRepo for testing

    await tester.pumpWidget(
      MaterialApp(
        home: DetailScreen(
          userId: '6',
          usersDetailsRepo: GetIt.I.get<UsersDetailsRepo>(),
        ),
      ),
    );

    // Verify that a loading indicator or message is displayed
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}

class MockUsersDetailsRepo extends UsersDetailsRepo {
  final caseUsersDetails? userDetails;
  final bool throwError;

  MockUsersDetailsRepo(this.userDetails, {this.throwError = false});

  @override
  Future<caseUsersDetails> getUsersDetails(userId) async {
    if (throwError) {
      throw Exception('An error occurred');
    }

    return userDetails ?? caseUsersDetails();
  }
}
