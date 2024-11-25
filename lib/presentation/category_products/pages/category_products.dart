import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/product/products_display_cubit.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/common/widgets/product/product_card.dart';
import 'package:online_shop/domain/category/entity/category.dart';
import 'package:online_shop/domain/product/usecases/get_products_by_category_id.dart';
import 'package:online_shop/service_locator.dart';
import '../../../common/bloc/product/products_display_state.dart';
import '../../../domain/product/entities/product.dart';
import '../../../core/configs/theme/app_colors.dart';

class CategoryProductsPage extends StatelessWidget {
  final CategoryEntity categoryEntity;
  const CategoryProductsPage({required this.categoryEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(categoryEntity.title),
        backgroundColor: AppColors.background, // Consistent with theme
      ),
      body: BlocProvider(
        create: (context) =>
            ProductsDisplayCubit(useCase: sl<GetProductsByCategoryIdUseCase>())
              ..displayProducts(params: categoryEntity.categoryId),
        child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return _loadingState();
            }
            if (state is ProductsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _categoryInfo(state.products),
                    const SizedBox(height: 20),
                    _products(state.products),
                  ],
                ),
              );
            }
            return _errorState(); // Show error state for any failure
          },
        ),
      ),
    );
  }

  // Loading State Widget
  Widget _loadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  // Error State Widget
  Widget _errorState() {
    return const Center(
      child: Text(
        'Oops! Something went wrong. Please try again.',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.primary),
      ),
    );
  }

  // Category Information (title and product count)
  Widget _categoryInfo(List<ProductEntity> products) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${categoryEntity.title} (${products.length})',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Color.fromARGB(255, 224, 213, 255),
          ),
        ),
        // Optionally add filter or sort button here if needed in the future
      ],
    );
  }

  // Grid of Products in the category
  Widget _products(List<ProductEntity> products) {
    return Expanded(
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            productEntity: products[index],
          );
        },
      ),
    );
  }
}
