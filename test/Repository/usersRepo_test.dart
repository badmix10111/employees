// Import required packages and files
import 'package:employees/Repository/usersRepo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:employees/Model/listOfUsersModel.dart';

void main() {
  group('UsersRepo', () {
    late UsersRepo usersRepo;
    late Dio dio;

    setUp(() {
      dio = Dio();
      usersRepo = UsersRepo();
    });

    // Mock a successful API response
    void mockOnRequestSuccess(Response successfulResponse) {
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

    test('UsersRepo - fetch users successfully', () async {
      // Create a successful response object
      final successfulResponse = Response(
        requestOptions: RequestOptions(path: 'dummy'),
        statusCode: 200,
        data: {
          'status': 'success',
          'data': [
            {
              "id": 1,
              "employee_name": "Tiger Nixon",
              "employee_salary": 320800,
              "employee_age": 61,
              "profile_image": ""
            },
          ],
        },
      );

      mockOnRequestSuccess(successfulResponse);

      // Call the getUsers method and await the result
      final result = await usersRepo.getUsers();

      // Perform assertions on the result
      expect(result, isA<ListOfUsers>());
      expect(result.data!.isNotEmpty, true);
      expect(result.data![0].employeeName, 'Tiger Nixon');
      expect(result.data![0].employeeSalary, 320800);
      expect(result.data![0].employeeAge, 61);
      expect(result.data![0].profileImage, '');
    });

    test('UsersRepo - throw exception when server connection fails', () {
      // Create an error object for failed server connection
      final error = DioError(
        error: 'Failed to connect',
        requestOptions: RequestOptions(path: 'dummy'),
      );

      mockOnRequestError(error);

      // Expect that calling getUsers throws an exception
      expect(
        () => usersRepo.getUsers(),
        throwsException,
      );
    });

    test(
        'UsersRepo - throw exception when server returns unsuccessful response',
        () async {
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

      // Expect that calling getUsers throws an exception
      expect(
        () async => await usersRepo.getUsers(),
        throwsA(isA<Exception>()),
      );
    });
  });
}
