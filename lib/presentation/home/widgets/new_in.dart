import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/domain/product/usecases/get_new_in.dart';

import '../../../common/bloc/product/products_display_cubit.dart';
import '../../../common/bloc/product/products_display_state.dart';
import '../../../common/widgets/product/product_card.dart';
import '../../../domain/product/entities/product.dart';
import '../../../service_locator.dart';

class NewIn extends StatelessWidget {
  const NewIn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsDisplayCubit(
        useCase: sl<GetNewInUseCase>(),
      )..displayProducts(),
      child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _newInHeader(),
                  const SizedBox(height: 16),
                  _productList(products: state.products),
                ],
              ),
            );
          }
          return const Center(
            child: Text(
              "No products available",
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }

  /// Header Section with decorative underline
  Widget _newInHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'New In',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color.fromARGB(255, 226, 215, 255),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 50,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  /// Horizontal Product List
  Widget _productList({required List<ProductEntity> products}) {
    return SizedBox(
      height: 320, // Tinggi container agar produk terlihat proporsional
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(productEntity: products[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }
}
