import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/core/configs/assets/app_vectors.dart';
import 'package:online_shop/domain/product/usecases/get_products_by_title.dart';
import 'package:online_shop/service_locator.dart';

import '../../../common/bloc/product/products_display_cubit.dart';
import '../../../common/bloc/product/products_display_state.dart';
import '../../../common/widgets/product/product_card.dart';
import '../../../domain/product/entities/product.dart';
import '../widgets/search_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductsDisplayCubit(useCase: sl<GetProductsByTitleUseCase>()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: BasicAppbar(height: 80, title: SearchField()),
        ),
        body: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductsLoaded) {
              return state.products.isEmpty
                  ? _notFound()
                  : _products(state.products);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _notFound() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppVectors.notFound,
              height: 100, // Limit the size to keep it visually balanced
            ),
            const SizedBox(height: 16),
            const Text(
              "Sorry, we couldn't find any matching result for your search.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _products(List<ProductEntity> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6, // Optimize product card size
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(productEntity: products[index]);
        },
      ),
    );
  }
}
