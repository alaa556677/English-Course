import 'package:english/core/widgets/default_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/image_path.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, this.label});
  final String? label;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: TweenAnimationBuilder(
        curve: Curves.bounceOut,
        duration: const Duration(seconds: 2),
        tween: Tween<double>(begin: 12.0, end: 30.0),
        builder: (BuildContext context, double? value, Widget? child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultText(
                text: label!,
                themeStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              SvgPicture.asset(ImagesPath.empty, width: 200),
            ],
          );
        },
      ),

    );
  }
}
