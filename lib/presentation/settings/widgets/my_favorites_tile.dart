import 'package:flutter/material.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/presentation/settings/pages/my_favorites.dart';
// Gantilah dengan halaman favorit pengguna

class MyFavoritesTile extends StatelessWidget {
  const MyFavoritesTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman favorit pengguna
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyFavoritesPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Favorites',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
