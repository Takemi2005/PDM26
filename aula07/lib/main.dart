import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: TelaInicial(),
  ));
}

//-------------------- tela 1-----------------------

class TelaInicial extends StatelessWidget {

   final String nome = "luiza"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Ir para a Tela 2"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SegundaTela(nome: nome)),
              
            );
          },

        ),
      ),
    );
  }
}
//-------------------- tela 2-----------------------

class SegundaTela extends StatelessWidget {

  final String nome;

  SegundaTela({required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Segunda Tela'),
        backgroundColor: Colors.green,
      ),
      body: Center(
      child: Text("Olá, $nome!", style: TextStyle(fontSize: 24),),
      ),
    );
  }
}
