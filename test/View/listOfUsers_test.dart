import 'package:employees/Helper/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:employees/main.dart';
import 'package:employees/Model/listOfUsersModel.dart';
import 'package:employees/Repository/usersRepo.dart';

// Create a mock implementation of the UsersRepo
class MockUsersRepository extends UsersRepo {
  @override
  Future<ListOfUsers> getUsers() async {
    // Return mock data instead of making an API call
    return ListOfUsers.fromJson({
      "status": "success",
      "data": [
        {
          "id": 1,
          "employee_name": "Tiger Nixon",
          "employee_salary": 320800,
          "employee_age": 61,
          "profile_image": ""
        },
        // Add more mock data if needed
      ],
      "message": "Successfully! All records have been fetched."
    });
  }
}

void main() {
  testWidgets('MyHomePage displays user list', (WidgetTester tester) async {
    // Inject the mock UsersRepo into the dependency injection container
    getIt.registerSingleton<UsersRepo>(MockUsersRepository());

    // Build the MyHomePage widget
    await tester.pumpWidget(MyApp());

    // Wait for the FutureBuilder to complete and rebuild the widget
    await tester.pumpAndSettle();

    // Verify that the user list is displayed
    expect(find.byType(ListTile),
        findsNWidgets(1)); // Adjust the count based on the number of users

    // Verify that the user names are displayed correctly
    expect(find.text('Name: Tiger Nixon'),
        findsOneWidget); // Adjust the name based on the mock data

    // Add more verification if needed

    // Clean up the dependency injection container
    getIt.unregister<UsersRepo>();
  });
}
