import 'package:flutter/material.dart';
import 'package:fridafit/ui/constants/colors.dart';
import 'package:fridafit/ui/constants/decoration.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: kContainerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [kBoxShadow2],
      ),
      child: child,
    );
  }
}
