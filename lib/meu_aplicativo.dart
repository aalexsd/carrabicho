import 'package:Carrrabicho/screens/forgot_password_page.dart';
import 'package:Carrrabicho/screens/home_screen.dart';
import 'package:Carrrabicho/screens/login_page.dart';
import 'package:Carrrabicho/screens/signup_page2.dart';
import 'package:Carrrabicho/screens/splash_screen.dart';
import 'package:Carrrabicho/widgets/auth_check.dart';
import 'package:flutter/material.dart';


class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          color: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      title: 'Monitora Orgânico',
      initialRoute: '/splash',
      routes: {
        '/': (context) => const AuthCheck(),
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/signup2': (context) => SignUpPage2(),
        // '/edit_profile': (context) => const EditProfileScreen(),
        // 'verify_email': (context) => const VerifyEmailScreen(),
      },
    );
  }
}
