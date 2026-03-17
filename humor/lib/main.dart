import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HumorAPP())); 
}

class HumorAPP extends StatefulWidget {
  @override
  _HumorAPPState createState() => _HumorAPPState();
}

class _HumorAPPState extends State<HumorAPP>{
  int humorIndex = 0;
  List<String> humores = ["Feliz", "Neutro", "Bravo"];
  List<IconData> icons = [Icons.sentiment_very_satisfied, Icons.sentiment_neutral, Icons.sentiment_very_dissatisfied];
  List<Color> cores = [Colors.green, Colors.blue, Colors.red];

  void alternarHumor() {
    setState(() {
      humorIndex = (humorIndex + 1) % humores.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cores[humorIndex].withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: cores[humorIndex],
        title: Text("Humor: ${humores[humorIndex]}", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icons[humorIndex], size: 100, color: cores[humorIndex]),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: alternarHumor,
              style: ElevatedButton.styleFrom(backgroundColor: cores[humorIndex]),
              child: Text("Alterar Humor", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}