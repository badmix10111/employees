// import 'package:employees/Helper/locator.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:employees/Repository/usersRepo.dart';
// import 'package:employees/Repository/usersDetailsRepo.dart';
// import 'package:get_it/get_it.dart';

// void main() {
//   test('setup() registers singletons correctly', () {
//     // Arrange
//     final getIt = GetIt.instance;

//     // Act
//     setup();

//     // Assert
//     expect(getIt.isRegistered<UsersRepo>(), isTrue);
//     expect(getIt.isRegistered<UsersDetailsRepo>(), isTrue);
//   });
// }
import 'package:employees/Helper/locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:employees/Repository/usersRepo.dart';
import 'package:employees/Repository/usersDetailsRepo.dart';
import 'package:get_it/get_it.dart';

void main() {
  test('setup() registers singletons correctly', () {
    // Arrange
    final getIt = GetIt.instance;

    // Act
    setup();

    // Assert
    expect(getIt.isRegistered<UsersRepo>(), isTrue);
    expect(getIt.isRegistered<UsersDetailsRepo>(), isTrue);
  });
}
