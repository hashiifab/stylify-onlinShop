import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/common/bloc/button/button_state.dart';
import 'package:online_shop/common/bloc/button/button_state_cubit.dart';
import 'package:online_shop/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/data/auth/models/user_creation_req.dart';
import 'package:online_shop/domain/auth/usecases/siginup.dart';
import 'package:online_shop/presentation/auth/bloc/age_selection_cubit.dart';
import 'package:online_shop/presentation/auth/bloc/ages_display_cubit.dart';
import 'package:online_shop/presentation/auth/bloc/gender_selection_cubit.dart';
import 'package:online_shop/presentation/auth/widgets/ages.dart';
import 'package:online_shop/presentation/home/pages/home.dart';

import '../../../common/helper/navigator/app_navigator.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/button/basic_reactive_button.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
  final UserCreationReq userCreationReq;
  const GenderAndAgeSelectionPage({required this.userCreationReq, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GenderSelectionCubit()),
          BlocProvider(create: (context) => AgeSelectionCubit()),
          BlocProvider(create: (context) => AgesDisplayCubit()),
          BlocProvider(create: (context) => ButtonStateCubit())
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              var snackbar = SnackBar(
                content: Text(state.errorMessage),
                behavior: SnackBarBehavior.floating,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tellUs(),
                    const SizedBox(
                      height: 30,
                    ),
                    _genders(context),
                    const SizedBox(
                      height: 30,
                    ),
                    howOld(),
                    const SizedBox(
                      height: 30,
                    ),
                    _age(),
                  ],
                ),
              ),
              const Spacer(),
              _finishButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _tellUs() {
    return const Text(
      'Tell us about yourself',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }

  Widget _genders(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit, int>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          genderTile(context, 1, 'Men', Icons.male),
          const SizedBox(
            width: 20,
          ),
          genderTile(context, 2, 'Women', Icons.female),
        ],
      );
    });
  }

  Expanded genderTile(BuildContext context, int genderIndex, String gender, IconData icon) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<GenderSelectionCubit>().selectGender(genderIndex);
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: context.read<GenderSelectionCubit>().selectedIndex ==
                      genderIndex
                  ? AppColors.primary
                  : AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: context.read<GenderSelectionCubit>().selectedIndex == genderIndex ? Colors.white : AppColors.primary),
              const SizedBox(width: 8),
              Text(
                gender,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: context.read<GenderSelectionCubit>().selectedIndex == genderIndex ? Colors.white : Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget howOld() {
    return const Text(
      'How old are you?',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Widget _age() {
    return BlocBuilder<AgeSelectionCubit, String>(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          AppBottomsheet.display(
              context,
              MultiBlocProvider(providers: [
                BlocProvider.value(
                  value: context.read<AgeSelectionCubit>(),
                ),
                BlocProvider.value(
                    value: context.read<AgesDisplayCubit>()..displayAges())
              ], child: const Ages()));
        },
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              color: AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(state),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
      );
    });
  }

  Widget _finishButton(BuildContext context) {
  return Container(
    height: 100,
    color: AppColors.secondBackground,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Center(
      child: Builder(builder: (context) {
        return BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }

            if (state is ButtonSuccessState) {
              // Navigasi ke halaman Home jika signup berhasil
              AppNavigator.pushReplacement(context, const HomePage());
            }
          },
          child: BasicReactiveButton(
            onPressed: () {
              // Validasi gender dan usia sudah dipilih
              if (context.read<GenderSelectionCubit>().selectedIndex == 0) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Row(
        children: [
          Icon(Icons.error, color: Colors.white), // Menambahkan icon error
          SizedBox(width: 10),
          Text(
            'Please select your gender',
            style: TextStyle(fontWeight: FontWeight.bold), // Menambah ketebalan font
          ),
        ],
      ),
      backgroundColor: Colors.redAccent, // Warna latar belakang merah untuk error
      behavior: SnackBarBehavior.floating, // SnackBar melayang di atas UI
      margin: EdgeInsets.all(16), // Memberikan margin di sekitar SnackBar
      shape: RoundedRectangleBorder( // Memberikan sudut rounded
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
  return;
}

if (context.read<AgeSelectionCubit>().selectedAge.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Row(
        children: [
          Icon(Icons.error, color: Colors.white), // Menambahkan icon error
          SizedBox(width: 10),
          Text(
            'Please select your age',
            style: TextStyle(fontWeight: FontWeight.bold), // Menambah ketebalan font
          ),
        ],
      ),
      backgroundColor: Colors.redAccent, // Warna latar belakang merah untuk error
      behavior: SnackBarBehavior.floating, // SnackBar melayang di atas UI
      margin: EdgeInsets.all(16), // Memberikan margin di sekitar SnackBar
      shape: RoundedRectangleBorder( // Memberikan sudut rounded
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );
  return;
}


              // Mengassign gender dan age ke userCreationReq
              userCreationReq.gender =
                  context.read<GenderSelectionCubit>().selectedIndex;
              userCreationReq.age =
                  context.read<AgeSelectionCubit>().selectedAge;

              // Eksekusi use case untuk signup
              context.read<ButtonStateCubit>().execute(
                usecase: SignupUseCase(),
                params: userCreationReq,
              );
            },
            title: 'Finish',
          ),
        );
      }),
    ),
  );
}

}
