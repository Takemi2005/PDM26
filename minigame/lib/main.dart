import 'package:flutter/material.dart';
import 'dart:math'; // PASSO 2 ✅

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: JogoApp(), // PASSO 1 ✅
  ));
}

class JogoApp extends StatefulWidget { // PASSO 1 ✅
  @override
  _JogoAppState createState() => _JogoAppState();
}

class _JogoAppState extends State<JogoApp> {

  // PASSO 3 ✅
  IconData iconeComputador = Icons.device_unknown;
  String resultado = "Escolha uma opção";
  int pontosJogador = 0;
  int pontosComputador = 0;
  List opcoes = ["pedra", "papel", "tesoura"];

  // PASSO 9 ✅ — Resetar placar manualmente
  void resetarPlacar() {
    setState(() {
      pontosJogador = 0;
      pontosComputador = 0;
      resultado = "Escolha uma opção";
      iconeComputador = Icons.device_unknown;
    });
  }

  // PASSO 4 ✅ — Função principal do jogo
  void jogar(String escolhaUsuario) {
    var numero = Random().nextInt(3); // PASSO 4 ✅
    var escolhaComputador = opcoes[numero];

    setState(() {

      // PASSO 5 ✅ — Ícone do computador
      if (escolhaComputador == "pedra") {
        iconeComputador = Icons.landscape;
      }
      if (escolhaComputador == "papel") {
        iconeComputador = Icons.pan_tool;
      }
      if (escolhaComputador == "tesoura") {
        iconeComputador = Icons.content_cut;
      }

      // PASSO 6 ✅ — Lógica do jogo
      if (escolhaUsuario == escolhaComputador) {
        resultado = "Empate";
      } else if (
        (escolhaUsuario == "pedra"   && escolhaComputador == "tesoura") ||
        (escolhaUsuario == "papel"   && escolhaComputador == "pedra")   ||
        (escolhaUsuario == "tesoura" && escolhaComputador == "papel")
      ) {
        pontosJogador++;
        resultado = "Você venceu!";

        // PASSO 7 ✅ — Campeonato: jogador chegou a 5
        if (pontosJogador >= 5) {
          resultado = "🏆 Você ganhou o campeonato!";
          pontosJogador = 0;
          pontosComputador = 0;
        }
      } else {
        pontosComputador++;
        resultado = "Computador venceu!";

        // PASSO 7 ✅ — Campeonato: computador chegou a 5
        if (pontosComputador >= 5) {
          resultado = "💻 Computador ganhou o campeonato!";
          pontosJogador = 0;
          pontosComputador = 0;
        }
      }
    });
  }

  // PASSO 8 ✅ — Interface
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedra Papel Tesoura"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Computador", style: TextStyle(fontSize: 20)),
            Icon(iconeComputador, size: 100),
            SizedBox(height: 16),
            Text(
              resultado,
              style: TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Você: $pontosJogador | PC: $pontosComputador",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.landscape),
                  iconSize: 60,
                  tooltip: "Pedra",
                  onPressed: () => jogar("pedra"),
                ),
                IconButton(
                  icon: Icon(Icons.pan_tool),
                  iconSize: 60,
                  tooltip: "Papel",
                  onPressed: () => jogar("papel"),
                ),
                IconButton(
                  icon: Icon(Icons.content_cut),
                  iconSize: 60,
                  tooltip: "Tesoura",
                  onPressed: () => jogar("tesoura"),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // PASSO 9 ✅ — Botão resetar
            ElevatedButton.icon(
              onPressed: resetarPlacar,
              icon: Icon(Icons.refresh),
              label: Text("Resetar Placar"),
            ),
          ],
        ),
      ),
    );
  }
}