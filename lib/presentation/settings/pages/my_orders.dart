import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/presentation/settings/bloc/orders_display_cubit.dart';
import 'package:online_shop/presentation/settings/pages/order_detail.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/order/entities/order.dart';
import '../bloc/orders_display_state.dart';
// Import for using SVGs for illustration

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('My Orders'),
      ),
      body: BlocProvider(
        create: (context) => OrdersDisplayCubit()..displayOrders(),
        child: BlocBuilder<OrdersDisplayCubit, OrdersDisplayState>(
          builder: (context, state) {
            if (state is OrdersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is OrdersLoaded) {
              return _orders(state.orders);
            }
            if (state is LoadOrdersFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _orders(List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return _emptyState();
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            AppNavigator.push(
              context,
              OrderDetailPage(
                orderEntity: orders[index],
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_rounded, color: AppColors.primary),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order #${orders[index].code}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${orders[index].products.length} item${orders[index].products.length > 1 ? 's' : ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey)
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: orders.length,
    );
  }

  Widget _emptyState() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_order.png', // Use Image.asset for PNG images
            width: 200,
            height: 200,
            fit: BoxFit.cover, // Adjust fit if needed
          ),
          const SizedBox(height: 24),
          const Text(
            "You don't have any orders yet.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Once you place an order, it will show up here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

}
