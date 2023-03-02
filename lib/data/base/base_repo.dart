

import '../datasources/remote/api_service.dart';
import '../datasources/remote/auth_service.dart';

abstract class BaseRepo{


  AuthService authService = AuthService();
  ApiService apiService = ApiService();

}