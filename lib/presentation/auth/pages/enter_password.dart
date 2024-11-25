import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/button/button_state_cubit.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/common/widgets/button/basic_reactive_button.dart';
import 'package:online_shop/data/auth/models/user_signin_req.dart';
import 'package:online_shop/domain/auth/usecases/signin.dart';
import 'package:online_shop/presentation/auth/pages/forgot_password.dart';
import 'package:online_shop/presentation/home/pages/home.dart';

import '../../../common/bloc/button/button_state.dart';

class EnterPasswordPage extends StatelessWidget {
  final UserSigninReq signinReq;
  EnterPasswordPage({required this.signinReq, super.key});

  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: BlocProvider(
          create: (context) => ButtonStateCubit(),
          child: BlocListener<ButtonStateCubit, ButtonState>(
            listener: (context, state) {
              if (state is ButtonFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errorMessage,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }

              if (state is ButtonSuccessState) {
                AppNavigator.pushAndRemove(context, const HomePage());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _signinHeader(),
                const SizedBox(height: 40),
                _passwordInputField(),
                const SizedBox(height: 32),
                _continueButton(context),
                const SizedBox(height: 24),
                _forgotPasswordLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signinHeader() {
    return const Text(
      'Sign in',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }

  Widget _passwordInputField() {
    return TextField(
      controller: _passwordCon,
      obscureText: true, // Untuk keamanan
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.lock),
      ),
      keyboardType: TextInputType.visiblePassword,
    );
  }

  Widget _continueButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicReactiveButton(
        onPressed: () {
          if (_passwordCon.text.isNotEmpty) {
            signinReq.password = _passwordCon.text;
            context.read<ButtonStateCubit>().execute(
                  usecase: SigninUseCase(),
                  params: signinReq,
                );
          } else {
           ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(
    content: Row(
      children: [
        Icon(Icons.lock, color: Colors.white), // Menambahkan ikon kunci untuk menunjukkan masalah password
        SizedBox(width: 10),
        Text(
          'Password cannot be empty.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold, // Menebalkan font untuk penekanan
          ),
        ),
      ],
    ),
    backgroundColor: Colors.red, // Warna latar belakang oranye untuk peringatan
    behavior: SnackBarBehavior.floating, // SnackBar melayang di atas UI
    shape: RoundedRectangleBorder( // Menambahkan sudut rounded pada SnackBar
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Memberikan margin di sekitar SnackBar
    duration: Duration(seconds: 3), // Durasi tampilan SnackBar
  ),
);

          }
        },
        title: 'Continue',
      );
    });
  }

  Widget _forgotPasswordLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "Forgot password ? ",
            style: TextStyle(color: Colors.white),
          ),
          TextSpan(
            text: 'Reset',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppNavigator.push(context, ForgotPasswordPage());
              },
          ),
        ],
      ),
    );
  }
}
