part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {
  final List<ProductModel> cart;

  CartInitialEvent({required this.cart});
}

class ProductAddedToCartEvent extends CartEvent {
  final ProductModel product;

  ProductAddedToCartEvent({required this.product});
}

class ProductRemovedFromCartEvent extends CartEvent {
  final ProductModel product;

  ProductRemovedFromCartEvent({required this.product});
}
