import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:tripper_flutter/models/property/property_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  PropertyModel searchModel;

  void search(String text) {
    emit(SearchLoadingState());

    // .then((value) {
    // // searchModel = SearchModel.fromJson(value.data);
    // emit(SearchSuccessState());
    // }).catchError((onError) {
    // print(onError.toString());
    // emit(SearchErrorState());
    // });
  }
}
