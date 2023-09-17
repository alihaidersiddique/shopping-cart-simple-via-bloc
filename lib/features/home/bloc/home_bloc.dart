import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/data/cart_items.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/data/grocery_data.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/home/models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeCartItemsButtonPressedEvent>(homeCartItemsButtonPressedEvent);

    on<HomeAddToCartButtonPressedEvent>(
      homeAddToCartButtonPressedEvent,
    );
  }

  Future<FutureOr<void>> homeInitialEvent(
    HomeInitialEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());

    await Future.delayed(const Duration(seconds: 2));

    try {
      final products = GroceryData.groceryProducts
          .map((e) => ProductModel.fromJson(e))
          .toList();

      emit(HomeSuccessState(products: products));
    } catch (e) {
      emit(HomeErrorState(error: e.toString()));
    }
  }

  FutureOr<void> homeCartItemsButtonPressedEvent(
    HomeCartItemsButtonPressedEvent event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeCartItemsButtonPressedState());
  }

  FutureOr<void> homeAddToCartButtonPressedEvent(
    HomeAddToCartButtonPressedEvent event,
    Emitter<HomeState> emit,
  ) {
    cartItems.add(event.product);
    emit(HomeAddToCartButtonPressedState());
  }
}
