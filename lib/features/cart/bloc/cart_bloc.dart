import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/data/cart_items.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/home/imports.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState(cart: cartItems)) {
    on<CartInitialEvent>(cartInitialEvent);
    on<ProductAddedToCartEvent>(productAddedToCartEvent);
    on<ProductRemovedFromCartEvent>(productRemovedFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
    CartInitialEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      if (cartItems.isEmpty) {
        emit(NoProductInCartState());
      } else {
        emit(CartInitialState(cart: cartItems));
      }
    } catch (e) {
      emit(ErrorInCartState(error: e.toString()));
    }
  }

  FutureOr<void> productAddedToCartEvent(
    ProductAddedToCartEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      cartItems.add(event.product);
      emit(ProductAddedToCartState());
    } catch (e) {
      emit(ErrorInCartState(error: e.toString()));
    }
  }

  FutureOr<void> productRemovedFromCartEvent(
    ProductRemovedFromCartEvent event,
    Emitter<CartState> emit,
  ) {
    try {
      cartItems.remove(event.product);
      emit(ProductRemovedFromCartState());
      if (cartItems.isNotEmpty) {
        emit(CartInitialState(cart: cartItems));
      } else {
        emit(NoProductInCartState());
      }
    } catch (e) {
      emit(ErrorInCartState(error: e.toString()));
    }
  }
}
