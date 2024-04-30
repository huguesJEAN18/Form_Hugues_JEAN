import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  TextEditingController prix = TextEditingController();
  TextEditingController tva = TextEditingController();
  TextEditingController prixTTC = TextEditingController();
  String? prixText;
  String? tvaText;
  String? prixTTCText;

  void compteur() {
    double prixProduit = double.parse(prixTTC.text);
    double tvaProduits = double.parse(tva.text);
    double prixTotal;
    setState(() {
      if (keyForm.currentState!.validate()) {
        keyForm.currentState?.save();
      }
      prix.text = '0';
      prixTotal = tvaProduits * prixProduit;
      prix.text = '$prixTotal';
    });
  }

  @override
  Widget build(BuildContext context) {
    String nom;
    String prenom;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
              key: keyForm,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: 'Prenom',
                    onSaved: (newValue) {
                      nom = newValue!;
                      print(nom);
                    },
                    validator: (value) {
                      if (value == null) {
                        print('Erreur veuillez saisir des caratères');
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: 'Nom',
                    validator: (value) {
                      if (value == null) {
                        print('Erreur veuillez saisir des caratères');
                      }
                      if (value!.startsWith('0', 0)) {
                        print('Veuillez saisir une lettres');
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      prenom = newValue!;
                      print(prenom);
                    },
                  ),
                  TextFormField(
                    initialValue: 'Nom du produit',
                    validator: (value) {
                      if (value == "") {
                        print('Erreur veuillez saisir des caratères');
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      prenom = newValue!;
                      print(prenom);
                    },
                  ),
                  TextFormField(
                    controller: tva,
                    validator: (value) {
                      if (double.parse(value!) < 0) {
                        print('Erreur chiffre en dessous de 0');
                      }
                      return null;
                    },
                    onChanged: (newValue) {},
                    onSaved: (newValue) {
                      tvaText = newValue;
                      print(tvaText);
                    },
                  ),
                  TextFormField(
                    controller: prixTTC,
                    validator: (value) {
                      if (double.parse(value!) < 0) {
                        print('Erreur chiffre en dessous de 0');
                      }
                      return null;
                    },
                    onChanged: (newValue) {
                      compteur();
                    },
                    onSaved: (newValue) {
                      prixTTCText = newValue;
                      print(prixTTC);
                    },
                  ),
                  TextFormField(
                    controller: prix,
                    onChanged: (value) => compteur(),
                    enabled: false,
                    onSaved: (newValue) {
                      prixText = newValue;
                      print(prixText);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: compteur,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
