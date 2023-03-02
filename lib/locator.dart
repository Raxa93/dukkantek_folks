
import 'package:dukkantek_folks/presentation/pages/register/register_vm.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/api_repo/api_repo_imp.dart';
import 'data/repositories/auth_repo/auth_repo.dart';
import 'data/repositories/auth_repo/auth_repo_imp.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {


// Repos
  locator.registerSingleton<AuthRepo>(AuthRepoImp());
  locator.registerSingleton<ApiRepoImp>(ApiRepoImp());

// ViewModels
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
}