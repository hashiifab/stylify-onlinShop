import 'package:flutter/material.dart';
import 'package:online_shop/common/helper/cart/cart.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/common/widgets/button/basic_app_button.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/presentation/cart/pages/checkout.dart';
import '../../../domain/order/entities/product_ordered.dart';

class Checkout extends StatelessWidget {
  final List<ProductOrderedEntity> products;
  const Checkout({required this.products, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subtotal Row
          _buildRow('Subtotal', '\$${CartHelper.calculateCartSubtotal(products).toString()}'),
          
          // Shipping Cost Row
          _buildRow('Shipping Cost', '\$8'),
          
          // Tax Row
          _buildRow('Tax', '\$0.0'),
          
          // Total Row
          _buildRow(
            'Total',
            '\$${CartHelper.calculateCartSubtotal(products) + 8}',
            isTotal: true, // Highlight the total row
          ),
          
          // Checkout Button
          BasicAppButton(
            onPressed: () {
              AppNavigator.push(
                context,
                CheckOutPage(
                  products: products,
                ),
              );
            },
            title: 'Proceed to Checkout',
            
          ),
        ],
      ),
    );
  }

  // Helper method to build individual rows (like Subtotal, Shipping, etc.)
  Widget _buildRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color.fromARGB(255, 167, 167, 167),
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
              fontSize: 16,
              color: isTotal ? const Color.fromARGB(255, 196, 175, 255) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
