import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_api_call/pages/home/model/home_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart'
    as http; // Make sure to add the http package in your pubspec.yaml

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchAPiEvent>(fetchAPiEvent);
  }
  FutureOr<void> fetchAPiEvent(
      FetchAPiEvent event, Emitter<HomeState> emit) async {
    emit(ApiLoadingState());

    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Product> products =
            data.map((json) => Product.fromJson(json)).toList();

        emit(ApiSuccessState(
            products: products)); // Emit success with product data
      } else {
        emit(ApiFalureState());
      }
    } catch (e) {
      emit(ApiFalureState());
    }
  }
}
