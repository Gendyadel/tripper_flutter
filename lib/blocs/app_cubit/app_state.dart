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
