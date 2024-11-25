import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/domain/product/entities/product.dart';
import 'package:online_shop/presentation/product_detail/bloc/favorite_icon_cubit.dart';
import '../../../core/configs/theme/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final ProductEntity productEntity;

  const FavoriteButton({required this.productEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Ketika tombol favorit ditekan, panggil onTap untuk menambah/menghapus favorit
        context.read<FavoriteIconCubit>().onTap(productEntity);
      },
      icon: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: AppColors.secondBackground, // Background color
          shape: BoxShape.circle, // Bentuk bulat
        ),
        child: BlocBuilder<FavoriteIconCubit, bool>(
          builder: (context, isFavorite) {
            return Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 24,
              color: const Color.fromARGB(255, 191, 168, 255),
            );
          },
        ),
      ),
    );
  }
}
