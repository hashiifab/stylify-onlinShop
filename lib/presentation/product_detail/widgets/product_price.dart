import 'package:flutter/material.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/domain/product/entities/product.dart';

class ProductPrice extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductPrice({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Harga diskon dan harga asli jika ada
          Row(
            children: [
              Text(
                "\$${productEntity.discountedPrice != 0 ? productEntity.discountedPrice.toString() : productEntity.price.toString()}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20, // Ukuran font lebih besar
                  color: Color.fromARGB(
                      255, 220, 207, 255), // Warna utama untuk harga
                ),
              ),
              if (productEntity.discountedPrice != 0)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "\$${productEntity.price}",
                    style: const TextStyle(
                      fontSize: 14, // Ukuran font lebih kecil untuk harga asli
                      color: Colors.grey, // Warna grey untuk harga asli
                      decoration: TextDecoration
                          .lineThrough, // Garis coret untuk harga asli
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // Menambahkan detail harga tambahan (misal diskon persentase)
          if (productEntity.discountedPrice != 0)
            Text(
              "${((productEntity.price - productEntity.discountedPrice) / productEntity.price * 100).toStringAsFixed(0)}% OFF",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.red, // Merah untuk diskon, menarik perhatian
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
