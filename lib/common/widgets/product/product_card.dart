import 'package:flutter/material.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/domain/product/entities/product.dart';
import 'package:online_shop/presentation/product_detail/pages/product_detail.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../helper/images/image_display.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductCard({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(
            context,
            ProductDetailPage(
              productEntity: productEntity,
            ));
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bagian gambar
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      ImageDisplayHelper.generateProductImageURL(
                          productEntity.images[0]),
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
            // Bagian teks
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Harga dan diskon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          productEntity.discountedPrice == 0
                              ? "\$${productEntity.price}"
                              : "\$${productEntity.discountedPrice}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        if (productEntity.discountedPrice != 0)
                          Text(
                            "\$${productEntity.price}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 213, 213, 213),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Judul produk
                    Text(
                      productEntity.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                        color: Color.fromARGB(255, 251, 235, 255),
                      ),
                      maxLines: 2, // Membatasi hingga 2 baris teks
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
