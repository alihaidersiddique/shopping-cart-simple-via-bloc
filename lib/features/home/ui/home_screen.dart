import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/cart/ui/cart_screen.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/home/bloc/home_bloc.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/home/widgets/product_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Go GROCERY"),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              homeBloc.add(HomeCartItemsButtonPressedEvent());
            },
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, listeningState) {
          if (listeningState is HomeCartItemsButtonPressedState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          } else if (listeningState is HomeAddToCartButtonPressedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added to Cart!")),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeLoadingState:
              return const Center(child: CircularProgressIndicator());

            case HomeSuccessState:
              final successState = state as HomeSuccessState;
              return ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) => ProductTileWidget(
                  productDataModel: successState.products[index],
                  homeBloc: homeBloc,
                ),
              );

            case HomeErrorState:
              final errorState = state as HomeErrorState;
              return Center(
                child: Text("Error found:\n ${errorState.error}"),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
