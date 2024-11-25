import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/button/button_state_cubit.dart';
import 'package:online_shop/common/helper/cart/cart.dart';
import 'package:online_shop/common/widgets/button/basic_reactive_button.dart';
import 'package:online_shop/presentation/cart/pages/paymentMethodPage.dart';
import '../../../common/bloc/button/button_state.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../domain/order/entities/product_ordered.dart';

class CheckOutPage extends StatelessWidget {
  final List<ProductOrderedEntity> products;

  CheckOutPage({required this.products, super.key});

  final TextEditingController _addressCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Checkout'),
      ),
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackbar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _addressField(),
                const SizedBox(height: 24), // Ruang antara input dan total
                Expanded(child: Container()), // Memastikan bagian bawah tetap di bawah
                _totalAndButtonSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _addressCon,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Enter your shipping address...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFE0E0E0),
              ),
            ),
            filled: true,
            fillColor: const Color(0xFFF7F7F7),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  // Menggabungkan total harga dan tombol menjadi satu bagian yang lebih rapi
  Widget _totalAndButtonSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFE0E0E0),
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          // Total Price section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              Text(
                '\$${CartHelper.calculateCartSubtotal(products) + 8}', // Total price + shipping
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16), // Ruang antara total dan tombol
          // Tombol untuk melanjutkan ke metode pembayaran
          BasicReactiveButton(
            content: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue to Payment',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            onPressed: () {
              // Navigasi ke halaman metode pembayaran
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentMethodPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
