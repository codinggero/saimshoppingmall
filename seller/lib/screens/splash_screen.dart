import 'package:flutter/material.dart';
import '../helper/utils/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    var publish = remoteConfig.getBool('publish');
    console.log({"publish": publish});
    if (publish == true) {
      Future.delayed(
        Duration.zero,
        () {
          Map<String, String> params = {ApiAndParams.system_type: "2"};
          if (Constant.session
              .getData(SessionManager.keySelectedLanguageId)
              .isEmpty) {
            params[ApiAndParams.is_default] = "1";
          } else {
            params[ApiAndParams.id] =
                Constant.session.getData(SessionManager.keySelectedLanguageId);
          }

          context
              .read<LanguageProvider>()
              .getLanguageDataProvider(
                params: params,
                context: context,
              )
              .then((value) {
            if (Constant.session.isUserLoggedIn()) {
              if (Constant.session.getData(SessionManager.status) == "1") {
                context
                    .read<SettingsProvider>()
                    .getSettingsApiProvider({}, context).then(
                  (value) async {
                    Navigator.pushReplacementNamed(context, mainHomeScreen);
                  },
                );
              } else {
                if (Constant.session.isSeller()) {
                  Navigator.pushReplacementNamed(
                      context, editSellerProfileScreen);
                } else {
                  Navigator.pushReplacementNamed(
                      context, editDeliveryBoyProfileScreen);
                }
              }
            } else {
              if (Constant.appLoginType == 1) {
                Constant.session
                    .setData(SessionManager.keyUserType, "seller", false);
                Navigator.pushNamed(context, loginScreen);
              } else if (Constant.appLoginType == 2) {
                Constant.session
                    .setData(SessionManager.keyUserType, "delivery_boy", false);

                Navigator.pushNamed(context, loginScreen);
              } else {
                Navigator.pushReplacementNamed(context, accountTypeScreen);
              }
            }
          });
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorsRes.appColor,
      body: Image.asset(
        'assets/images/splash.png',
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
      ),
    );
  }
}
