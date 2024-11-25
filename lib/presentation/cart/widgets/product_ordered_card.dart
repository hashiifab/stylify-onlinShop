import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/helper/images/image_display.dart';
import 'package:online_shop/domain/order/entities/product_ordered.dart';
import 'package:online_shop/presentation/cart/bloc/cart_products_display_cubit.dart';

import '../../../core/configs/theme/app_colors.dart';

class ProductOrderedCard extends StatelessWidget {
  final ProductOrderedEntity productOrderedEntity;
  const ProductOrderedCard({required this.productOrderedEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Gambar Produk
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 90, // Ukuran tetap
              height: 90, // Sesuai dengan ukuran yang diinginkan
              child: Image.network(
                ImageDisplayHelper.generateProductImageURL(
                    productOrderedEntity.productImage),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12), // Spasi antar elemen

          // Detail Produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productOrderedEntity.productTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    // Ukuran Produk
                    Text.rich(
                      TextSpan(
                        text: 'Size: ',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: productOrderedEntity.productSize,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Warna Produk
                    Text.rich(
                      TextSpan(
                        text: 'Color: ',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: productOrderedEntity.productColor,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${productOrderedEntity.totalPrice}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          // Tombol Hapus
          GestureDetector(
            onTap: () {
              context
                  .read<CartProductsDisplayCubit>()
                  .removeProduct(productOrderedEntity);
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                color: Color(0xffFF8383),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
