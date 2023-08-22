import 'package:Carrrabicho/screens/edit_profile_screen.dart';
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
                      style: TextStyle(
                        fontSize: 15
                      )),
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
                    title: const Text('E-mail:',
                    style: TextStyle(
                      fontSize: 15
                    ),),
                    trailing: Text(user.email!),
                  ),
                  const Divider(height: 1),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: mediaquery.size.height * .07,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditProfileScreen(
                              updateDisplayName: updateDisplayName,
                              displayName: displayName)));
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.black87),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: const BorderSide(
                                  color: Colors.black87))),
                    ),
                    child: const Text('Editar Perfil'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}