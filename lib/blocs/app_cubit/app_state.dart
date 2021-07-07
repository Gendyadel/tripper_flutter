part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ChangeBottomNavState extends AppState {}

class GetUserLoadingState extends AppState {}

class GetUserSuccessState extends AppState {}

class GetUserErrorState extends AppState {
  final String error;

  GetUserErrorState(this.error);
}

class GetPropertiesLoadingState extends AppState {}

class GetPropertiesSuccessState extends AppState {}

class GetPropertiesErrorState extends AppState {
  final String error;

  GetPropertiesErrorState(this.error);
}

class GetBannerErrorState extends AppState {
  final String error;

  GetBannerErrorState(this.error);
}

class ChangeFavoritesState extends AppState {}

class SuccessChangeFavoritesState extends AppState {
  //final ChangeFavoritesModel model;

//  SuccessChangeFavoritesState(this.model);
}

class ErrorChangeFavoritesState extends AppState {}

class LoadingGetFavoritesState extends AppState {}

class SuccessGetFavoritesState extends AppState {}

class ErrorGetFavoritesState extends AppState {
  final String error;

  ErrorGetFavoritesState(this.error);
}
