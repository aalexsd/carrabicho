import 'package:Carrrabicho/Utils/auth_screen.dart';
import 'package:Carrrabicho/Utils/utils.dart';
import 'package:Carrrabicho/meu_aplicativo.dart';
import 'package:Carrrabicho/widgets/auth_check.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Services/auth_services.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
    ],
    child: MeuAplicativo(),
  ),);
}

final navigatorKey = GlobalKey<NavigatorState>();



