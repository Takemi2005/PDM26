import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TemperaturaApp(), // PASSO 2 ✅
  ));
}

class TemperaturaApp extends StatefulWidget { // PASSO 2 ✅
  @override
  _TemperaturaAppState createState() => _TemperaturaAppState();
}

class _TemperaturaAppState extends State<TemperaturaApp> {
  int temperatura = 20;

  // PASSO 3 ✅
  void aumentar() {
    setState(() {
      temperatura++;
    });
  }

  // PASSO 4 ✅
  void diminuir() {
    setState(() {
      temperatura--;
    });
  }

  @override
  Widget build(BuildContext context) {

    // PASSO 6 ✅ — Lógica de temperatura (declarada dentro do build)
    Color corFundo;
    IconData icone;
    String status;

    if (temperatura < 15) {
      corFundo = Colors.blue;
      icone = Icons.ac_unit;
      status = "Frio";
    } else if (temperatura < 30) {
      corFundo = Colors.green;
      icone = Icons.wb_sunny;
      status = "Agradável";
    } else {
      corFundo = Colors.red;
      icone = Icons.local_fire_department;
      status = "Quente";
    }

    return Scaffold(
      backgroundColor: corFundo, // PASSO 7 ✅
      appBar: AppBar(
        title: Text("Controle de Temperatura"),
      ),
      body: Center(
        
        // PASSO 5 ✅ — Interface completa
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // PASSO 7 ✅ — Ícone dinâmico
            Icon(
              icone,
              size: 100,
              color: Colors.white,
            ),

            SizedBox(height: 20),

            // PASSO 7 ✅ — Status (Frio / Agradável / Quente)
            Text(
              status,
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),

            SizedBox(height: 20),

            // Temperatura em °C
            Text(
              "$temperatura °C",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),

            SizedBox(height: 20),

            // Botões + e -
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: diminuir,
                  child: Text("-"),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: aumentar,
                  child: Text("+"),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
