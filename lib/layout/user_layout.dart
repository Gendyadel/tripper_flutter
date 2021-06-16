import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/components/custom_flat_button.dart';
import 'package:tripper_flutter/components/custom_text_button.dart';
import 'package:tripper_flutter/components/toast.dart';

class UserLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
                left: 10,
                right: 10,
                top: 10,
              ),
              child: Text(
                'TRIPPER',
              ),
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context) {
              var model = cubit.model;
              return Column(
                children: [
                  if (!FirebaseAuth.instance.currentUser.emailVerified)
                    Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.all(2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Please verify your Email'),
                              Spacer(),
                              CustomButton(
                                onPressed: () {
                                  FirebaseAuth.instance.currentUser
                                      .sendEmailVerification()
                                      .then((value) {
                                    showToaster(
                                        message: 'Check your email',
                                        state: ToastStates.SUCCESS);
                                  }).catchError((onError) {});
                                },
                                text: 'send ',
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}
