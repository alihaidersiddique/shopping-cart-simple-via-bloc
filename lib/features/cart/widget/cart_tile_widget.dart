import 'package:flutter/material.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:practice_shopping_cart_wishlist_simple_bloc/features/home/models/product_model.dart';

class CartTileWidget extends StatelessWidget {
  final ProductModel product;
  final CartBloc cartBloc;

  const CartTileWidget({
    super.key,
    required this.product,
    required this.cartBloc,
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
                image: NetworkImage(product.imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(product.name,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(product.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$${product.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  cartBloc.add(ProductRemovedFromCartEvent(product: product));
                },
                icon: const Icon(Icons.shopping_cart),
              )
            ],
          ),
        ],
      ),
    );
  }
}
