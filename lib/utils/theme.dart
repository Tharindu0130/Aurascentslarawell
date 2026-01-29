import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff7c580d),
      surfaceTint: Color(0xff7c580d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdeab),
      onPrimaryContainer: Color(0xff5f4100),
      secondary: Color(0xff6e5c3f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff8dfbb),
      onSecondaryContainer: Color(0xff54442a),
      tertiary: Color(0xff2a6a47),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffaef2c5),
      onTertiaryContainer: Color(0xff0a5131),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f3),
      onSurface: Color(0xff201b13),
      onSurfaceVariant: Color(0xff4e4539),
      outline: Color(0xff807567),
      outlineVariant: Color(0xffd2c5b4),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362f27),
      inversePrimary: Color(0xffefbf6d),
      primaryFixed: Color(0xffffdeab),
      onPrimaryFixed: Color(0xff281900),
      primaryFixedDim: Color(0xffefbf6d),
      onPrimaryFixedVariant: Color(0xff5f4100),
      secondaryFixed: Color(0xfff8dfbb),
      onSecondaryFixed: Color(0xff261904),
      secondaryFixedDim: Color(0xffdbc3a1),
      onSecondaryFixedVariant: Color(0xff54442a),
      tertiaryFixed: Color(0xffaef2c5),
      onTertiaryFixed: Color(0xff002110),
      tertiaryFixedDim: Color(0xff93d5aa),
      onTertiaryFixedVariant: Color(0xff0a5131),
      surfaceDim: Color(0xffe3d8cc),
      surfaceBright: Color(0xfffff8f3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffef2e5),
      surfaceContainer: Color(0xfff8ecdf),
      surfaceContainerHigh: Color(0xfff2e6d9),
      surfaceContainerHighest: Color(0xffece1d4),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4a3200),
      surfaceTint: Color(0xff7c580d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff8d661d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff43341b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff7d6a4d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003f23),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3a7955),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f3),
      onSurface: Color(0xff151009),
      onSurfaceVariant: Color(0xff3d3529),
      outline: Color(0xff5a5144),
      outlineVariant: Color(0xff766c5d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362f27),
      inversePrimary: Color(0xffefbf6d),
      primaryFixed: Color(0xff8d661d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff714e02),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff7d6a4d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff635237),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3a7955),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff1f603e),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcfc5b9),
      surfaceBright: Color(0xfffff8f3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffef2e5),
      surfaceContainer: Color(0xfff2e6d9),
      surfaceContainerHigh: Color(0xffe6dbce),
      surfaceContainerHighest: Color(0xffdbd0c3),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3d2800),
      surfaceTint: Color(0xff7c580d),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff624300),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff382a12),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff57472c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00341c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0f5433),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f3),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff332b20),
      outlineVariant: Color(0xff51483b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff362f27),
      inversePrimary: Color(0xffefbf6d),
      primaryFixed: Color(0xff624300),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff452e00),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff57472c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3f3018),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff0f5433),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003b21),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc1b7ab),
      surfaceBright: Color(0xfffff8f3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbefe2),
      surfaceContainer: Color(0xffece1d4),
      surfaceContainerHigh: Color(0xffded3c6),
      surfaceContainerHighest: Color(0xffcfc5b9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffefbf6d),
      surfaceTint: Color(0xffefbf6d),
      onPrimary: Color(0xff422c00),
      primaryContainer: Color(0xff5f4100),
      onPrimaryContainer: Color(0xffffdeab),
      secondary: Color(0xffdbc3a1),
      onSecondary: Color(0xff3c2e16),
      secondaryContainer: Color(0xff54442a),
      onSecondaryContainer: Color(0xfff8dfbb),
      tertiary: Color(0xff93d5aa),
      onTertiary: Color(0xff00391f),
      tertiaryContainer: Color(0xff0a5131),
      onTertiaryContainer: Color(0xffaef2c5),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff17130b),
      onSurface: Color(0xffece1d4),
      onSurfaceVariant: Color(0xffd2c5b4),
      outline: Color(0xff9b8f80),
      outlineVariant: Color(0xff4e4539),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d4),
      inversePrimary: Color(0xff7c580d),
      primaryFixed: Color(0xffffdeab),
      onPrimaryFixed: Color(0xff281900),
      primaryFixedDim: Color(0xffefbf6d),
      onPrimaryFixedVariant: Color(0xff5f4100),
      secondaryFixed: Color(0xfff8dfbb),
      onSecondaryFixed: Color(0xff261904),
      secondaryFixedDim: Color(0xffdbc3a1),
      onSecondaryFixedVariant: Color(0xff54442a),
      tertiaryFixed: Color(0xffaef2c5),
      onTertiaryFixed: Color(0xff002110),
      tertiaryFixedDim: Color(0xff93d5aa),
      onTertiaryFixedVariant: Color(0xff0a5131),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff3f382f),
      surfaceContainerLowest: Color(0xff120d07),
      surfaceContainerLow: Color(0xff201b13),
      surfaceContainer: Color(0xff241f17),
      surfaceContainerHigh: Color(0xff2f2921),
      surfaceContainerHighest: Color(0xff3a342b),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd696),
      surfaceTint: Color(0xffefbf6d),
      onPrimary: Color(0xff352200),
      primaryContainer: Color(0xffb48a3d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff2d9b5),
      onSecondary: Color(0xff31230c),
      secondaryContainer: Color(0xffa38e6e),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffa8ebbf),
      onTertiary: Color(0xff002c17),
      tertiaryContainer: Color(0xff5e9e76),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff17130b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe8dac9),
      outline: Color(0xffbdb0a0),
      outlineVariant: Color(0xff9a8f7f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d4),
      inversePrimary: Color(0xff614200),
      primaryFixed: Color(0xffffdeab),
      onPrimaryFixed: Color(0xff1a0f00),
      primaryFixedDim: Color(0xffefbf6d),
      onPrimaryFixedVariant: Color(0xff4a3200),
      secondaryFixed: Color(0xfff8dfbb),
      onSecondaryFixed: Color(0xff1a0f00),
      secondaryFixedDim: Color(0xffdbc3a1),
      onSecondaryFixedVariant: Color(0xff43341b),
      tertiaryFixed: Color(0xffaef2c5),
      onTertiaryFixed: Color(0xff001509),
      tertiaryFixedDim: Color(0xff93d5aa),
      onTertiaryFixedVariant: Color(0xff003f23),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff4a433a),
      surfaceContainerLowest: Color(0xff0b0703),
      surfaceContainerLow: Color(0xff221d15),
      surfaceContainer: Color(0xff2d271f),
      surfaceContainerHigh: Color(0xff383229),
      surfaceContainerHighest: Color(0xff433d34),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffedd7),
      surfaceTint: Color(0xffefbf6d),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffebbb69),
      onPrimaryContainer: Color(0xff120a00),
      secondary: Color(0xffffedd7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd7bf9d),
      onSecondaryContainer: Color(0xff120a00),
      tertiary: Color(0xffbdffd2),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff8fd1a6),
      onTertiaryContainer: Color(0xff000f05),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff17130b),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfffceedc),
      outlineVariant: Color(0xffcec1b0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffece1d4),
      inversePrimary: Color(0xff614200),
      primaryFixed: Color(0xffffdeab),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffefbf6d),
      onPrimaryFixedVariant: Color(0xff1a0f00),
      secondaryFixed: Color(0xfff8dfbb),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffdbc3a1),
      onSecondaryFixedVariant: Color(0xff1a0f00),
      tertiaryFixed: Color(0xffaef2c5),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff93d5aa),
      onTertiaryFixedVariant: Color(0xff001509),
      surfaceDim: Color(0xff17130b),
      surfaceBright: Color(0xff4a433a),
      surfaceContainerLowest: Color(0xff0b0703),
      surfaceContainerLow: Color(0xff221d15),
      surfaceContainer: Color(0xff2d271f),
      surfaceContainerHigh: Color(0xff383229),
      surfaceContainerHighest: Color(0xff433d34),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      primaryTextTheme: textTheme.apply(bodyColor: colorScheme.onPrimary, displayColor: colorScheme.onPrimary),
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      outlinedButtonTheme: outlinedButtonTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      textButtonTheme: textButtonTheme(colorScheme),
      iconTheme: iconTheme(colorScheme),
      popupMenuTheme: popupMenuTheme(colorScheme),
      snackBarTheme: snackBarTheme(colorScheme),
      dividerTheme: dividerTheme(colorScheme),
      listTileTheme: listTileTheme(colorScheme),
      appBarTheme: appBarTheme(colorScheme),
      bottomSheetTheme: bottomSheetTheme(colorScheme),
      dialogTheme: dialogTheme(colorScheme),
      cardTheme: cardTheme(colorScheme),
      checkboxTheme: checkboxTheme(colorScheme),
      radioTheme: radioTheme(colorScheme),
      switchTheme: switchTheme(colorScheme),
      expansionTileTheme: expansionTileTheme(colorScheme),
    );
  }

  IconThemeData iconTheme(ColorScheme colorScheme) {
    return IconThemeData(
      color: colorScheme.primary,
      size: 24.0,
    );
  }

  PopupMenuThemeData popupMenuTheme(ColorScheme colorScheme) {
    return PopupMenuThemeData(
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        side: BorderSide(color: colorScheme.outlineVariant, width: 1.0),
      ),
    );
  }

  BottomSheetThemeData bottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shadowColor: colorScheme.shadow,
      elevation: 1.0,
      modalBackgroundColor: colorScheme.surface,
      modalElevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
      ),
    );
  }

  DialogThemeData dialogTheme(ColorScheme colorScheme) {
    return DialogThemeData(
      backgroundColor: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      titleTextStyle: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface),
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28.0)),
      ),
    );
  }

  CardThemeData cardTheme(ColorScheme colorScheme) {
    return CardThemeData(
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.surfaceTint,
      shadowColor: colorScheme.shadow,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }

  CheckboxThemeData checkboxTheme(ColorScheme colorScheme) {
    return CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.onPrimary;
        }
        return colorScheme.primary;
      }),
      side: BorderSide(color: colorScheme.outline),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.onSurface.withOpacity(0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.onSurface.withOpacity(0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return colorScheme.onSurface.withOpacity(0.12);
        }
        return Colors.transparent;
      }),
    );
  }

  RadioThemeData radioTheme(ColorScheme colorScheme) {
    return RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return Colors.transparent;
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.onSurface.withOpacity(0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.onSurface.withOpacity(0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return colorScheme.onSurface.withOpacity(0.12);
        }
        return Colors.transparent;
      }),
    );
  }

  SwitchThemeData switchTheme(ColorScheme colorScheme) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.surface;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primaryContainer;
        }
        return colorScheme.outlineVariant;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.outline;
      }),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withOpacity(0.08);
        }
        if (states.contains(WidgetState.pressed)) {
          return colorScheme.onSurface.withOpacity(0.12);
        }
        if (states.contains(WidgetState.hovered)) {
          return colorScheme.onSurface.withOpacity(0.08);
        }
        if (states.contains(WidgetState.focused)) {
          return colorScheme.onSurface.withOpacity(0.12);
        }
        return Colors.transparent;
      }),
    );
  }

  TextButtonThemeData textButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.38);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary;
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primary;
            }
            return colorScheme.primary;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return colorScheme.primary.withOpacity(0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.primary.withOpacity(0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return colorScheme.primary.withOpacity(0.12);
          }
          return Colors.transparent;
        }),
        textStyle: WidgetStateProperty.all(textTheme.labelLarge),
        padding: WidgetStateProperty.all(const EdgeInsets.all(16.0)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }

  OutlinedButtonThemeData outlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.transparent;
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary.withOpacity(0.12);
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primary.withOpacity(0.08);
            }
            return Colors.transparent;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.38);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primary;
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primary;
            }
            return colorScheme.primary;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return colorScheme.primary.withOpacity(0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.primary.withOpacity(0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return colorScheme.primary.withOpacity(0.12);
          }
          return Colors.transparent;
        }),
        textStyle: WidgetStateProperty.all(textTheme.labelLarge),
        side: WidgetStateProperty.resolveWith<BorderSide?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: colorScheme.onSurface.withOpacity(0.12));
            }
            return BorderSide(color: colorScheme.outline);
          },
        ),
        padding: WidgetStateProperty.all(const EdgeInsets.all(16.0)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    );
  }

  ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.12);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.primaryContainer;
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.primaryContainer;
            }
            return colorScheme.primary;
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return colorScheme.onSurface.withOpacity(0.38);
            }
            if (states.contains(WidgetState.pressed)) {
              return colorScheme.onPrimaryContainer;
            }
            if (states.contains(WidgetState.hovered)) {
              return colorScheme.onPrimaryContainer;
            }
            return colorScheme.onPrimary;
          },
        ),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return colorScheme.onPrimary.withOpacity(0.12);
          }
          if (states.contains(WidgetState.hovered)) {
            return colorScheme.onPrimary.withOpacity(0.08);
          }
          if (states.contains(WidgetState.focused)) {
            return colorScheme.onPrimary.withOpacity(0.12);
          }
          return Colors.transparent;
        }),
        shadowColor: WidgetStateProperty.all(colorScheme.shadow),
        textStyle: WidgetStateProperty.all(textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
        padding: WidgetStateProperty.all(const EdgeInsets.all(16.0)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        elevation: WidgetStateProperty.resolveWith<double?>((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return 0.0;
          }
          if (states.contains(WidgetState.pressed)) {
            return 0.0;
          }
          return 1.0;
        }),
      ),
    );
  }

  InputDecorationTheme inputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.never,
      filled: true,
      fillColor: colorScheme.surface.withOpacity(0.4),
      focusColor: colorScheme.primary,
      hoverColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: colorScheme.outline, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: colorScheme.outline, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: colorScheme.error, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        borderSide: BorderSide(color: colorScheme.error, width: 2.0),
      ),
      labelStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
      hintStyle: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant),
      errorStyle: textTheme.bodySmall?.copyWith(color: colorScheme.error),
    );
  }

  SnackBarThemeData snackBarTheme(ColorScheme colorScheme) {
    return SnackBarThemeData(
      backgroundColor: colorScheme.inverseSurface,
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.inverseSurface),
      actionTextColor: colorScheme.inversePrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      behavior: SnackBarBehavior.fixed,
    );
  }

  DividerThemeData dividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(
      color: colorScheme.outlineVariant,
      space: 1.0,
      thickness: 1.0,
    );
  }

  ListTileThemeData listTileTheme(ColorScheme colorScheme) {
    return ListTileThemeData(
      textColor: colorScheme.onSurface,
      iconColor: colorScheme.onSurfaceVariant,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      tileColor: Colors.transparent,
      titleTextStyle: textTheme.titleMedium?.copyWith(color: colorScheme.onSurface),
      subtitleTextStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
    );
  }

  ExpansionTileThemeData expansionTileTheme(ColorScheme colorScheme) {
    return ExpansionTileThemeData(
      textColor: colorScheme.primary,
      iconColor: colorScheme.primary,
      collapsedIconColor: colorScheme.onSurfaceVariant,
      collapsedTextColor: colorScheme.onSurface,
      tilePadding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
      childrenPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    );
  }

  AppBarTheme appBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      surfaceTintColor: colorScheme.surfaceTint,
      shadowColor: colorScheme.shadow,
      scrolledUnderElevation: 0.0,
      titleTextStyle: textTheme.headlineSmall?.copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
      toolbarTextStyle: textTheme.bodyMedium,
      centerTitle: true,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      actionsIconTheme: IconThemeData(color: colorScheme.onSurface),
    );
  }
}

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}