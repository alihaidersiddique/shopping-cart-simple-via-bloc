import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/data/cart_items.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/cart/widget/cart_tile_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent(cart: cartItems));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is ProductRemovedFromCartState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product removed from cart.")),
            );
          } else if (state is ProductAddedToCartState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added to cart.")),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartInitialState:
              final initialState = state as CartInitialState;
              return ListView.builder(
                itemCount: initialState.cart.length,
                itemBuilder: (context, index) => CartTileWidget(
                  product: initialState.cart[index],
                  cartBloc: cartBloc,
                ),
              );

            case NoProductInCartState:
              return const Center(child: Text("Cart is Empty!"));

            case ErrorInCartState:
              final errorInCartState = state as ErrorInCartState;
              return Center(child: Text(errorInCartState.error));

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
