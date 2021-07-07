import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tripper_flutter/models/auth/user_model.dart';
import 'package:tripper_flutter/models/banner_model.dart';
import 'package:tripper_flutter/models/property/favourite_model.dart';
import 'package:tripper_flutter/models/property/property_model.dart';
import 'package:tripper_flutter/service/storage/firestore_service.dart';
import 'package:tripper_flutter/src/constants.dart';
import 'package:tripper_flutter/views/home/home_screen.dart';
import 'package:tripper_flutter/views/profile/profile_screen.dart';
import 'package:tripper_flutter/views/trips/trips_screen.dart';
import 'package:tripper_flutter/views/wishlist/wishlist_screen.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);
  FireStoreService _fireStoreService = FireStoreService();
  final _currentUser = FirebaseAuth.instance.currentUser.uid;

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
      // print(value.data());
      userModel = UserModel.fromJson(value.data());
      // print('current user iddddd: {$_currentUser}');
      emit(GetUserSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(GetUserErrorState(onError.toString()));
    });
  }

  List<PropertyModel> get propertyModel => _propertyModel;
  List<PropertyModel> _propertyModel = [];

  void getPropertiesData() {
    emit(GetPropertiesLoadingState());
    print('getPropertiesData() ضحك');
    _fireStoreService.getProperties().then((value) {
      for (int i = 0; i < value.length; i++) {
        _propertyModel.add(PropertyModel.fromJson(value[i].data()));
      }

      emit(GetPropertiesSuccessState());
    }).catchError((onError) {
      emit(GetPropertiesErrorState(onError));
    });
  }

  Map<String, bool> favorites = {};

  List<FavourtieModel> get favouriteModel => _favouriteModel;
  List<FavourtieModel> _favouriteModel = [];

  void getFavouritesData() {
    emit(LoadingGetFavoritesState());
    print('getFavourites() ضحكتين');
    _fireStoreService.getFavourites(userId: _currentUser).then((value) {
      for (int i = 0; i < value.length; i++) {
        if (FavourtieModel.fromJson(json: value[i].data()).isFavourite) {
          _favouriteModel.add(FavourtieModel.fromJson(
              propertyID: value[i].id, json: value[i].data()));
        }
        // print('Property id:${_favouriteModel[i].propertyId} :${_favouriteModel[i].isFavourite}');
      }

      emit(SuccessGetFavoritesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetFavoritesState(onError));
    });
  }

  void changeFavorites({String propertyID}) {
    //favorites[propertyID]
    emit(ChangeFavoritesState());
    _fireStoreService
        .editFavouritesInFirestore(userId: _currentUser, propertyId: propertyID)
        .then((value) {
      // _favouriteModel.add(FavourtieModel.fromJson(value));
      // print(favouriteModel[0]);
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorChangeFavoritesState());
    });
  }

  List<BannerModel> get bannerModel => _bannerModel;
  List<BannerModel> _bannerModel = [];
  final CollectionReference _bannerCollectionReference =
      FirebaseFirestore.instance.collection('banners');

  void getBannerData() {
    _bannerCollectionReference.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _bannerModel.add(BannerModel.fromJson(value.docs[i].data()));
      }
    }).catchError((onError) {
      emit(GetBannerErrorState(onError));
    });
  }
}
