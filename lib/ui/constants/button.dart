import 'package:fridafit/ui/constants/colors.dart';
import 'package:fridafit/ui/constants/text.dart';
import 'package:flutter/material.dart';

class KButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;
  final Color? color;
  final Color? textColor;
  final bool withPrice;
  final int? price;

  const KButton({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
    this.color,
    this.textColor,
    this.price,
    this.disabled = false,
    this.busy = false,
    this.withPrice = false,
  }) : outline = false;

  const KButton.outline({
    super.key,
    required this.title,
    this.onTap,
    this.leading,
    this.color,
    this.textColor,
    this.price,
    this.disabled = false,
    this.withPrice = false,
  })  : busy = false,
        outline = true;

  get kcPrimaryColor => kPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !(disabled) ? onTap : () {},
      splashColor: Colors.white,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 60,
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: !disabled ? color ?? kcPrimaryColor : kDisabledColor,
                borderRadius: BorderRadius.circular(9),
                gradient: color == null
                    ? const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromARGB(255, 110, 185, 194),
                          kSecondaryColor,
                          Color.fromARGB(255, 124, 202, 211),
                          Color.fromARGB(255, 154, 210, 218),
                        ],
                      )
                    : null,
              )
            : BoxDecoration(
                color: color ?? Colors.transparent,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color:
                      disabled ? kDisabledColor : textColor ?? kcPrimaryColor,
                  width: 1,
                ),
              ),
        child: !busy
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  mainAxisAlignment: withPrice
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    if (leading != null) leading!,
                    if (leading != null) const SizedBox(width: 8),
                    KText.boldBodyText(
                      title,
                      textColor: !outline
                          ? textColor ?? Colors.white
                          : disabled
                              ? kDisabledColor
                              : textColor ?? kcPrimaryColor,
                    )
                  ],
                ),
              )
            : const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
