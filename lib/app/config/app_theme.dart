
import 'package:flutter/material.dart';

class MyTheme{
  late bool isDark;
  late Color bg1;
  late Color surface1;
  late Color accent1;
  late Color focus;


  /// Default constructor
  MyTheme({required this.isDark}) {

  }

  /// Creates an AppTheme from a provided Type.
  factory MyTheme.fromType(isDark) {
    return MyTheme(isDark: isDark)
      ..bg1 = isDark ? Colors.black38 :
      Colors.white
      ..surface1 = isDark ? Colors.black12 :
      Colors.white12
      ..accent1 = isDark ? Colors.white70:
      Colors.black87
      ..focus = isDark ? Colors.orangeAccent :
      Colors.amber ;
  }

  // Converts AppTheme into a Material Theme Data, using whatever mappings we like
  ThemeData get themeData {
    var t = ThemeData.from(
      // Use the .dark() and .light() constructors to handle the text themes
      textTheme: (isDark ? ThemeData.dark() : ThemeData.light()).textTheme,
      // Use ColorScheme to generate the bulk of the color theme
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: accent1,
          primaryContainer: shift(accent1, .1),
          inversePrimary: invertColor(accent1),
          secondary: shift(accent1, .1),
          secondaryContainer: shift(accent1, .2),
          background: bg1,
          surface: surface1,
          inverseSurface: invertColor(surface1),
          onBackground: bg1,
          onSurface: surface1,
          onError: focus,
          onPrimary: accent1,
          onSecondary: shift(accent1, .1),
          error: focus),
    );

    // Apply additional styling that is missed by ColorScheme
    var t2 = t.copyWith(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: shift(accent1, .1),
          selectionHandleColor: Colors.transparent,
          selectionColor: surface1,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: accent1,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: accent1,
              backgroundColor: bg1,
              minimumSize: const Size(88, 36),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(2)),
              )
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: accent1,
            backgroundColor: bg1,
          ),
        ),
        highlightColor: shift(accent1, .1),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: accent1),
          color: bg1
        ),
        snackBarTheme: SnackBarThemeData(backgroundColor: isDark ? Colors.white70 : Colors.blueGrey), checkboxTheme: CheckboxThemeData(
         fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return accent1; }
             return null;
           }),
         ), radioTheme: RadioThemeData(
         fillColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return accent1; }
            return null;
           }),
         ), switchTheme: SwitchThemeData(
         thumbColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return accent1; }
            return null;
           }),
         trackColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
           if (states.contains(MaterialState.disabled)) { return null; }
           if (states.contains(MaterialState.selected)) { return accent1; }
            return null;
           }),
          ),
      );
    return t2;

  }

  Color shift(Color c, double amt) {
    amt *= (isDark ? -1 : 1);
    var hslc = HSLColor.fromColor(c); // Convert to HSL
    double lightness = (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
    return hslc.withLightness(lightness).toColor(); // Convert back to Color
  }

  Color invertColor(colorRaw) {
    return colorRaw.withBlue(1 - colorRaw.blue).withGreen(1 - colorRaw.green).withRed(1- colorRaw.red);
  }
}