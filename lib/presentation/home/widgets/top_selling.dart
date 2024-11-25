import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/domain/product/usecases/get_top_selling.dart';
import '../../../common/bloc/product/products_display_cubit.dart';
import '../../../common/bloc/product/products_display_state.dart';
import '../../../common/widgets/product/product_card.dart';
import '../../../domain/product/entities/product.dart';
import '../../../service_locator.dart';
import '../../../core/configs/theme/app_colors.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>())
        ..displayProducts(),
      child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return _loadingState();
          }
          if (state is ProductsLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _topSellingTitle(),
                  const SizedBox(height: 20),
                  _products(state.products),
                ],
              ),
            );
          }
          return _errorState(); // Handling any errors
        },
      ),
    );
  }

  /// Loading state widget with visual feedback
  Widget _loadingState() {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
        strokeWidth: 2.5,
      ),
    );
  }

  /// Error state widget with helpful message
  Widget _errorState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 40),
          SizedBox(height: 8),
          Text(
            'Oops! Unable to load top-selling products.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  /// Title for top-selling section with improved styling
  Widget _topSellingTitle() {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Selling',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Color.fromARGB(255, 231, 222, 255),
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

  /// Horizontal List of top-selling products with styled items
  Widget _products(List<ProductEntity> products) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return _productCard(products[index]);
        },
      ),
    );
  }

  /// Individual product card with additional styling
  Widget _productCard(ProductEntity productEntity) {
    return ProductCard(productEntity: productEntity);
  }
}
