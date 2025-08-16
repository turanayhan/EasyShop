import 'package:case1/features/cart/presentation/bloc/card_bloc.dart';
import 'package:case1/features/home/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:case1/features/home/presentation/bloc/product_bloc.dart';
import 'package:case1/features/home/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          final categories = state.categories;

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, outerIndex) {
              final category = categories[outerIndex];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.products.length,
                        itemBuilder: (context, innerIndex) {
                          final product = category.products[innerIndex];

                          return ProductCard(
                            product: product,
                            onAddToCart: () {
                              context.read<CartCubit>().addProduct(
                                product,
                              ); // Sepete ürün ekle

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${product.name} sepete eklendi!',
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        }

        return const Center(child: Text("Veri bekleniyor..."));
      },
    );
  }
}
