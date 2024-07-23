import 'package:english/core/styles/colors.dart';
import 'package:english/core/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardWordWidget extends StatefulWidget{
  final String englishText;
  final String arabicText;

  const CardWordWidget({
    super.key,
    required this.englishText,
    required this.arabicText
  });
  @override
  State<CardWordWidget> createState() => _CardWordWidgetState();
}

class _CardWordWidgetState extends State<CardWordWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DefaultText(
            text: widget.englishText,
            themeStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.blackColor
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: DefaultText(
              text: widget.arabicText,
              themeStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: AppColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}