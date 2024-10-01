part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class ApiLoadingState extends HomeState {}

class ApiSuccessState extends HomeState {
  final List<Product> products;

  ApiSuccessState({required this.products});
}

class ApiFalureState extends HomeState {}
