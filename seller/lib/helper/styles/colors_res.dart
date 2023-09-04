import 'package:flutter/material.dart';
import '../utils/export.dart';
import 'package:flutter/scheduler.dart';

class ColorsRes {
  static MaterialColor appColor = const MaterialColor(
    0xffFC3901,
    <int, Color>{
      50: Color(0xffFC3901),
      100: Color(0xffFC3901),
      200: Color(0xffFC3901),
      300: Color(0xffFC3901),
      400: Color(0xffFC3901),
      500: Color(0xffFC3901),
      600: Color(0xffFC3901),
      700: Color(0xffFC3901),
      800: Color(0xffFC3901),
      900: Color(0xffFC3901),
    },
  );

  static Color orange = const Color(0xFFFFA500);
  static Color appColorLight = const Color(0xffe1ffeb);
  static Color appColorLightHalfTransparent = const Color(0x2651bd88);

  static List<Color> sellerStatisticsColors = [
    const Color(0xff406fc6),
    const Color(0xfffe9670),
    const Color(0xff3c8dbc),
    const Color(0xff64c77a),
  ];

  static Color gradient1 = const Color(0xFFFC3901);
  static Color gradient2 = const Color(0xFFFC3901);

  static Color defaultPageInnerCircle = const Color(0x1A999999);
  static Color defaultPageOuterCircle = const Color(0x0d999999);

  static Color mainTextColor = Colors.black;
  static Color subTitleTextColor = const Color(0xff999999);

  static Color bgColorLight = const Color(0xfff7f7f7);
  static Color bgColorDark = const Color(0xff141A1F);

  static Color cardColorLight = const Color(0xffffffff);
  static Color cardColorDark = const Color(0xff202934);

  //This will remain same in dark and light theme as well
  static Color lightThemeTextColor = Colors.black;
  static Color darkThemeTextColor = Colors.white;

  static Color grey = Colors.grey;
  static Color appColorWhite = Colors.white;
  static Color appColorBlack = Colors.black;
  static Color appColorRed = Colors.red;
  static Color appColorGreen = Colors.green;

  static Color greyBox = const Color(0x0a000000);
  static Color lightGreyBox = const Color.fromARGB(9, 213, 212, 212);

  //Shimmer Colors
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;
  static Color shimmerContainerColor = Colors.white.withOpacity(0.85);

  static ThemeData lightTheme = ThemeData(
    primaryColor: appColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: bgColorLight,
    cardColor: cardColorLight,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: ColorsRes.appColor,
      accentColor: ColorsRes.appColor,
    ).copyWith(
      background: Colors.white,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: appColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgColorDark,
    cardColor: cardColorDark,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: ColorsRes.appColor,
      accentColor: ColorsRes.appColor,
    ).copyWith(
      background: Colors.black,
      brightness: Brightness.dark,
    ),
  );

  static ThemeData setAppTheme() {
    String theme = Constant.session.getData(SessionManager.appThemeName);
    bool isDarkTheme = Constant.session.getBoolData(SessionManager.isDarkTheme);

    bool isDark = false;
    if (theme == Constant.themeList[2]) {
      isDark = true;
    } else if (theme == Constant.themeList[1]) {
      isDark = false;
    } else if (theme == "" || theme == Constant.themeList[0]) {
      // ignore: deprecated_member_use
      var brightness = SchedulerBinding.instance.window.platformBrightness;
      isDark = brightness == Brightness.dark;

      if (theme == "") {
        Constant.session
            .setData(SessionManager.appThemeName, Constant.themeList[0], false);
      }
    }

    if (isDark) {
      if (!isDarkTheme) {
        Constant.session.setBoolData(SessionManager.isDarkTheme, true, false);
      }
      mainTextColor = darkThemeTextColor;
      return darkTheme;
    } else {
      if (isDarkTheme) {
        Constant.session.setBoolData(SessionManager.isDarkTheme, false, false);
      }
      mainTextColor = lightThemeTextColor;
      return lightTheme;
    }
  }
}
