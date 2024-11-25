import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/common/widgets/button/basic_app_button.dart';
import 'package:online_shop/data/auth/models/user_signin_req.dart';
import 'package:online_shop/presentation/auth/pages/enter_password.dart';
import 'package:online_shop/presentation/auth/pages/signup.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(hideBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _signinHeader(),
            const SizedBox(height: 32),
            _emailInputField(),
            const SizedBox(height: 24),
            _continueButton(context),
            const SizedBox(height: 32),
            _divider(),
            const SizedBox(height: 24),
            _createAccountSection(context),
          ],
        ),
      ),
    );
  }

  // Header untuk halaman Sign In
  Widget _signinHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Please sign in to your account',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Input Field untuk email
  Widget _emailInputField() {
    return TextField(
      controller: _emailCon,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  // Tombol untuk melanjutkan proses Sign In
  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        if (_emailCon.text.isNotEmpty) {
          AppNavigator.push(
            context,
            EnterPasswordPage(
              signinReq: UserSigninReq(email: _emailCon.text),
            ),
          );
        } else {
          // Tampilkan pesan error jika email kosong
         ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Row(
      children: [
        Icon(Icons.email, color: Colors.white), // Menambahkan ikon email
        SizedBox(width: 10),
        Text(
          'Please enter your email address.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold, // Menambah ketebalan font untuk penekanan
          ),
        ),
      ],
    ),
    backgroundColor: Colors.red, // Warna latar belakang merah untuk error
    behavior: SnackBarBehavior.floating, // SnackBar melayang di atas UI
    shape: RoundedRectangleBorder( // Memberikan sudut rounded pada SnackBar
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Memberikan margin
    duration: Duration(seconds: 3), // Durasi tampilan SnackBar
  ),
);

        }
      },
      title: 'Sign In',
    );
  }

  // Pembatas visual untuk memisahkan konten
  Widget _divider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            height: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            height: 1,
          ),
        ),
      ],
    );
  }

  // Bagian untuk menawarkan pendaftaran akun baru
  Widget _createAccountSection(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Don't have an account ? ",
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: 'Sign Up',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.push(context, SignupPage());
                },
            ),
          ],
        ),
      ),
    );
  }
}
