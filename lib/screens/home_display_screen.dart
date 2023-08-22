import 'package:Carrrabicho/screens/veterinario_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'adestrador_screen.dart';
import 'cuidador_display.dart';


class HomeDisplayScreen extends StatefulWidget {
  const HomeDisplayScreen({Key? key}) : super(key: key);

  @override
  State<HomeDisplayScreen> createState() => _HomeDisplayScreenState();
}

class _HomeDisplayScreenState extends State<HomeDisplayScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedValue = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

// Check if the current user's email is verified
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    await user?.reload();
    return user?.emailVerified ?? false;
  }

  Future<void> sendVerificationEmail() async {
    User? user = _auth.currentUser;
    await user?.sendEmailVerification();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // Controller will help us move next, rewind action

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(FontAwesomeIcons.bars),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        //creates a side screen
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Menu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  signOutGoogle().then((value) => Navigator.pop(context));
                  FirebaseAuth.instance.signOut();
                },
                child: const ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Sair'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: const Text(
                  'O que você está procurando hoje?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .15,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const VeterinarioScreen()),
                      );
                    },
                    child: const Text(
                      'Veterinário',
                      style:
                      TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .15,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AdestradorScreen()),
                      );
                    },
                    child: const Text(
                      'Adestrador',
                      style:
                      TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .15,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CuidadorScreen()),
                      );
                    },
                    child: const Text(
                      'Cuidador',
                      style:
                      TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ));
  }

  //method to signout of a google account
  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Logout realizado com sucesso')),
    );
  }
}
//
