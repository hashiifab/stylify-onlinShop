import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_shop/common/helper/navigator/app_navigator.dart';
import 'package:online_shop/core/configs/assets/app_vectors.dart';
import 'package:online_shop/core/configs/theme/app_colors.dart';
import 'package:online_shop/presentation/search/pages/search.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        readOnly: true, // The field is read-only, opens search page on tap
        onTap: () {
          AppNavigator.push(context, const SearchPage());
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: AppColors.primary.withOpacity(0.6), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.4), width: 1),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 8.0), // Center icon
            child: SvgPicture.asset(
              AppVectors.search,
              color: const Color.fromARGB(255, 188, 188, 188), // Subtle color for the search icon
              fit: BoxFit.none,
            ),
          ),
          hintText: 'Search',
          hintStyle: const TextStyle(color: Color.fromARGB(255, 171, 171, 171)), // Lighter hint color
          border: InputBorder.none, // Remove unnecessary borders to keep it clean
        ),
      ),
    );
  }
}
