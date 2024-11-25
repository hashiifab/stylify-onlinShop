import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:online_shop/common/helper/images/image_display.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/presentation/all_categories/pages/all_categories.dart';
import 'package:online_shop/presentation/category_products/pages/category_products.dart';

import '../../../common/bloc/categories/categories_display_state.dart';
import '../../../domain/category/entity/category.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesDisplayCubit()..displayCategories(),
      child: BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CategoriesLoaded) {
            return Column(
              children: [
                _seeAll(context),
                const SizedBox(height: 20),
                if (state.categories.isNotEmpty) _categories(state.categories),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _seeAll(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
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
          ),
          GestureDetector(
            onTap: () {
              AppNavigator.push(context, const AllCategoriesPage());
            },
            child: const Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _categories(List<CategoryEntity> categories) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              AppNavigator.push(
                context,
                CategoryProductsPage(
                  categoryEntity: categories[index],
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        ImageDisplayHelper.generateCategoryImageURL(
                          categories[index].image,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  categories[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: categories.length,
      ),
    );
  }
}
