import 'package:employees/Repository/usersDetailsRepo.dart';
import 'package:employees/Repository/usersRepo.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  // Register the singleton instance of UsersRepo
  GetIt.I.registerSingleton<UsersRepo>(UsersRepo());

  // Register the lazy singleton instance of UsersDetailsRepo
  // Lazy singleton means the instance will be created when it's first accessed
  GetIt.I.registerLazySingleton<UsersDetailsRepo>(() => UsersDetailsRepo());
}
