import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/button/button_state_cubit.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/common/widgets/appbar/app_bar.dart';
import 'package:online_shop/common/widgets/button/basic_reactive_button.dart';
import 'package:online_shop/domain/auth/usecases/send_password_reset_email.dart';
import 'package:online_shop/presentation/auth/pages/password_reset_email.dart';

import '../../../common/bloc/button/button_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController _emailCon = TextEditingController();

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
                _showSnackBar(
                  context,
                  message: state.errorMessage,
                  isError: true,
                );
              }

              if (state is ButtonSuccessState) {
                AppNavigator.push(context, const PasswordResetEmailPage());
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _forgotPasswordHeader(),
                const SizedBox(height: 40),
                _emailInputField(),
                const SizedBox(height: 32),
                _continueButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _forgotPasswordHeader() {
    return const Text(
      'Forgot Password',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        height: 1.2,
      ),
    );
  }

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

  Widget _continueButton(BuildContext context) {
    return Builder(
      builder: (context) {
        return BasicReactiveButton(
          onPressed: () {
            if (_emailCon.text.isNotEmpty) {
              context.read<ButtonStateCubit>().execute(
                    usecase: SendPasswordResetEmailUseCase(),
                    params: _emailCon.text,
                  );
            } else {
              _showSnackBar(
                context,
                message: 'Email cannot be empty.',
                isError: true,
              );
            }
          },
          title: 'Continue',
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, {required String message, bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline, // Menambahkan ikon error atau success
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600, // Menebalkan font agar lebih menonjol
            ),
          ),
        ],
      ),
      backgroundColor: isError ? Colors.redAccent : Colors.green, // Warna latar belakang berdasarkan tipe pesan
      behavior: SnackBarBehavior.floating, // SnackBar melayang di atas UI
      shape: const RoundedRectangleBorder( // Sudut yang lebih melengkung
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Memberikan ruang di sekitar SnackBar
      duration: const Duration(seconds: 3), // Durasi tampilan SnackBar
    ),
  );
}

}
