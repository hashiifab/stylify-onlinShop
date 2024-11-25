import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/common/widgets/button/basic_app_button.dart';
import 'package:online_shop/data/auth/models/user_creation_req.dart';
import 'package:online_shop/presentation/auth/pages/gender_and_age_selection.dart';
import 'package:online_shop/presentation/auth/pages/siginin.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _firstNameCon = TextEditingController();
  final TextEditingController _lastNameCon = TextEditingController();
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerText(),
            const SizedBox(height: 32),
            _firstNameField(),
            const SizedBox(height: 20),
            _lastNameField(),
            const SizedBox(height: 20),
            _emailField(),
            const SizedBox(height: 20),
            _passwordField(),
            const SizedBox(height: 32),
            _continueButton(context),
            const SizedBox(height: 24),
            _divider(),
            const SizedBox(height: 24),
            _signinLink(context),
          ],
        ),
      ),
    );
  }

  // Header untuk halaman Signup
  Widget _headerText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Create Your Account',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Fill in your details to get started',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Input Field untuk nama depan
  // Input Field untuk nama depan dengan ikon
  Widget _firstNameField() {
    return TextField(
      controller: _firstNameCon,
      decoration: InputDecoration(
        labelText: 'First Name',
        hintText: 'Enter your first name',
        prefixIcon: const Icon(Icons.person), // Ikon untuk nama depan
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

// Input Field untuk nama belakang dengan ikon
  Widget _lastNameField() {
    return TextField(
      controller: _lastNameCon,
      decoration: InputDecoration(
        labelText: 'Last Name',
        hintText: 'Enter your last name',
        prefixIcon: const Icon(Icons.person_outline), // Ikon untuk nama belakang
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

// Input Field untuk email dengan ikon
  Widget _emailField() {
    return TextField(
      controller: _emailCon,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your email',
        prefixIcon: const Icon(Icons.email), // Ikon untuk email
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

// Input Field untuk password dengan ikon
  Widget _passwordField() {
    return TextField(
      controller: _passwordCon,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter a secure password',
        prefixIcon: const Icon(Icons.lock), // Ikon untuk password
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      obscureText: true,
    );
  }

  // Tombol untuk melanjutkan proses Signup
  Widget _continueButton(BuildContext context) {
    return BasicAppButton(
      onPressed: () {
        if (_firstNameCon.text.isEmpty ||
            _lastNameCon.text.isEmpty ||
            _emailCon.text.isEmpty ||
            _passwordCon.text.isEmpty) {
         ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Row(
      children: [
        Icon(Icons.warning, color: Colors.white), // Menambahkan ikon peringatan
        SizedBox(width: 10),
        Text(
          'Please complete all fields before continuing.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold, // Menambah ketebalan font untuk penekanan
          ),
        ),
      ],
    ),
    backgroundColor: Colors.redAccent, // Warna latar belakang merah untuk peringatan
    behavior: SnackBarBehavior.floating, // SnackBar melayang di atas UI
    shape: RoundedRectangleBorder( // Memberikan sudut rounded pada SnackBar
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Memberikan margin
    duration: Duration(seconds: 3), // Durasi tampilan SnackBar
  ),
);


          return;
        }
        AppNavigator.push(
          context,
          GenderAndAgeSelectionPage(
            userCreationReq: UserCreationReq(
              firstName: _firstNameCon.text,
              lastName: _lastNameCon.text,
              email: _emailCon.text,
              password: _passwordCon.text,
            ),
          ),
        );
      },
      title: 'Sign Up',
    );
  }

  // Pembatas visual
  Widget _divider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
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
          ),
        ),
      ],
    );
  }

  // Tautan untuk Sign In
  Widget _signinLink(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: 'Already have an account ? ',
              style: TextStyle(color: Colors.grey),
            ),
            TextSpan(
              text: 'Sign In',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppNavigator.pushReplacement(context, SigninPage());
                },
            ),
          ],
        ),
      ),
    );
  }
}
