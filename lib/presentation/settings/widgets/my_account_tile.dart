import 'package:flutter/material.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/presentation/settings/pages/my_account_page.dart';
// Gantilah dengan halaman pengaturan akun

class AccountSettingsTile extends StatelessWidget {
  const AccountSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman pengaturan akun
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountSettingsPage()),
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
              'My Account',
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
