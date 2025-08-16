import 'package:cached_network_image/cached_network_image.dart';
import 'package:case1/features/home/data/models/product.dart';
import 'package:case1/features/cart/presentation/bloc/card_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ProductCard({super.key, required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            spreadRadius: 1.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with discount badge and favorite icon
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl,
                  height: 130.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator(strokeWidth: 1),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.broken_image, size: 40.sp),
                ),
              ),
              if (product.discount != null)
                Positioned(
                  top: 8.h,
                  left: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      "-${product.discount!.toInt()}%",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.grey.shade600,
                  size: 20.sp,
                ),
              ),
            ],
          ),

          // Product name
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ),

          // Price row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Row(
              children: [
                Text(
                  "\$${product.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 6.w),
                if (product.discount != null)
                  Text(
                    "\$${(product.price * (1 + product.discount! / 100)).toStringAsFixed(2)}", // Eski fiyatı örnek verdim
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ),

          const Spacer(),

          // Add to cart button
          Padding(
            padding: EdgeInsets.all(8.w),
            child: SizedBox(
              width: double.infinity,
              height: 36.h,
              child: BlocBuilder<CartCubit, List<Product>>(
                builder: (context, cartProducts) {
                  final isAdded = cartProducts.contains(product);

                  return ElevatedButton(
                    onPressed: isAdded ? null : onAddToCart ?? () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAdded ? Colors.green : Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      isAdded ? "Sepete Eklendi" : "Sepete Ekle",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
