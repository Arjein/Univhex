import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnivhexProgressIndicator extends StatelessWidget {
  const UnivhexProgressIndicator({super.key, required this.isHorizontal});
  final bool isHorizontal;
  @override
  Widget build(BuildContext context) {
    return isHorizontal
        ? Transform.rotate(
            angle: 3 *
                pi /
                2, // Rotate 90 degrees. Dart uses radians, not degrees, hence we use pi/2.
            child: Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_YKljgC7Siv.json'),
          )
        : Lottie.network(
            'https://assets3.lottiefiles.com/packages/lf20_YKljgC7Siv.json');
  }
}
