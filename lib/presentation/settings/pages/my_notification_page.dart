import 'package:flutter/material.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';

class NotificationsSettingsPage extends StatefulWidget {
  const NotificationsSettingsPage({super.key});

  @override
  _NotificationsSettingsPageState createState() =>
      _NotificationsSettingsPageState();
}

class _NotificationsSettingsPageState extends State<NotificationsSettingsPage> {
  bool _isEmailNotificationsEnabled = true;
  bool _isPushNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text('Notifications Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmailNotificationsSection(),
            const SizedBox(height: 20),
            _buildPushNotificationsSection(),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Simulate saving notification settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Notifications Updated')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16), // Padding for better height
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, 
                    color: Colors.white// Text size adjustment
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailNotificationsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Email Notifications', style: TextStyle(fontSize: 16)),
        Switch(
          value: _isEmailNotificationsEnabled,
          onChanged: (value) {
            setState(() {
              _isEmailNotificationsEnabled = value;
            });
          },
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  Widget _buildPushNotificationsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Push Notifications', style: TextStyle(fontSize: 16)),
        Switch(
          value: _isPushNotificationsEnabled,
          onChanged: (value) {
            setState(() {
              _isPushNotificationsEnabled = value;
            });
          },
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}
