import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/presentation/cart/bloc/OrderCubit.dart';
import 'package:online_shop/presentation/cart/bloc/PaymentMethodCubit.dart';
import 'package:online_shop/presentation/cart/pages/order_placed.dart';

class PaymentMethodPage extends StatelessWidget {
  final List<String> paymentMethods = [
    'Kartu Kredit',
    'Transfer Bank',
    'Dompet Digital',
    'Cash on Delivery'
  ];

  PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Payment Method'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => OrderCubit(),
        child: BlocProvider(
          create: (context) => PaymentMethodCubit(),
          child: PaymentMethodView(paymentMethods: paymentMethods),
        ),
      ),
    );
  }
}

class PaymentMethodView extends StatelessWidget {
  final List<String> paymentMethods;

  const PaymentMethodView({super.key, required this.paymentMethods});

  @override
  Widget build(BuildContext context) {
    const double totalAmount = 150000;

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                final method = paymentMethods[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      title: Text(
                        method,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      leading: BlocBuilder<PaymentMethodCubit, String>(
                        builder: (context, selectedMethod) {
                          return Radio<String>(
                            value: method,
                            groupValue: selectedMethod,
                            onChanged: (value) {
                              context
                                  .read<PaymentMethodCubit>()
                                  .selectPaymentMethod(value!);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Bagian Detail Pembayaran dan Tombol
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Payment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp ${totalAmount.toStringAsFixed(0)}', // Format harga
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  BlocBuilder<PaymentMethodCubit, String>(
                    builder: (context, selectedMethod) {
                      return ElevatedButton(
                        onPressed: selectedMethod.isEmpty
                            ? null
                            : () {
                                // Memperbarui metode pembayaran di dalam OrderCubit
                                context
                                    .read<OrderCubit>()
                                    .updatePaymentMethod(selectedMethod);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const OrderPlacedPage(); // Navigasi ke halaman OrderPlaced
                                }));
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedMethod.isEmpty
                              ? const Color(
                                  0xFFE0E0E0) // Warna saat tombol nonaktif
                              : Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 32),
                        ),
                        child: const Text(
                          'Continue Payment',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
