import 'package:flutter/material.dart';
import 'helper/utils/export.dart';

late final SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 1),
  ));
  await remoteConfig.fetchAndActivate();

  publish = remoteConfig.getBool('publish');

  console.log(publish);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CategoryListProvider>(
          create: (context) {
            return CategoryListProvider();
          },
        ),
        ChangeNotifierProvider<CityByLatLongProvider>(
          create: (context) {
            return CityByLatLongProvider();
          },
        ),
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (context) {
            return HomeScreenProvider();
          },
        ),
        ChangeNotifierProvider<ProductChangeListingTypeProvider>(
          create: (context) {
            return ProductChangeListingTypeProvider();
          },
        ),
        ChangeNotifierProvider<FaqProvider>(
          create: (context) {
            return FaqProvider();
          },
        ),
        ChangeNotifierProvider<ProductWishListProvider>(
          create: (context) {
            return ProductWishListProvider();
          },
        ),
        ChangeNotifierProvider<ProductAddOrRemoveFavoriteProvider>(
          create: (context) {
            return ProductAddOrRemoveFavoriteProvider();
          },
        ),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) {
            return UserProfileProvider();
          },
        ),
        ChangeNotifierProvider<CartListProvider>(
          create: (context) {
            return CartListProvider();
          },
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) {
            return LanguageProvider();
          },
        ),
        ChangeNotifierProvider<AppSettingsProvider>(
          create: (context) {
            return AppSettingsProvider();
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class GlobalScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SessionManager>(
      create: (_) => SessionManager(prefs: prefs),
      child: Consumer<SessionManager>(
        builder: (context, SessionManager sessionNotifier, child) {
          Constant.session = Provider.of<SessionManager>(context);

          Constant.searchedItemsHistoryList = Constant.session.prefs
                  .getStringList(SessionManager.keySearchHistory) ??
              [];

          // ignore: deprecated_member_use
          final window = WidgetsBinding.instance.window;

          if (Constant.session
              .getData(SessionManager.appThemeName)
              .toString()
              .isEmpty) {
            Constant.session.setData(
                SessionManager.appThemeName, Constant.themeList[0], false);
            Constant.session.setBoolData(SessionManager.isDarkTheme,
                window.platformBrightness == Brightness.dark, false);
          }

          // This callback is called every time the brightness changes from the device.
          window.onPlatformBrightnessChanged = () {
            if (Constant.session.getData(SessionManager.appThemeName) ==
                Constant.themeList[0]) {
              Constant.session.setBoolData(SessionManager.isDarkTheme,
                  window.platformBrightness == Brightness.dark, true);
            }
          };

          return Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              Constant.session = Provider.of<SessionManager>(context);

              Constant.searchedItemsHistoryList = Constant.session.prefs
                      .getStringList(SessionManager.keySearchHistory) ??
                  [];

              // ignore: deprecated_member_use
              final window = WidgetsBinding.instance.window;

              if (Constant.session
                  .getData(SessionManager.appThemeName)
                  .toString()
                  .isEmpty) {
                Constant.session.setData(
                    SessionManager.appThemeName, Constant.themeList[0], false);
                Constant.session.setBoolData(SessionManager.isDarkTheme,
                    window.platformBrightness == Brightness.dark, false);
              }

              // This callback is called every time the brightness changes from the device.
              window.onPlatformBrightnessChanged = () {
                if (Constant.session.getData(SessionManager.appThemeName) ==
                    Constant.themeList[0]) {
                  Constant.session.setBoolData(SessionManager.isDarkTheme,
                      window.platformBrightness == Brightness.dark, true);
                }
              };

              return MaterialApp(
                builder: (context, child) {
                  return ScrollConfiguration(
                    behavior: GlobalScrollBehavior(),
                    child: Directionality(
                      textDirection:
                          languageProvider.languageDirection.toLowerCase() ==
                                  "rtl"
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                      child: child!,
                    ),
                  );
                },
                navigatorKey: Constant.navigatorKay,
                onGenerateRoute: RouteGenerator.generateRoute,
                initialRoute: "/",
                scrollBehavior: ScrollGlowBehavior(),
                debugShowCheckedModeBanner: false,
                title: "egrocer",
                theme: ColorsRes.setAppTheme().copyWith(
                  textTheme:
                      GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
                ),
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
