import 'dart:async';

import 'package:flutter/material.dart';
import 'package:localstorage/repo/permission_handler.dart';

import 'package:localstorage/repo/user_simple_preference.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? obtainedEmail = '';

  getValidation() {
    obtainedEmail =
        UserSimplePreference.getEmail(UserSimplePreference.keyUsername);
       
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await PermissionHandler.getStoragePermission();
    });
    getValidation();
    Timer(const Duration(seconds: 2), () {
      if (obtainedEmail == null) {
        Navigator.pushNamed(context, '/login_screen');
      } else {
        Navigator.of(context)
            .pushNamed('/home_screen', arguments: {'email': obtainedEmail});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
