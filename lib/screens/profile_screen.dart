import 'package:Carrrabicho/screens/edit_profile_screen.dart';
import 'package:Carrrabicho/widgets/block_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String displayName =
      FirebaseAuth.instance.currentUser?.displayName ?? '';

  void updateDisplayName(String newName) {
    setState(() {
      displayName = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    final user = FirebaseAuth.instance.currentUser!;
    displayName = user.displayName ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Olá, $displayName',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, top: 20),
              child: Text(
                'Informações Pessoais',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Nome completo:',
                        style: TextStyle(fontSize: 15)),
                    trailing: Text(user.displayName ?? ''),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                                updateDisplayName: updateDisplayName,
                                displayName: displayName,
                              )));
                    },
                  ),
                  const Divider(height: 1),
                  ListTile(
                    title: const Text(
                      'E-mail:',
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Text(user.email!),
                  ),
                  const Divider(height: 1),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: BlockButton(
                    label: 'Edital Perfil',
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                              updateDisplayName: updateDisplayName,
                              displayName: displayName)));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
