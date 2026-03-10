import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: interruptorAPP()));
}

class interruptorAPP extends StatefulWidget {
  @override
  _InterruptorAPPState createState() => _InterruptorAPPState();
}

class _InterruptorAPPState extends State<interruptorAPP>{
  bool estaAceso = false;

  void alternarLuz() {
    setState(() {
      estaAceso = !estaAceso;
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: estaAceso ? Colors.black : Colors.white,

      appBar: AppBar(
        backgroundColor: estaAceso ? Colors.white : Colors.black,
        title: Text("Interruptor", style: TextStyle(color: estaAceso ? Colors.white : Colors.black
        ),
        ),
      ),




    body: Center(
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
       children: [
       Icon(
        estaAceso ? Icons.lightbulb : Icons.lightbulb_outline,
       size: 100,
       color: estaAceso ? Colors.yellow : Colors.grey,
       ),

       ElevatedButton(
        onPressed: alternarLuz,
        style: ElevatedButton.styleFrom(
        backgroundColor: estaAceso ? Colors.white : Colors.black,
        
        ),
        child: Text(
          "Interruptor",
          style: TextStyle(color: estaAceso ? Colors.black : Colors.white
        ),
        ),
       )
      ],
     ),
    ),
  );
 }
}