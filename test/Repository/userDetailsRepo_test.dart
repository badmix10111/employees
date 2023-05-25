// Import required packages and files
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employees/Model/usersDetailsModel.dart';
import 'package:employees/Repository/usersDetailsRepo.dart';

void main() {
  group('UsersDetailsRepo', () {
    late UsersDetailsRepo usersRepo;
    late Dio dio;

    setUp(() {
      dio = Dio();
      usersRepo = UsersDetailsRepo(dio: dio);
    });

    // Mock a successful API response
    void mockOnRequestSuccess(Response<dynamic> successfulResponse) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            handler.resolve(successfulResponse);
          },
        ),
      );
    }

    // Mock an API error
    void mockOnRequestError(DioError error) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            throw error;
          },
        ),
      );
    }

    test('UsersDetailsRepo - fetch users details successfully', () {
      // Create a successful response object
      final successfulResponse = Response(
        requestOptions: RequestOptions(path: 'dummy'),
        statusCode: 200,
        data: {
          'status': 'success',
          'data': {
            "id": 1,
            "employee_name": "Tiger Nixon",
            "employee_salary": 320800,
            "employee_age": 61,
            "profile_image": ""
          },
        },
      );

      mockOnRequestSuccess(successfulResponse);

      // Expect that the future returned by getUsersDetails completes with a caseUsersDetails object
      expectLater(
          usersRepo.getUsersDetails(1), completion(isA<caseUsersDetails>()));
    });

    test('UsersDetailsRepo - throw exception when server connection fails', () {
      // Create an error object for failed server connection
      final error = DioError(
        error: 'Failed to connect',
        requestOptions: RequestOptions(path: 'dummy'),
      );

      mockOnRequestError(error);

      // Expect that the future returned by getUsersDetails throws an exception
      expectLater(usersRepo.getUsersDetails(1), throwsA(isA<Exception>()));
    });

    test(
        'UsersDetailsRepo - throw exception when server returns unsuccessful response',
        () {
      // Create an unsuccessful response object
      final unsuccessfulResponse = DioError(
        error: 'Failed to fetch user details',
        requestOptions: RequestOptions(path: 'dummy'),
        response: Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: 'dummy'),
        ),
      );

      mockOnRequestError(unsuccessfulResponse);

      // Expect that the future returned by getUsersDetails throws an exception
      expectLater(usersRepo.getUsersDetails(1), throwsA(isA<Exception>()));
    });
  });
}
