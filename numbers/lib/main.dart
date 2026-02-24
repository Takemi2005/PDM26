import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(home: const RandomNumberScreen()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RandomNumberScreen(),
    );
  }
}

class RandomNumberScreen extends StatefulWidget {
  const RandomNumberScreen({Key? key}) : super(key: key);

  @override
  State<RandomNumberScreen> createState() => _RandomNumberScreenState();
}

class _RandomNumberScreenState extends State<RandomNumberScreen> {
  int? randomNumber;

  void generateRandomNumber() {
    setState(() {
      randomNumber = Random().nextInt(10) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Número Aleatório')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (randomNumber != null)
              Text(
                '$randomNumber',
                style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
              )
            else
              const Text('Clique no botão para gerar'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateRandomNumber,
              child: const Text('Gerar Número'),
            ),
          ],
        ),
      ),
    );
  }
}