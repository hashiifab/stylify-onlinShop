import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/presentation/cart/bloc/cart_products_display_cubit.dart';

import '../bloc/cart_products_display_state.dart';
import '../widgets/checkout.dart';
import '../widgets/product_ordered_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Cart'),
      ),
      body: BlocProvider(
        create: (context) => CartProductsDisplayCubit()..displayCartProducts(),
        child: BlocBuilder<CartProductsDisplayCubit, CartProductsDisplayState>(
          builder: (context, state) {
            if (state is CartProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartProductsLoaded) {
              return state.products.isEmpty
                  ? _cartIsEmpty(context) // Tampilkan jika cart kosong
                  : Column(
                      children: [
                        // Daftar produk dalam area scrollable
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemBuilder: (context, index) {
                              return ProductOrderedCard(
                                productOrderedEntity: state.products[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: state.products.length,
                          ),
                        ),
                        // Widget Checkout tetap di bagian bawah
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Checkout(products: state.products),
                          ),
                        ),
                      ],
                    );
            }
            if (state is LoadCartProductsFailure) {
              return Center(
                child: Text(state.errorMessage), // Tampilkan pesan error
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _cartIsEmpty(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar dan teks jika cart kosong
            Image.asset(
              'assets/images/empty_order.png',
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 24),
            const Text(
              "Your cart is empty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Browse products and add them to your cart to start shopping!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
