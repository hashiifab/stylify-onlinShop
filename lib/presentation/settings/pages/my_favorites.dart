import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/domain/product/usecases/get_favorties_products.dart';

import '../../../common/bloc/product/products_display_cubit.dart';
import '../../../common/bloc/product/products_display_state.dart';
import '../../../common/widgets/product/product_card.dart';
import '../../../domain/product/entities/product.dart';
import '../../../service_locator.dart';

class MyFavoritesPage extends StatelessWidget {
  const MyFavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('My Favorites'),
      ),
      body: BlocProvider(
        create: (context) =>
            ProductsDisplayCubit(useCase: sl<GetFavortiesProductsUseCase>())
              ..displayProducts(),  // Pastikan memuat produk favorit dengan benar
        child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProductsLoaded) {
              if (state.products.isEmpty) {
                return _emptyState(); // Jika kosong, tampilkan state kosong
              }
              return _products(state.products); // Jika ada, tampilkan produk
            }
            if (state is LoadProductsFailure) {
              return const Center(
                child: Text('Please try again'), // Pesan error jika gagal
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_order.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            const Text(
              "Your favorites list is empty.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Browse products and add them to your favorites.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return GridView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(productEntity: products[index]); // Menampilkan produk
      },
    );
  }
}
