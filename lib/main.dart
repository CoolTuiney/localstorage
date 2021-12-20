import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localstorage/repo/user_simple_preference.dart';
import 'package:localstorage/view/barcode_screen.dart';
import 'package:localstorage/view/home_screen.dart';
import 'package:localstorage/view/login_page.dart';
import 'package:localstorage/view/map_screen.dart';
import 'package:localstorage/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await UserSimplePreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login_screen': (context) => const LoginPage(),
        '/home_screen': (context) => const HomeScreen(),
        '/barcode_scanner_screen': (context) => const BarcodeScannerScreen(),
        '/MapScreen': (context) => const MapScreen()
      },
    );
  }
}
