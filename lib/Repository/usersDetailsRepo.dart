import 'package:dio/dio.dart';
import '../Configs/endpoints.dart';
import '../Model/usersDetailsModel.dart';

class UsersDetailsRepo {
  Dio? dio;

  UsersDetailsRepo({this.dio});

  Future<caseUsersDetails> getUsersDetails(userId) async {
    final url = Endpoints.employeesDetailsApiEndpoint + userId.toString();
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
          return caseUsersDetails.fromJson(singleUserJson);
        } else {
          // If the status is not 'success', throw an exception
          throw Exception('An error occurred fetching data');
        }
      } else {
        // If the response status code is not 200, throw an exception
        throw Exception('Failed to fetch user details');
      }
    } catch (e) {
      // Catching any errors that occur
      throw Exception('Failed to connect to the server');
    }
  }
}
