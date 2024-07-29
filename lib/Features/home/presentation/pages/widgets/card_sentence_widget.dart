import 'package:english/core/styles/colors.dart';
import 'package:english/core/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardSentenceWidget extends StatefulWidget{
  final String englishText;
  final String arabicText;

  const CardSentenceWidget({
    super.key,
    required this.englishText,
    required this.arabicText
  });
  @override
  State<CardSentenceWidget> createState() => _CardSentenceWidgetState();
}

class _CardSentenceWidgetState extends State<CardSentenceWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            text: widget.englishText,
            themeStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 6.h,),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              children: [
                Expanded(
                  child: DefaultText(
                    text: widget.arabicText,
                    themeStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}