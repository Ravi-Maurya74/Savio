import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LoadingAnimationWidget.flickr(
          leftDotColor: const Color(0xFFd988a1).withOpacity(0.8),
          rightDotColor: const Color(0xFF50559a).withOpacity(0.8),
          size: 100),
    );
  }
}
