import 'package:flutter/material.dart';

class GeneralSignUp extends StatefulWidget {
  const GeneralSignUp({super.key});

  @override
  State<GeneralSignUp> createState() => _GeneralSignUpState();
}

class _GeneralSignUpState extends State<GeneralSignUp> {
  final email = TextEditingController();
  final senha = TextEditingController();

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 10),
          child: TextFormField(
            controller: email,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              hintText: 'Digite seu Nome',
              labelText: 'Nome',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe seu nome corretamente!';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 12),
          child: TextFormField(
            controller: email,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
              hintText: 'Digite seu E-mail',
              labelText: 'Email',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informe o email corretamente!';
              }
              return null;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 24, right: 24, top: 12),
          child: TextFormField(
            obscureText: !showPassword,
            controller: senha,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              hintText: 'Digite sua Senha',
              labelText: 'Senha',
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              suffixIcon: InkWell(
                onTap: _togglePasswordVisibility,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, right: 12, bottom: 12),
                  child: Text(
                    showPassword ? 'Ocultar' : 'Exibir',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Informa sua senha!';
              } else if (value.length < 6) {
                return 'Sua senha deve ter no mínimo 6 caracteres';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

}
