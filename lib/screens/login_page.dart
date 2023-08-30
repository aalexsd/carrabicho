import 'package:Carrrabicho/repository/profissoes.dart';
import 'package:Carrrabicho/screens/home_screen.dart';
import 'package:Carrrabicho/widgets/signup.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../Services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  bool isUsuario = true;
  late String titulo;
  late String subtitulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    setFormAction(true);
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = 'Bem-vindo';
        subtitulo = 'Entre na sua conta';
        actionButton = 'Entrar';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora.';
      } else {
        titulo = 'Registre-se';
        subtitulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login.';
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void onForgotPasswordClicked(BuildContext context) {
    Navigator.of(context).pushNamed('/forgot_password');
  }

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/carrabicho.png'),
                  radius: 50,
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 4), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    height: isLogin ? screenH * .56 : screenH * .65,
                    width: screenW * .88,
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1.5,
                          ),
                        ),
                        Text(
                          subtitulo,
                          style: const TextStyle(
                              color: Colors.indigo,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -1),
                        ),
                        if(!isLogin)
                          Column(
                            children: [
                              Row(
                                children: [
                                  Radio<bool>(
                                    value: true,
                                    groupValue: isUsuario,
                                    onChanged: (value) {
                                      setState(() {
                                        isUsuario = value!;
                                      });
                                    },
                                  ),
                                  const Text('Sou usuário',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Radio<bool>(
                                    value: false,
                                    groupValue: isUsuario,
                                    onChanged: (value) {
                                      setState(() {
                                        isUsuario = value!;
                                      });
                                    },
                                  ),
                                  const Text('Sou prestador de Serviço',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold
                                    ),),
                                ],
                              ),
                            ],
                          ),
                        if(!isLogin && isUsuario)
                          GeneralSignUp(),
                        if(!isLogin && !isUsuario)
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24, right: 24),
                                child: DropdownSearch<String>(
                                  popupProps: PopupProps.menu(
                                    fit: FlexFit.tight,
                                    showSelectedItems: true,
                                    showSearchBox: false,
                                  ),
                                  items: Profissaorepository
                                      .listProfissao,
                                  dropdownDecoratorProps:
                                  DropDownDecoratorProps(
                                    dropdownSearchDecoration:
                                    InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(Icons.shopping_bag),
                                      hintText: 'Tipo de Prestador',
                                      labelText: 'Tipo de Prestador',
                                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty) {
                                      return 'Selecione o Tipo de Serviço';
                                    }
                                    return null; // Retorna null se o campo estiver preenchido corretamente
                                  },
                                ),
                              ),
                              GeneralSignUp(),
                            ],
                          ),
                        if (isLogin)
                          Column(
                            children: [
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
                              Padding(
                                padding: const EdgeInsets.only(right: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text(
                                        'Esqueceu sua senha?',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                      onPressed: () {
                                        onForgotPasswordClicked(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 5, left: 24, right: 24),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (isLogin) {
                                  login();
                                } else {
                                  // registrar();
                                  Navigator.pushNamed(context, '/signup2');
                                }
                              }
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: (loading)
                                  ? [
                                      const Padding(
                                        padding: EdgeInsets.all(16),
                                        child: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ]
                                  : [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child:
                                        (isLogin) ?
                                        Text(
                                          actionButton,
                                          style: const TextStyle(fontSize: 20),
                                        )
                                            : Text(
                                          'Prosseguir',
                                          style: const TextStyle(fontSize: 20),
                                        )
                                      ),
                                    ],
                            ),
                          ),
                        ),
                        if (isLogin)
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    indent: 50,
                                    endIndent: 10,
                                  ),
                                ),
                                Text("ou"),
                                Expanded(
                                  child: Divider(
                                    thickness: 2,
                                    indent: 10,
                                    endIndent: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isLogin)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SignInButton(
                                Buttons.google,
                                text: 'Entre com o Google',
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onPressed: () {
                                  signInWithGoogle();
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () => setFormAction(!isLogin),
                  child: Text(
                    toggleButton,
                    style: const TextStyle(color: Colors.indigo),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {}
  }
}
