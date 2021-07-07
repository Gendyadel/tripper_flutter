import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:tripper_flutter/models/auth/user_model.dart';
import 'package:tripper_flutter/service/firestore_user.dart';
import 'package:tripper_flutter/service/storage/cache_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegisterWithEmail({
    @required String email,
    @required String password,
    @required String displayName,
    @required String phoneNumber,
    String picture,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((user) {
      print(user.user.email);
      print(user.user.uid);
      CacheHelper.saveData(key: 'uId', value: user.user.uid);
      saveUser(user, displayName, phoneNumber);
    }).catchError((onError) {
      emit(RegisterErrorState(onError));
    });
  }

  void saveUser(UserCredential user, String displayName, String phoneNumber) {
    UserModel userModel = UserModel(
      phone: phoneNumber,
      displayName: displayName,
      email: user.user.email,
      uid: user.user.uid,
      picture:
          'https://firebasestorage.googleapis.com/v0/b/tripper03-9a6fd.appspot.com/o/blank-profile-picture.png?alt=media&token=b910a708-a5fe-444b-b544-2997ef4dbf3c',
    );
    FirestoreUser().addUserToFirestore(userModel: userModel);
    emit(CreateUserSuccessState());
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
