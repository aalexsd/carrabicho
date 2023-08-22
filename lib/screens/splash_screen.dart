import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/auth_check.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final textsplash = Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/carrabicho.png'),
                radius: 60,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Carrabicho',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Desenvolvido por Alex',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                )
              ],
            ),

          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 50.0),
            child: Text(
              'Versão Beta',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );

    return AnimatedSplashScreen(
      backgroundColor: Colors.indigo,
      splash: textsplash,
      splashIconSize: MediaQuery.of(context).size.height,
      nextScreen: const AuthCheck(),
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}