import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/via_cep_service.dart';

class SignUpPage2 extends StatefulWidget {
  SignUpPage2({super.key});

  bool _loading = false;
  String? resultado;
  var _searchCepController = TextEditingController();
  var _endeController = TextEditingController();
  var _bairroController = TextEditingController();
  var _cidadeController = TextEditingController();
  var _ufController = TextEditingController();

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {

  final _formKey = GlobalKey<FormState>();
  var cep = '';
  var ende = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.of(context).size.height;
    final screenW = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/loginBG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset('assets/images/logo.png',
                      fit: BoxFit.contain,)),
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
                    height: screenH * .7,
                    width: screenW * .88,
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 24.0, left: 24),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            // autofocus: true,
                            controller: widget._searchCepController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Digite o CEP",
                              border: OutlineInputBorder(),
                              suffixIcon: widget._loading
                                  ? CircularProgressIndicator()
                                  : IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _searchCep();
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: TextFormField(
                            // autofocus: true,
                            enabled: false,
                            keyboardType: TextInputType.text,
                            controller: widget._endeController,
                            decoration: InputDecoration(
                              labelText: "Endereço",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: TextFormField(
                            // autofocus: true,
                            keyboardType: TextInputType.text,
                            enabled: false,
                            controller: widget._bairroController,
                            decoration: InputDecoration(
                              labelText: "Bairro",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: TextFormField(
                            // autofocus: true,
                            keyboardType: TextInputType.text,
                            enabled: false,
                            controller: widget._cidadeController,
                            decoration: InputDecoration(
                              labelText: "Cidade",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: TextFormField(
                            // autofocus: true,
                            keyboardType: TextInputType.text,
                            enabled: false,
                            controller: widget._ufController,
                            decoration: InputDecoration(
                              labelText: "Estado",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: TextFormField(
                            // autofocus: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Complemento (Apto / Bloco / Casa)",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 24),
                          child: TextFormField(
                            // autofocus: true,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Número",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 5, left: 24, right: 24),
                          child: ElevatedButton(
                            onPressed: () {
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
                                  child: Text(
                                    'Prosseguir',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          child: Text('Voltar'),
                        )
                      ]
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _searchCep() async {
    widget._loading = true;

    final cep = widget._searchCepController.text;

    final resultCep = await ViaCepService.fetchCep(cep: cep);

    if (resultCep == null) {
      print('CEP não encontrado. Verifique e tente novamente!');
    } else {
      setState(() {
        widget._endeController.text = resultCep.logradouro ?? '';
        widget._bairroController.text = resultCep.bairro ?? '';
        widget._cidadeController.text = resultCep.localidade ?? '';
        widget._ufController.text = resultCep.uf ?? '';
      });
    }

    widget._loading = false;
  }



}
