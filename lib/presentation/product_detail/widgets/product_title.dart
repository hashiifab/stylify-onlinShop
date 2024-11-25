import 'package:flutter/material.dart';
import '../../../domain/product/entities/product.dart';

class ProductTitle extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductTitle({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with larger font size and emphasis
          Text(
            productEntity.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22, // Larger font for better readability
              color: Colors.white, // High contrast for readability
              letterSpacing: 0.5, // Slightly spaced out for better legibility
            ),
            overflow: TextOverflow.ellipsis, // Prevent text overflow
            maxLines: 2, // Ensure title doesn't overflow
          ),
          const SizedBox(height: 8),
          // Optional: Subtitle or extra detail, if needed (e.g., brand or category)
        ],
      ),
    );
  }
}
