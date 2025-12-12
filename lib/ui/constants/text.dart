import 'package:flutter/material.dart';
import 'package:fridafit/ui/constants/fonts.dart'; // Point to your fonts.dart
// import 'package:fridafit/ui/constants/colors.dart'; // If you need custom colors

class KText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle style;
  final TextAlign alignment;
  final int? maxLines;
  final TextOverflow? textOverflow;

  // 1) Heading 1
  KText.headingOne(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = heading1Style,
        color = textColor,
        alignment = align;

  // 2) Heading 2
  KText.headingTwo(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = heading2Style,
        color = textColor,
        alignment = align;

  // 3) Heading 3
  KText.headingThree(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = heading3Style,
        color = textColor,
        alignment = align;

  // 4) Heading 4
  KText.headingFour(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = heading4Style,
        color = textColor,
        alignment = align;

  // 5) Body text
  KText.bodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = bodyTextStyle,
        color = textColor,
        alignment = align;

  // 6) Bold body text
  KText.boldBodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = boldBodyTextStyle,
        color = textColor,
        alignment = align;

  // 7) Thin body text
  KText.thinBodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = thinBodyTextStyle,
        color = textColor,
        alignment = align;

  // 8) Small body text
  KText.smallBodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    // Example default color if you want
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = smallBodyTextStyle,
        color = textColor,
        alignment = align;

  // 9) Small thin body text
  KText.smallThinBodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = smallThinBodyTextStyle,
        color = textColor,
        alignment = align;

  // 10) Small bold body text
  KText.smallBoldBodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = smallBoldBodyTextStyle,
        color = textColor,
        alignment = align;

  // 11) Smaller body text
  KText.smallerBodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = smallerBodyTextStyle,
        color = textColor,
        alignment = align;

  // 12) Smaller bold body text
  KText.smallerBoldBodyText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = smallerBoldBodyTextStyle,
        color = textColor,
        alignment = align;

  // 13) Help text
  KText.helpText(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    // Example default color
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = helpTextStyle,
        color = textColor,
        alignment = align;

  // 14) Navbar text
  KText.navbar(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = navbarStyle,
        color = textColor,
        alignment = align;

  // 15) Navbar bold
  KText.navbarBold(
    this.text, {
    super.key,
    TextAlign align = TextAlign.start,
    Color textColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  })  : style = navbarBoldStyle,
        color = textColor,
        alignment = align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: color),
      textAlign: alignment,
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
