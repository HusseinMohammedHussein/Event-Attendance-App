import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:business_umbrella/pages/promoter/PromoterHome.dart';
import 'package:business_umbrella/pages/promoter/PromoterLogin.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: const PromoterLogin(), // Authentication  PromoterHome
      routes: {
        '/prologin': (context) => const PromoterLogin(),
        '/home': (context) => PromoterHome(),
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
      splash: "lib/assets/iec_logo.png",
      nextScreen: PromoterHome(),
      duration: 2000,
      backgroundColor: Colors.white,
      splashIconSize: size.height,
    );
  }
}
