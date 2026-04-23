import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/image_path.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, this.label});
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            curve: Curves.elasticOut,
            duration: const Duration(milliseconds: 900),
            tween: Tween(begin: 0.6, end: 1.0),
            builder: (_, value, child) =>
                Transform.scale(scale: value, child: child),
            child: SvgPicture.asset(ImagesPath.empty, width: 160),
          ),
          const SizedBox(height: 20),
          Text(
            label ?? 'No Data Found',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.65),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tap + to add something new',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
