import 'dart:developer';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:business_umbrella/pages/promoter/PromoterHome.dart';
import 'package:business_umbrella/pages/promoter/PromoterLogin.dart';
import 'package:business_umbrella/utils/shared_prefrences.dart';
import 'package:business_umbrella/utils/utils.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.platformDispatcher.locale.countryCode;
  await PreferenceUtils.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
      // Authentication  PromoterHome
      routes: {
        '/prologin': (context) => const PromoterLogin(),
        '/home': (context) => const PromoterHome(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AnimatedSplashScreen(
      splash: "lib/assets/iec_splash.png",
      nextScreen: buildInitScreen(),
      duration: 2000,
      animationDuration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.white,
      splashIconSize: size.height,
    );
  }

  Widget buildInitScreen() {
    bool isPromoterLogin = PreferenceUtils.getBool(Utils.IS_PROMOTOER_LOGIN);
    log("GetPromoterLogin: $isPromoterLogin");
    if (isPromoterLogin) {
      return const PromoterHome();
    } else {
      return const PromoterLogin();
    }
  }
}
