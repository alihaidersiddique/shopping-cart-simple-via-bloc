part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeAddToCartButtonPressedEvent extends HomeEvent {
  final ProductModel product;

  HomeAddToCartButtonPressedEvent({required this.product});
}

class HomeAddToWishlistButtonPressedEvent extends HomeEvent {
  final ProductModel product;

  HomeAddToWishlistButtonPressedEvent({required this.product});
}

class HomeCartItemsButtonPressedEvent extends HomeEvent {}

class HomeWishlistItemsButtonPressedEvent extends HomeEvent {}
