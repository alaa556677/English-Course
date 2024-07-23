import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class SearchTextForm extends StatelessWidget{
  final TextEditingController searchController;
  final double radius;
  final Color borderColor;
  final Function(String)? onChanged;

  const SearchTextForm({super.key,
    required this.searchController,
    this.radius = 10,
    this.borderColor = Colors.transparent,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: AppColors.whiteColor,
          border: Border.all(color: borderColor)
      ),
      child: TextFormField(
        controller: searchController,
        style: TextStyle(
          color: AppColors.blackColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w300,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Padding(
            padding: EdgeInsetsDirectional.only(start: 20.w),
            child: const Icon(Icons.search),
          ),
          // prefixIcon: Icon(Icons.search, color: AppColors.textFormBorderColor),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: AppColors.greyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}