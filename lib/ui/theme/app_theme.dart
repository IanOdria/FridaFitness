// lib/ui/theme/app_theme.dart
import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF1F51FF);

/// Optional brand extras you can read anywhere via:
/// final brand = Theme.of(context).extension<TechBrand>()!;
@immutable
class TechBrand extends ThemeExtension<TechBrand> {
  final Gradient heroGradient;
  final List<BoxShadow> glowShadow;

  const TechBrand({
    required this.heroGradient,
    required this.glowShadow,
  });

  @override
  TechBrand copyWith({Gradient? heroGradient, List<BoxShadow>? glowShadow}) {
    return TechBrand(
      heroGradient: heroGradient ?? this.heroGradient,
      glowShadow: glowShadow ?? this.glowShadow,
    );
  }

  @override
  ThemeExtension<TechBrand> lerp(ThemeExtension<TechBrand>? other, double t) {
    if (other is! TechBrand) return this;
    return TechBrand(
      heroGradient: LinearGradient.lerp(
            heroGradient as LinearGradient,
            other.heroGradient as LinearGradient,
            t,
          ) ??
          heroGradient,
      glowShadow: glowShadow,
    );
  }
}

ThemeData _baseTheme(ColorScheme scheme) {
  final radius = 16.0;

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    // Typography: crisp, slightly tighter
    textTheme: Typography.blackCupertino
        .apply(
          bodyColor: scheme.onSurface,
          displayColor: scheme.onSurface,
        )
        .copyWith(
          titleLarge:
              const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .2),
          titleMedium:
              const TextStyle(fontWeight: FontWeight.w700, letterSpacing: .2),
          labelLarge:
              const TextStyle(fontWeight: FontWeight.w700, letterSpacing: .3),
        ),
    scaffoldBackgroundColor: scheme.surface, // clean base
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: scheme.surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: scheme.onSurface,
      centerTitle: true,
      titleTextStyle:
          const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surface,
      surfaceTintColor: Colors.transparent,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      margin: EdgeInsets.zero,
    ),
    dividerTheme: DividerThemeData(
      color: scheme.outlineVariant,
      thickness: 1,
      space: 1,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      iconColor: scheme.onSurfaceVariant,
      textColor: scheme.onSurface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    chipTheme: ChipThemeData(
      shape: const StadiumBorder(),
      labelStyle: TextStyle(
        color: scheme.onSurfaceVariant,
        fontWeight: FontWeight.w700,
        letterSpacing: .2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      side: BorderSide(color: scheme.outlineVariant),
      backgroundColor: scheme.surfaceContainerHighest,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: scheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: scheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: scheme.primary, width: 2),
      ),
      hintStyle: TextStyle(color: scheme.onSurfaceVariant),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: scheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        textStyle:
            const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .3),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        elevation: 0,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        textStyle:
            const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .3),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: scheme.primary,
        side: BorderSide(color: scheme.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        textStyle:
            const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .3),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surface,
      indicatorColor: scheme.primary.withOpacity(.12),
      elevation: 0,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? scheme.primary : scheme.onSurfaceVariant,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          color: selected ? scheme.primary : scheme.onSurfaceVariant,
        );
      }),
    ),
    // Brand extension: neon gradient & glow for hero/pulse elements (GO button, etc.)
    extensions: [
      TechBrand(
        heroGradient: const LinearGradient(
          colors: [Color(0xFF1F51FF), Color(0xFF00C6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        glowShadow: [
          BoxShadow(
            color: const Color(0xFF1F51FF).withOpacity(.35),
            blurRadius: 36,
            spreadRadius: 6,
          ),
        ],
      ),
    ],
  );
}

ThemeData buildLightTheme() {
  final seeded = ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    brightness: Brightness.light,
    surface: const Color(0xFFF7F8FC),
    background: const Color(0xFFF7F8FC),
  );

  final scheme = seeded.copyWith(
    // 🔵 lock exact brand blue
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFF284DFF), // slightly darker for contrast
    onPrimaryContainer: Colors.white,
    secondary: const Color(0xFF00C6FF),
    // optional: keep neutrals crisp
    surfaceTint: Colors.transparent,
  );

  return _baseTheme(scheme);
}

ThemeData buildDarkTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: kPrimaryColor,
    brightness: Brightness.dark,
    surface: const Color(0xFF0F1324),
    background: const Color(0xFF0B0F1D),
  ).copyWith(
    secondary: const Color(0xFF00C6FF),
    tertiary: const Color(0xFF7A7FFF),
    surfaceContainerHighest: const Color(0xFF171C34),
  );
  return _baseTheme(scheme);
}
