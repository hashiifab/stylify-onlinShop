import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/button/button_state_cubit.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/domain/product/entities/product.dart';
import 'package:online_shop/presentation/product_detail/bloc/favorite_icon_cubit.dart';
import 'package:online_shop/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:online_shop/presentation/product_detail/bloc/product_quantity_cubit.dart';
import 'package:online_shop/presentation/product_detail/bloc/product_size_selection_cubit.dart';
import 'package:online_shop/presentation/product_detail/widgets/add_to_bag.dart';

import '../widgets/favorite_button.dart';
import '../widgets/selected_color.dart';
import '../widgets/product_images.dart';
import '../widgets/product_price.dart';
import '../widgets/product_quantity.dart';
import '../widgets/product_title.dart';
import '../widgets/selected_size.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductDetailPage({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductQuantityCubit()),
        BlocProvider(create: (context) => ProductColorSelectionCubit()),
        BlocProvider(create: (context) => ProductSizeSelectionCubit()),
        BlocProvider(create: (context) => ButtonStateCubit()),
        BlocProvider(
          create: (context) =>
              FavoriteIconCubit()..isFavorite(productEntity.productId), // Memastikan status favorit diambil
        ),
      ],
      child: Scaffold(
        appBar: BasicAppbar(
          hideBack: false,
          action: FavoriteButton(
            productEntity: productEntity, // Menyuntikkan produk untuk tombol favorit
          ),
        ),
        bottomNavigationBar: AddToBag(
          productEntity: productEntity,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImages(productEntity: productEntity),
                const SizedBox(height: 20),
                _productDetails(context),
                const SizedBox(height: 20),
                _interactiveOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductTitle(productEntity: productEntity),
        const SizedBox(height: 10),
        ProductPrice(productEntity: productEntity),
      ],
    );
  }

  Widget _interactiveOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectedSize(productEntity: productEntity),
        const SizedBox(height: 15),
        SelectedColor(productEntity: productEntity),
        const SizedBox(height: 15),
        ProductQuantity(productEntity: productEntity),
      ],
    );
  }
}
