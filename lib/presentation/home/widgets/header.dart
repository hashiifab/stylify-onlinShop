import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/core/configs/assets/app_images.dart';
import 'package:online_shop/core/configs/assets/app_vectors.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/domain/auth/entity/user.dart';
import 'package:online_shop/presentation/cart/pages/cart.dart';
import 'package:online_shop/presentation/home/bloc/user_info_display_cubit.dart';
import 'package:online_shop/presentation/settings/pages/settings.dart';

import '../bloc/user_info_display_state.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserInfoDisplayCubit()..displayUserInfo(),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 16, left: 16),
        child: BlocBuilder<UserInfoDisplayCubit, UserInfoDisplayState>(
          builder: (context, state) {
            if (state is UserInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is UserInfoLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _profileImage(state.user, context),
                  _gender(state.user),
                  _cart(context),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _profileImage(UserEntity user, BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(context, const SettingsPage());
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: user.image.isEmpty
                    ? const AssetImage(AppImages.profile)
                    : NetworkImage(user.image) as ImageProvider,
                fit: BoxFit.cover),
            color: Colors.red,
            shape: BoxShape.circle),
      ),
    );
  }

  Widget _gender(UserEntity user) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            user.gender == 1 ? Icons.male : Icons.female,
            color: AppColors.primary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            user.gender == 1 ? 'Men' : 'Women',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _cart(BuildContext context) {
    return GestureDetector(
        onTap: () {
          AppNavigator.push(context, const CartPage());
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 50,
          width: 50,
          child: const Icon(Icons.shopping_bag_outlined, color: Color.fromARGB(255, 196, 175, 255), size: 30,),
        )
        // child: AnimatedContainer(
        //   duration: const Duration(milliseconds: 300),
        //   height: 50,
        //   width: 50,
        //   decoration: BoxDecoration(
        //     color: AppColors.primary,
        //     shape: BoxShape.circle,
        //   ),
        //   child: Center(
        //     child: SvgPicture.asset(
        //       AppVectors.bag,
        //       fit: BoxFit.none,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        );
  }
}
