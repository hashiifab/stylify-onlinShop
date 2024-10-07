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
      ),
      body: BlocProvider(
        create: (context) => OrderCubit(), // Sediakan OrderCubit di sini
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
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        method,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
        // Bagian Detail Total Pembayaran
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 0,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Pembayaran
              Text(
                'Total Payment',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp ${totalAmount.toStringAsFixed(0)}', // Format harga
                    style: const TextStyle(
                      fontSize: 20,
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
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                        ),
                        child: const Text(
                          'Continue Payment',
                          style: TextStyle(fontSize: 16),
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
