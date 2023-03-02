

import 'package:flutter/material.dart';

import '../../base/base_repo.dart';

abstract class AuthRepo extends BaseRepo{

  Future<String?> signInWithEmailAndPassword(String email,String password,BuildContext context);
  Future<String?> registerUser(String email,String password);
  Future<String?> signInWithGoogle(BuildContext context);
  Future sendVerifyEmail();
  Future checkEmailIsVerified();
  Future resetPassword(String email);


}