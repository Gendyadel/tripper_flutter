import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:tripper_flutter/models/auth/user_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegisterWithEmail({
    @required String email,
    @required String password,
    @required String displayName,
    @required String phoneNumber,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user.email);
      print(value.user.uid);

      userCreate(
        email: email,
        displayName: displayName,
        phoneNumber: phoneNumber,
        uid: value.user.uid,
      );
    }).catchError((onError) {
      emit(RegisterErrorState(onError));
    });
  }

  void userCreate({
    @required String email,
    @required String displayName,
    @required String phoneNumber,
    @required String uid,
  }) {
    UserModel userModel = UserModel(
      phone: phoneNumber,
      displayName: displayName,
      email: email,
      uid: uid,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((onError) {
      emit(CreateUserErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(PasswordChangeVisibilityState());
  }
}
