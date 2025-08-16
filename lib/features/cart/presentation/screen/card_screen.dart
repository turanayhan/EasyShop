import 'package:case1/features/home/data/models/product.dart';
import 'package:case1/features/cart/presentation/bloc/card_bloc.dart';
import 'package:case1/features/cart/presentation/widget/card_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sepetim'),
        actions: [
          BlocBuilder<CartCubit, List<Product>>(
            builder: (context, cartItems) {
              if (cartItems.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: const Icon(Icons.delete_forever),
                tooltip: 'Sepeti Temizle',
                onPressed: () => context.read<CartCubit>().clearCart(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, List<Product>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return const Center(
              child: Text('Sepetin boş', style: TextStyle(fontSize: 18)),
            );
          }

          double totalPrice = cartItems.fold(
            0,
            (sum, product) => sum + product.price * (product.quantity ?? 1),
          );

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.all(12.w),
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => Divider(height: 1.h),
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    final quantity = product.quantity ?? 1; // null kontrolü!

                    return CartItemWidget(
                      product: product,
                      quantity: quantity,
                      onRemove: () =>
                          context.read<CartCubit>().removeProduct(product),
                      onDecrement: () {
                        if (quantity > 1) {
                          context.read<CartCubit>().updateProductQuantity(
                            product,
                            quantity - 1,
                          );
                        }
                      },
                      onIncrement: () {
                        context.read<CartCubit>().updateProductQuantity(
                          product,
                          quantity + 1,
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.r,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Toplam: \$${totalPrice.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ödeme işlemi başladı')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 12.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        "Ödeme Yap",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
