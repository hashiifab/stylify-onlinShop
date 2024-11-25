import 'package:flutter/material.dart';
import 'package:online_shop/common/helper/images/image_display.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/domain/product/entities/product.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductImages({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320, // Ukuran tetap menarik untuk elemen gambar utama
      padding: const EdgeInsets.symmetric(horizontal: 16), // Padding global
      child: Stack(
        children: [
          _backgroundGradient(),
          _productImage(),
        ],
      ),
    );
  }

  /// Widget untuk latar belakang dengan gradasi lembut
  Widget _backgroundGradient() {
    return Positioned.fill(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
               AppColors.background,
              Color.fromARGB(255, 40, 13, 76),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  /// Widget untuk menampilkan gambar produk utama
  Widget _productImage() {
    return Align(
      alignment: Alignment.center, // Memusatkan gambar di tengah
      child: Container(
        width: 280, // Lebih besar untuk menonjolkan gambar
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow lembut
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          image: DecorationImage(
            fit: BoxFit.contain, // Pastikan gambar memenuhi seluruh container
            image: NetworkImage(
              ImageDisplayHelper.generateProductImageURL(productEntity.images[0]),
            ),
          ),
        ),
      ),
    );
  }
}
