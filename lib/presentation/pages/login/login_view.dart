// ignore_for_file: use_build_context_synchronously

import 'package:dukkantek_folks/presentation/pages/brewery/brewery_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../../components/custom_text_field.dart';
import '../../configurations/size_config.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../register/register_view.dart';
import 'forget_password_view.dart';
import 'login_vm.dart';

class LoginView extends StatelessWidget {
  static const routeName = 'login_screen';

  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer<LoginViewModel>(
      builder: ((context, vm, child) {
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth! * 0.07),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: AppStyle.headline1,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.06),
                        CustomTextField(
                          controller: vm.emailController,
                          label: 'Email',
                          hint: 'Enter your email',
                          prefix: Icons.email,
                          validator: vm.emailValidator,
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.03),
                        CustomTextField(
                          controller: vm.passwordController,
                          label: 'Password',
                          hint: 'Enter your password',
                          prefix: Icons.lock,
                          isHidden: vm.isHidden,
                          validator: vm.passwordValidator,
                          suffix: IconButton(
                            icon: vm.isHidden
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              vm.setIsHidden = !vm.isHidden;
                            },
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.03),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: AppStyle.elevatedButtonStyle,
                                onPressed: () async =>
                                    _formKey.currentState!.validate()
                                        ? await vm.loginWithEmailAndPassword(context).then((value) {
                                              debugPrint('Value in view $value');
                                            if (value != null) {
                                              EasyLoading.dismiss();
                                               Navigator.of(context).pushReplacementNamed(BreweryMainView.routeName);
                                            }
                                          })
                                        : null,
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Log In'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.01),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: AppStyle.elevatedButtonStyle,
                                onPressed: () async {
                                  var success = await vm.loginWithGoogle(context: context);
                                  if(success != null){
                                    Navigator.of(context).pushReplacementNamed(BreweryMainView.routeName);
                                  }
                                },

                                //      await vm.loginWithGoogle(context: context).then((value) {
                                //   debugPrint('Value in view $value');
                                //   if (value != 'null') {
                                //     EasyLoading.dismiss();
                                //     Navigator.of(context).pushReplacementNamed(HomeView.routeName);
                                //   }
                                // }),

                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text('Continue With Gmail'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.015),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(RegisterView.routeName);
                            },
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(
                              "Don't have an account? Create one",
                              style: AppStyle.bodyText1.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(ForgetPasswordView.routeName);
                            },
                            style: ButtonStyle(
                              overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: Text(
                              "Forget Password",
                              style: AppStyle.bodyText1.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
