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
      userModel = UserModel.fromJson(value.data());
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

  List<PropertyModel> get favouriteModel => _favouriteModelList;
  List<PropertyModel> _favouriteModelList = [];
  List<FavourtieModel> _favouriteModel = [];

  var favorites = {};

  void getFavouritesData() {
    _favouriteModel = [];
    emit(LoadingGetFavoritesState());
    print('getFavourites() ضحكتين');

    _fireStoreService
        .getFavourites(userId: FirebaseAuth.instance.currentUser.uid)
        .then((favValue) {
      for (int i = 0; i < favValue.length; i++) {
        if (FavourtieModel.fromJson(json: favValue[i].data()).isFavourite) {
          _favouriteModel.add(FavourtieModel.fromJson(
              propertyID: favValue[i].id, json: favValue[i].data()));
        }
        // print('Property id:${_favouriteModel[i].propertyId} :${_favouriteModel[i].isFavourite}');
      }

      _getFavouritesAsMap();

      if (_favouriteModelList.isEmpty) {
        getWishlistFavourites();
      }

      emit(SuccessGetFavoritesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ErrorGetFavoritesState(onError));
    });
  }

  void _getFavouritesAsMap() {
    //something here
    favorites = {};
    // _favouriteModelList = [];
    print(_favouriteModel.length);
    for (int i = 0; i < _favouriteModel.length; i++) {
      print('as map${_favouriteModel[i].propertyId}');
      favorites[_favouriteModel[i].propertyId] = _favouriteModel[i].isFavourite;
    }
  }

  void getWishlistFavourites() {
    for (int i = 0; i < _favouriteModel.length; i++) {
      print(_favouriteModel[i].propertyId);
      favorites[_favouriteModel[i].propertyId] = _favouriteModel[i].isFavourite;

      _fireStoreService
          .getSpecificProperty(propertyID: _favouriteModel[i].propertyId)
          .then((value) {
        _favouriteModelList.add(PropertyModel.fromJson(value.data()));
      });
    }
  }

  void changeFavorites({String propertyID}) {
    if (favorites[propertyID] == null) {
      favorites[propertyID] = false;
    }
    if (favorites[propertyID] == true) {
      _favouriteModelList
          .removeWhere((element) => element.propertyId == propertyID);
    } else {
      _fireStoreService
          .getSpecificProperty(propertyID: propertyID)
          .then((value) {
        _favouriteModelList.add(PropertyModel.fromJson(value.data()));
      });
    }

    favorites[propertyID] = !favorites[propertyID];

    emit(LoadingChangeFavoritesState());

    _fireStoreService
        .editFavouritesInFirestore(
            userId: FirebaseAuth.instance.currentUser.uid,
            propertyId: propertyID,
            isFavourite: favorites[propertyID])
        .then((value) {
      // _favouriteModelList = [];
      emit(SuccessChangeFavoritesState());

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
