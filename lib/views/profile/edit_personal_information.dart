import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripper_flutter/blocs/app_cubit/app_cubit.dart';
import 'package:tripper_flutter/components/custom_flat_button.dart';
import 'package:tripper_flutter/components/custom_form_field.dart';
import 'package:tripper_flutter/src/colors.dart';

class EditPersonalInfo extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var model = cubit.userModel;
        nameController.text = model.displayName;
        emailController.text = model.email;
        phoneController.text = model.phone;

        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(
                      'Edit Profile',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      color: Colors.black38,
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      '${model.picture}',
                                    ))),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: defaultColor,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomFormField(
                      controller: nameController,
                      inputType: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'name can not be empty';
                        }
                        return null;
                      },
                      labelText: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 10,
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
                      height: 10,
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
                    CustomButton(
                      onPressed: () {},
                      text: 'save',
                      radius: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
