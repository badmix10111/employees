import 'package:dio/dio.dart';
import 'package:employees/Configs/endpoints.dart';
import 'package:employees/Model/listOfUsersModel.dart';

class UsersRepo {
  Future<ListOfUsers> getUsers() async {
    final url = Endpoints.employeesApiEndpoint;
    try {
      final response = await Dio().get(url);

      if (response.statusCode == 200) {
        // If the response status code is 200 (OK)
        final singleUserJson = response.data;
        String checkstatus = singleUserJson['status'];
        // Checking if the status in the response is 'success'
        bool checkIfSuccess = checkstatus.contains('success');
        if (checkIfSuccess == true) {
          // If the status is 'success', parse the JSON data and return it

          return ListOfUsers.fromJson(singleUserJson);
        } else {
          // If the status is not 'success', throw an exception

          throw Exception('An error occured fetching data');
        }
      } else {
        // If the response status code is not 200, throw an exception

        throw Exception('Failed to fetch user details');
      }
    } catch (e) {
      // Catching any errors that occur during the API request

      throw Exception('Failed to connect to the server');
    }
  }
}
