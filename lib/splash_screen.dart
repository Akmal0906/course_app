import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    waithfunc();
  }

  void waithfunc() {
    Timer(const Duration(seconds: 3), () {
      GoRouter.of(context).pushNamed('Home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdad0d0),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.all(12),
          child: Image.asset(
            'assets/images/splash.png',
            fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 80),
          child: Text(
            'IT COURSE',
            style: TextStyle(
              color: Colors.green,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ]),
    );
  }
}
