import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/login/login_cubit.dart';
import 'package:tripper_flutter/components/custom_text_button.dart';
import 'package:tripper_flutter/components/sign_in_button.dart';
import 'package:tripper_flutter/layout/user_layout.dart';
import 'package:tripper_flutter/src/colors.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/login/mail_login_screen.dart';
import 'package:tripper_flutter/views/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is GoogleLoginSuccessState) {
            navigateAndReplace(context, UserLayout());
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: defaultColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login Now ..',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/HotelBookingLogin.png'),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SignInButton(
                      text: 'Login with Email',
                      onPressed: () {
                        navigateTo(context, MailLoginScreen());
                      },
                      backgroundColor: defaultColor,
                      textColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SignInButton(
                      text: 'Login with Gmail',
                      assetName: 'assets/images/google-logo.png',
                      onPressed: () {
                        cubit.signInWithGoogle();
                      },
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      elevation: 30,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SignInButton(
                      text: 'Login with Facebook',
                      assetName: 'assets/images/facebook-logo.png',
                      onPressed: () {
                        cubit.signInWithFacebook();
                      },
                      backgroundColor: facebookColor2,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have and account?',
                        ),
                        CustomTextButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                RegisterScreen(),
                              );
                            },
                            text: 'register now'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
