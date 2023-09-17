import 'package:flutter/material.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/home/bloc/home_bloc.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/home/models/product_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductModel productDataModel;
  final HomeBloc homeBloc;

  const ProductTileWidget({
    super.key,
    required this.productDataModel,
    required this.homeBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productDataModel.imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(productDataModel.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${productDataModel.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  homeBloc.add(
                    HomeAddToCartButtonPressedEvent(
                      product: productDataModel,
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
              )
            ],
          ),
        ],
      ),
    );
  }
}
