import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SemaforoApp(), // PASSO 2 ✅
  ));
}

class SemaforoApp extends StatefulWidget { // PASSO 2 ✅
  @override
  _SemaforoAppState createState() => _SemaforoAppState();
}

class _SemaforoAppState extends State<SemaforoApp> {
  int estado = 0;

  // PASSO 4 ✅
  void mudarSemaforo() {
    setState(() {
      estado++;
      if (estado > 2) { // 0=verde, 1=amarelo, 2=vermelho
        estado = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Semáforo de Trânsito"),
      ),
      body: Center(
        
        // PASSO 7 ✅ — Layout final com tudo junto
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // ── SEMÁFORO DE TRÂNSITO (PASSO 3) ──────────────────
            Container(
              width: 120,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // 🔴 Vermelho
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 2 ? Colors.red : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 10),
                  // 🟡 Amarelo
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 1 ? Colors.yellow : Colors.grey, // PASSO 3 ✅
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 10),
                  // 🟢 Verde
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: estado == 0 ? Colors.green : Colors.grey, // PASSO 3 ✅
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 40),

            // ── SEMÁFORO DE PEDESTRE (PASSO 5) ───────────────────
            Column(
              children: [
                Icon(
                  estado == 2 ? Icons.directions_walk : Icons.pan_tool,
                  size: 80,
                  color: estado == 2 ? Colors.green : Colors.red,
                ),
                Text(
                  estado == 2
                      ? "PEDESTRE: ATRAVESSE"
                      : "PEDESTRE: AGUARDE",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            SizedBox(height: 40),

            // ── BOTÃO (PASSO 6) ───────────────────────────────────
            ElevatedButton(
              onPressed: mudarSemaforo, // PASSO 6 ✅
              child: Text("Mudar Semáforo"),
            ),

          ],
        ),
      ),
    );
  }
}
