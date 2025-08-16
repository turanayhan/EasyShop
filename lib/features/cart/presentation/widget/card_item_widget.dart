import 'package:cached_network_image/cached_network_image.dart';
import 'package:case1/features/home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemWidget({
    Key? key,
    required this.product,
    required this.quantity,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: product.imageUrl,
          height: 130.h,
          width: 130.w,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: SizedBox(
              height: 20.h,
              width: 20.w,
              child: const CircularProgressIndicator(strokeWidth: 1),
            ),
          ),
          errorWidget: (context, url, error) =>
              Icon(Icons.broken_image, size: 40.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6.h),
              Text(
                "\$${product.price.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  _QuantityButton(icon: Icons.remove, onTap: onDecrement),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  _QuantityButton(icon: Icons.add, onTap: onIncrement),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRemove,
          icon: const Icon(Icons.delete),
          color: Colors.redAccent,
        ),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: Colors.grey.shade400),
        ),
        padding: EdgeInsets.all(4.w),
        child: Icon(icon, size: 20.sp),
      ),
    );
  }
}
