import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/categories/categories_display_cubit.dart';
import 'package:online_shop/common/bloc/categories/categories_display_state.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/presentation/category_products/pages/category_products.dart';

import '../../../common/helper/images/image_display.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        hideBack: false,
        title: Text('All Categories'),
      ),
      body: BlocProvider(
        create: (context) => CategoriesDisplayCubit()..displayCategories(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shopByCategories(),
              const SizedBox(height: 20),
              Expanded(child: _categories()),
            ],
          ),
        ),
      ),
    );
  }

  // Title "Shop by Categories"
  Widget _shopByCategories() {
    return const Text(
      'Shop by Categories',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: Color.fromARGB(255, 230, 221, 255),
      ),
    );
  }

  // Display Categories List
  Widget _categories() {
    return BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoriesLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.categories.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  AppNavigator.push(
                    context,
                    CategoryProductsPage(
                      categoryEntity: state.categories[index],
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondBackground,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              ImageDisplayHelper.generateCategoryImageURL(
                                state.categories[index].image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          state.categories[index].title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 230, 221, 255),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Color.fromARGB(255, 148, 207, 255),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }

        return Container();
      },
    );
  }
}
