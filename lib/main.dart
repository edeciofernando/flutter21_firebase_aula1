import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Artistas'),
        ),
        body: Center(
          child: Container(
            child: Text('Testes Firebase - Alteração'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
//          onPressed: () { print("Testando..."); },
          // onPressed: adicionar,
          // onPressed: listar,
//          onPressed: refresh,
          onPressed: alterar2,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  CollectionReference cfArtistas =
      FirebaseFirestore.instance.collection("artistas");

  Future<void> adicionar() async {
    await Firebase.initializeApp();

    cfArtistas.add({
      "nome": "Julia Roberts",
      "pais": "Estados Unidos",
      "idade": 53,
    });
  }

  Future<void> listar() async {
    await Firebase.initializeApp();

    // obtém todos os documentos da coleção
    QuerySnapshot querySnapshot = await cfArtistas.get();

    querySnapshot.docs.forEach((artista) {
      print("-----------------------------------");
      print(artista.id); // id do documento
      print(artista.data()); // todos os atributos do objeto
      print(artista.get("nome"));
      print(artista.get("pais"));
      print('${artista.get("idade")} anos');
    });
  }

  // com o listen, quando houver alguma alteração nos dados, o método é novamente executado
  Future<void> refresh() async {
    await Firebase.initializeApp();

    cfArtistas.snapshots().listen((artistas) {
      artistas.docs.forEach((artista) {
        print("==================================");
        print(artista.id); // id do documento
        print(artista.get("nome"));
        print(artista.get("pais"));
        print('${artista.get("idade")} anos');
      });
    });
  }

  Future<void> alterar() async {
    await Firebase.initializeApp();

    cfArtistas.doc("2zzeWI1b7SaFMV5CawQv").set({
      "nome": "Julia Roberts",
      "pais": "Estados Unidos/CA",
      "idade": 54,
    });
  }

  Future<void> alterar2() async {
    await Firebase.initializeApp();

    cfArtistas.doc("2zzeWI1b7SaFMV5CawQv").update({
      "idade": 53,
      "classe": "Atriz"
    });
  }
}
