import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/block_button.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final email = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        height: mediaquery.size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/carrabicho.png'),
                        radius: 60,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 24.0),
                      child: SizedBox(
                        width: mediaquery.size.height * .5,
                        child: const Text(
                          'Esqueceu sua Senha?',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: SizedBox(
                        width: mediaquery.size.height * .4,
                        child: const Text(
                          'Redefina sua Senha em duas etapas.',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.indigo,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 24, bottom: 5),
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Digite seu E-mail',
                          labelText: 'Email',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (valueValidator(value)) {
                            return 'Insira um Email';
                          }
                          return null;
                        },
                      ),
                    ),
                    BlockButton(
                        label: 'Redefinir Senha',
                        onPressed: isLoading ? null : resetPassword),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());

      Navigator.of(context).pop(); // Fecha o diálogo
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('E-mail de redefinição de Senha foi enviado.')));
      Navigator.pushReplacementNamed(
          context, '/login'); // Navega para a tela de login
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? '')));
      Navigator.of(context).pop(); // Fecha o diálogo
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool valueValidator(String? value) {
    if (value != null && value.isEmpty) {
      return true;
    }
    return false;
  }
}
