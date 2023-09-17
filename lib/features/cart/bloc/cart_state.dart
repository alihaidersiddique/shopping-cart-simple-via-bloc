part of 'cart_bloc.dart';

// simple states

@immutable
sealed class CartState {}

final class CartInitialState extends CartState {
  final List<ProductModel> cart;

  CartInitialState({required this.cart});
}

final class NoProductInCartState extends CartState {}

final class ErrorInCartState extends CartState {
  final String error;

  ErrorInCartState({required this.error});
}

// actions states

@immutable
sealed class CartActionState extends CartState {}

class ProductAddedToCartState extends CartActionState {}

class ProductRemovedFromCartState extends CartActionState {}
