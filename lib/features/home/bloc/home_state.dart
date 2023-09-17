part of 'home_bloc.dart';

//---- simple states

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {
  final List<ProductModel> products;

  HomeSuccessState({required this.products});
}

final class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});
}

// ----- action states

@immutable
sealed class HomeActionState extends HomeState {}

final class HomeCartItemsButtonPressedState extends HomeActionState {}

final class HomeWishlistItemsButtonPressedState extends HomeActionState {}

final class HomeAddToCartButtonPressedState extends HomeActionState {}

final class HomeAddToWislistButtonPressedState extends HomeActionState {}
