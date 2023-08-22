// import 'package:flutter/material.dart';
//
//
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }
//
// //this code sets up a screen that displays either a login or sign-up screen depending on the value of isLogin, and allows the user to switch between the two screens by calling the toggle method
// class _AuthScreenState extends State<AuthScreen> {
//   bool isLogin = true;
//   @override
//   Widget build(BuildContext context) =>
//       isLogin ? LoginScreen(onClickedSignUp: toggle)
//           : SignUpScreen(onClickedSignIn: toggle,);
//
//   void toggle() => setState(() => isLogin = !isLogin);
//
//   }
//
