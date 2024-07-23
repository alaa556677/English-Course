import 'package:flutter/material.dart';

class DefaultText extends StatelessWidget {
  String? text;
  TextAlign align;
  TextOverflow overFlow;
  int? maxLines;
  TextStyle? themeStyle;

  DefaultText({super.key,
    this.text,
    this.align = TextAlign.start,
    this.overFlow = TextOverflow.clip,
    this.maxLines,
    this.themeStyle,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: align,
        maxLines: maxLines,
        overflow: overFlow,
        text:TextSpan(
          children: [
            TextSpan(
              text: text,
              style: themeStyle,
            ),
          ],
        )
    );
  }
}
