import 'package:fridafit/ui/constants/colors.dart';
import 'package:flutter/material.dart';

BoxShadow kBoxShadow = BoxShadow(
  color: kTextColor.withOpacity(.1),
  spreadRadius: 1,
  blurRadius: 4,
  offset: const Offset(0, 3),
);

BoxShadow kBoxShadow2 = BoxShadow(
  color: kTextColor.withOpacity(.06),
  spreadRadius: 2,
  blurRadius: 4,
  offset: const Offset(0, 3),
);

BoxDecoration kBoxDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [kBoxShadow],
  borderRadius: BorderRadius.circular(10),
);

const EdgeInsets kPaddingHorizontal = EdgeInsets.symmetric(horizontal: 20.0);
const EdgeInsets kBiggerPaddingHorizontal =
    EdgeInsets.symmetric(horizontal: 26.0);
