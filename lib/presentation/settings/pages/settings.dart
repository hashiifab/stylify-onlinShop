import 'package:flutter/material.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/presentation/settings/widgets/my_account_tile.dart';
import 'package:online_shop/presentation/settings/widgets/my_favorites_tile.dart';
import 'package:online_shop/presentation/settings/widgets/my_notification_tile.dart';
import 'package:online_shop/presentation/settings/widgets/my_orders_tile.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _sectionTitle('Account Settings'),
            const AccountSettingsTile(),
            const SizedBox(height: 15),
            _sectionTitle('My Orders'),
            const MyOrdersTile(),
            const SizedBox(height: 15),
            _sectionTitle('My Favorites'),
            const MyFavoritesTile(),
            const SizedBox(height: 15),
            _sectionTitle('Notifications'),
            const NotificationsTile(),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 222, 210, 255),
        ),
      ),
    );
  }
}
