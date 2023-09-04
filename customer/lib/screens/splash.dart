import 'package:flutter/material.dart';
import '../helper/utils/export.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PackageInfo packageInfo;
  String currentAppVersion = "1.0.0";
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    super.initState();
    if (publish) {
      console.log({"publish": publish});
      Future.delayed(Duration.zero).then(
        (value) {
          callAllApis();
        },
      );
    }
  }

  callAllApis() {
    context
        .read<AppSettingsProvider>()
        .getAppSettingsProvider(context)
        .then((value) async {
      packageInfo = await PackageInfo.fromPlatform();
      currentAppVersion = packageInfo.version;
      LocationPermission permission;

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      } else if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }

      PermissionStatus microphone = await Permission.microphone.status;
      if (microphone.isDenied) {
        await Permission.microphone.request();
      }

      Map<String, String> params = {ApiAndParams.system_type: "1"};
      if (Constant.session
          .getData(SessionManager.keySelectedLanguageId)
          .isEmpty) {
        params[ApiAndParams.is_default] = "1";
      } else {
        params[ApiAndParams.id] =
            Constant.session.getData(SessionManager.keySelectedLanguageId);
      }
      if (context.mounted) {
        await context.read<LanguageProvider>().getAvailableLanguageList(
            params: {ApiAndParams.system_type: "1"},
            context: context).then((value) {
          context
              .read<LanguageProvider>()
              .getLanguageDataProvider(
                params: params,
                context: context,
              )
              .then((value) {
            if (context.read<LanguageProvider>().languageState ==
                    LanguageState.loaded &&
                context.read<AppSettingsProvider>().settingsState ==
                    SettingsState.loaded) {
              startTime();
            }
          });
        });
      }
    });
  }

  startTime() async {
    if (Constant.appMaintenanceMode == "1") {
      Navigator.pushReplacementNamed(context, underMaintenanceScreen);
    } else if (Platform.isAndroid) {
      if (!Constant.session.getBoolData(SessionManager.introSlider)) {
        if ((Constant.isVersionSystemOn == "1" ||
                Constant.currentRequiredAppVersion.isNotEmpty) &&
            (Version.parse(Constant.currentRequiredAppVersion) >
                Version.parse(currentAppVersion))) {
          if (Constant.requiredForceUpdate == "1") {
            Constant.session
                .setBoolData(SessionManager.introSlider, true, false);
            Navigator.pushReplacementNamed(context, introSliderScreen);
            Navigator.pushReplacementNamed(context, appUpdateScreen,
                arguments: true);
          } else {
            Constant.session
                .setBoolData(SessionManager.introSlider, true, false);
            Navigator.pushReplacementNamed(context, introSliderScreen);
            Navigator.pushNamed(context, appUpdateScreen, arguments: false);
          }
        } else {
          Constant.session.setBoolData(SessionManager.introSlider, true, false);
          Navigator.pushReplacementNamed(context, introSliderScreen);
        }
      } else if (Constant.session.getBoolData(SessionManager.isUserLogin) &&
          Constant.session.getIntData(SessionManager.keyUserStatus) == 2) {
        if (Constant.isVersionSystemOn == "1" &&
            (Version.parse(Constant.currentRequiredAppVersion) >
                Version.parse(currentAppVersion))) {
          if (Constant.requiredForceUpdate == "1") {
            Navigator.pushReplacementNamed(context, editProfileScreen,
                arguments: "register");
            Navigator.pushReplacementNamed(context, appUpdateScreen,
                arguments: true);
          } else {
            Navigator.pushReplacementNamed(context, editProfileScreen,
                arguments: "register");
            Navigator.pushNamed(context, appUpdateScreen, arguments: false);
          }
        } else {
          Navigator.pushReplacementNamed(context, editProfileScreen,
              arguments: "register");
        }
      } else {
        if (Constant.session.getBoolData(SessionManager.keySkipLogin) ||
            Constant.session.getBoolData(SessionManager.isUserLogin)) {
          if (Constant.session.getData(SessionManager.keyLatitude) == "0" &&
              Constant.session.getData(SessionManager.keyLongitude) == "0") {
            if (Constant.isVersionSystemOn == "1" &&
                (Version.parse(Constant.currentRequiredAppVersion) >
                    Version.parse(currentAppVersion))) {
              if (Constant.requiredForceUpdate == "1") {
                Navigator.pushReplacementNamed(context, mainHomeScreen);
                Navigator.pushReplacementNamed(context, appUpdateScreen,
                    arguments: true);
              } else {
                Navigator.pushReplacementNamed(context, mainHomeScreen);
                Navigator.pushNamed(context, appUpdateScreen, arguments: false);
              }
            } else {
              Navigator.pushReplacementNamed(context, mainHomeScreen);
            }
          } else {
            if (Constant.isVersionSystemOn == "1" &&
                (Version.parse(Constant.currentRequiredAppVersion) >
                    Version.parse(currentAppVersion))) {
              if (Constant.requiredForceUpdate == "1") {
                Navigator.pushReplacementNamed(context, mainHomeScreen);
                Navigator.pushReplacementNamed(context, appUpdateScreen,
                    arguments: true);
              } else {
                Navigator.pushReplacementNamed(context, mainHomeScreen);
                Navigator.pushNamed(context, appUpdateScreen, arguments: false);
              }
            } else {
              Navigator.pushReplacementNamed(context, mainHomeScreen);
            }
          }
        } else {
          if (Constant.isVersionSystemOn == "1" &&
              (Version.parse(Constant.currentRequiredAppVersion) >
                  Version.parse(currentAppVersion))) {
            if (Constant.requiredForceUpdate == "1") {
              Navigator.pushReplacementNamed(context, loginScreen);
              Navigator.pushReplacementNamed(context, appUpdateScreen,
                  arguments: true);
            } else {
              Navigator.pushReplacementNamed(context, loginScreen);
              Navigator.pushNamed(context, appUpdateScreen, arguments: false);
            }
          } else {
            Navigator.pushReplacementNamed(context, loginScreen);
          }
        }
      }
    } else if (Platform.isIOS) {
      if (!Constant.session.getBoolData(SessionManager.introSlider)) {
        if ((Constant.isIosVersionSystemOn == "1" ||
                Constant.currentRequiredIosAppVersion.isNotEmpty) &&
            (Version.parse(Constant.currentRequiredIosAppVersion) >
                Version.parse(currentAppVersion))) {
          if (Constant.requiredIosForceUpdate == "1") {
            Constant.session
                .setBoolData(SessionManager.introSlider, true, false);
            Navigator.pushReplacementNamed(context, introSliderScreen);
            Navigator.pushReplacementNamed(context, appUpdateScreen,
                arguments: true);
          } else {
            Constant.session
                .setBoolData(SessionManager.introSlider, true, false);
            Navigator.pushReplacementNamed(context, introSliderScreen);
            Navigator.pushNamed(context, appUpdateScreen, arguments: false);
          }
        } else {
          Constant.session.setBoolData(SessionManager.introSlider, true, false);
          Navigator.pushReplacementNamed(context, introSliderScreen);
        }
      } else if (Constant.session.getBoolData(SessionManager.isUserLogin) &&
          Constant.session.getIntData(SessionManager.keyUserStatus) == 2) {
        if (await versionInformationAvailable()) {
          if (Constant.requiredIosForceUpdate == "1") {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, editProfileScreen,
                  arguments: "register");
            }
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, appUpdateScreen,
                  arguments: true);
            }
          } else {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, editProfileScreen,
                  arguments: "register");
            }
            if (context.mounted) {
              Navigator.pushNamed(context, appUpdateScreen, arguments: false);
            }
          }
        } else {
          if (context.mounted) {
            Navigator.pushReplacementNamed(context, editProfileScreen,
                arguments: "register");
          }
        }
      } else {
        if (Constant.session.getBoolData(SessionManager.keySkipLogin) ||
            Constant.session.getBoolData(SessionManager.isUserLogin)) {
          if (Constant.session.getData(SessionManager.keyLatitude) == "0" &&
              Constant.session.getData(SessionManager.keyLongitude) == "0") {
            if (await versionInformationAvailable()) {
              if (Constant.requiredIosForceUpdate == "1") {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, appUpdateScreen,
                      arguments: true);
                }
              } else {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
                if (context.mounted) {
                  Navigator.pushNamed(context, appUpdateScreen,
                      arguments: false);
                }
              }
            } else {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, mainHomeScreen);
              }
            }
          } else {
            if (await versionInformationAvailable()) {
              if (Constant.requiredIosForceUpdate == "1") {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, appUpdateScreen,
                      arguments: true);
                }
              } else {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, mainHomeScreen);
                }
                if (context.mounted) {
                  Navigator.pushNamed(context, appUpdateScreen,
                      arguments: false);
                }
              }
            } else {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, mainHomeScreen);
              }
            }
          }
        } else {
          if (await versionInformationAvailable()) {
            if (Constant.requiredIosForceUpdate == "1") {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, loginScreen);
              }
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, appUpdateScreen,
                    arguments: true);
              }
            } else {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, loginScreen);
              }
              if (context.mounted) {
                Navigator.pushNamed(context, appUpdateScreen, arguments: false);
              }
            }
          } else {
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, loginScreen);
            }
          }
        }
      }
    }
  }

  Future<bool> versionInformationAvailable() async {
    return Constant.isIosVersionSystemOn == "1" &&
        (Version.parse(Constant.currentRequiredIosAppVersion) >
            Version.parse(currentAppVersion));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Consumer<AppSettingsProvider>(
          builder: (context, appSettingsProvider, child) {
            if (languageProvider.languageState == LanguageState.error ||
                appSettingsProvider.settingsState == SettingsState.error) {
              return Scaffold(
                backgroundColor: Theme.of(context).cardColor,
                body: NoInternetConnectionScreen(
                  height: MediaQuery.of(context).size.height,
                  message: languageProvider.message.isNotEmpty
                      ? languageProvider.message
                      : appSettingsProvider.message,
                  callback: () async {
                    await callAllApis();
                  },
                ),
              );
            } else {
              return Scaffold(
                body: Image.asset(
                  'assets/images/splash.png',
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              );
            }
          },
        );
      },
    );
  }
}
