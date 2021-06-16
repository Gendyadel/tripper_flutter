import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/register/register_cubit.dart';
import 'package:tripper_flutter/components/sign_in_button.dart';
import 'package:tripper_flutter/src/colors.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/register/register_by_mail_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Tripper',
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: defaultColor),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Sign up now',
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            color: Colors.black,
                          ),
                    ),
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/AroundTheworldRegister.png'),
                          fit: BoxFit.contain,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SignInButton(
                      text: 'Sing up with Email',
                      onPressed: () {
                        navigateTo(context, MailRegisterScreen());
                      },
                      backgroundColor: defaultColor,
                      textColor: Colors.white,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInButton(
                      text: 'Sing up with Gmail',
                      assetName: 'assets/images/google-logo.png',
                      onPressed: () {},
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      elevation: 30,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignInButton(
                      text: 'Sign up with Facebook',
                      assetName: 'assets/images/facebook-logo.png',
                      onPressed: () {},
                      backgroundColor: facebookColor2,
                      textColor: Colors.white,
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
