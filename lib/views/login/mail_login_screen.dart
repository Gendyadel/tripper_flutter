import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/login/login_cubit.dart';
import 'package:tripper_flutter/components/custom_flat_button.dart';
import 'package:tripper_flutter/components/custom_form_field.dart';
import 'package:tripper_flutter/components/custom_text_button.dart';
import 'package:tripper_flutter/components/toast.dart';
import 'package:tripper_flutter/layout/user_layout.dart';
import 'package:tripper_flutter/service/storage/cache_helper.dart';
import 'package:tripper_flutter/src/colors.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/register/register_by_mail_screen.dart';

class MailLoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final TextEditingController phoneController = TextEditingController();
  // final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToaster(message: state.error, state: ToastStates.ERROR);
          } else if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              navigateAndReplace(context, UserLayout());
            });
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Login Now ..',
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        labelText: 'Email',
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        prefix: Icons.email,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomFormField(
                        labelText: 'Password',
                        isPassword: cubit.isPassword,
                        suffixIcon: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        controller: passwordController,
                        inputType: TextInputType.visiblePassword,
                        //  suffixIcon: Icons.,
                        prefix: Icons.lock,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.isNotEmpty && value.length < 8) {
                            return 'Password must contain at least 8 characters';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            cubit.loginWithEmail(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                        text: 'Login',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
