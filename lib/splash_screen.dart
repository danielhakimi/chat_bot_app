import 'package:chat_bot_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.sizeOf(context).height, color: Colors.white, child: Assets.explodingHeart.lottie());
  }
}
