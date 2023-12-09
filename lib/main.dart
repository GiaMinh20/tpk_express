import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tpk_express/constants/constants.dart';
import 'package:tpk_express/screens/homes/profiles/recharges/recharge_screen.dart';

import 'models/user_data.dart';
import 'providers/webhook_provider.dart';
import 'screens/forgot_passwords/forgot_password_screen.dart';
import 'screens/homes/profiles/updates/profile_update_screen.dart';
import 'screens/homes/profiles/vouchers/voucher_screen.dart';
import 'screens/roots/root_screen.dart';
import 'screens/sign_ins/sign_in_screen.dart';
import 'screens/sign_ups/sign_up_screen.dart';
import 'screens/welcomes/welcome_screen.dart';

UserData userDataSession =
    UserData.fromJson(GetStorage().read('userData') ?? {});

final WebHookProvider webHookProvider = WebHookProvider();

Future<void> main() async {
  GetStorage.init();

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("ca1d8fa1-3e74-4c4e-aec8-4bb3ae571306");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();

  var contactConfig = await webHookProvider.getContactConfig();
  if (contactConfig.hotLine != null) {
    GetStorage().write('hotline', contactConfig.hotLine);
  }
  if (contactConfig.zaloLink != null) {
    GetStorage().write('zaloLink', contactConfig.zaloLink);
  }

  if (contactConfig.insurancePercent != null) {
    GetStorage().write('insurancePercent', contactConfig.insurancePercent);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TPK Express',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      navigatorKey: Get.key,
      color: Constants.primaryColor,
      initialRoute: userDataSession.uid != null ? '/root' : '/',
      getPages: [
        GetPage(name: '/', page: () => const WelcomeScreen()),
        GetPage(name: '/signIn', page: () => SignInScreen()),
        GetPage(name: '/signUp', page: () => SignUpScreen()),
        GetPage(name: '/forgotPassword', page: () => ForgotPasswordScreen()),
        GetPage(name: '/root', page: () => RootScreen()),
        GetPage(name: '/updateAccountInfo', page: () => ProfileUpdateScreen()),
        GetPage(name: '/recharge', page: () => RechargeScreen()),
        GetPage(name: '/voucher', page: () => VoucherScreen()),
      ],
    );
  }
}
