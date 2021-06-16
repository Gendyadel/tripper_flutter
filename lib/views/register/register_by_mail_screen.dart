import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/register/register_cubit.dart';
import 'package:tripper_flutter/components/custom_flat_button.dart';
import 'package:tripper_flutter/components/custom_form_field.dart';
import 'package:tripper_flutter/layout/user_layout.dart';
import 'package:tripper_flutter/src/constants.dart';

class MailRegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            navigateAndReplace(context, UserLayout());
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
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
                        'Register..',
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Start your trip now',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomFormField(
                        labelText: 'Name',
                        controller: nameController,
                        inputType: TextInputType.name,
                        prefix: Icons.person,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                        },
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
                        //TODO validate password with regex
                        labelText: 'Password',
                        isPassword: cubit.isPassword,
                        suffixIcon: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        controller: passwordController,
                        inputType: TextInputType.visiblePassword,
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
                      CustomFormField(
                        labelText: 'Phone',
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        prefix: Icons.phone,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'We need your phone number';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! CreateUserSuccessState,
                        builder: (context) => CustomButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              cubit.userRegisterWithEmail(
                                email: emailController.text,
                                password: passwordController.text,
                                displayName: nameController.text,
                                phoneNumber: phoneController.text,
                              );
                            }
                          },
                          text: 'Register',
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
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
