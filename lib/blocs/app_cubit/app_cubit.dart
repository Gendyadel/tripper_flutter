import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tripper_flutter/models/auth/user_model.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/home/home_screen.dart';
import 'package:tripper_flutter/views/profile/profile_screen.dart';
import 'package:tripper_flutter/views/trips/trips_screen.dart';
import 'package:tripper_flutter/views/wishlist/wishlist_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    HomeScreen(),
    WishlistScreen(),
    TripsScreen(),
    ProfileScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  UserModel userModel;

  void getUserData() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetUserErrorState(onError.toString()));
    });
  }

  void getPropertiesData() {
    emit(GetPropertiesLoadingState());
  }
}
