import 'package:flutter/material.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/presentation/auth/pages/siginin.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: const Text('Account Settings'),
        action: IconButton(onPressed: () {_signOut(context);}, icon:const Icon(Icons.exit_to_app, size: 30,)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Profile Section
            _buildProfileSection(),
            const SizedBox(height: 24),
            
            // Email Section
            _buildEmailSection(),
            const SizedBox(height: 24),

            // Password Section
            _buildPasswordSection(),
            const SizedBox(height: 32),

            // Save Changes Button
            ElevatedButton(
              onPressed: () {
                // Simulate saving changes or other actions
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account Updated Successfully')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Changes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),

            
           
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Profile Picture', style: TextStyle(fontSize: 16)),
        GestureDetector(
          onTap: () {
            // Implement profile picture change functionality
          },
          child: const CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.camera_alt, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Email', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: 'q@email.com', // Placeholder or user profile data
          decoration: const InputDecoration(
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Enter new password',
            prefixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          ),
        ),
      ],
    );
  }

  void _signOut(BuildContext context) {
    // Clear user session or any saved data here (for example, you can clear a user object or token if stored in memory)
    // Since you're not using a dependency like SharedPreferences, we'll just assume a manual session management

    // Show a snack bar message indicating the user has signed out
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('You have signed out')),
    );

    // Navigate to the SigninPage using Navigator.pushReplacement
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  SigninPage()),
    );
  }
}
