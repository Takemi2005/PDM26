import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListaContatosPage(),
  ));
}

class Contato {
  final String nome;
  final String telefone;
  final IconData icone;
  final Color cor;

  Contato({
    required this.nome,
    required this.telefone,
    required this.icone,
    required this.cor,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Contatos',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListaContatosPage(),
    );
  }
}

class ListaContatosPage extends StatelessWidget {
  final List<Contato> contatos = [
    Contato(nome: 'Mary', telefone: '(11) 91234-5678', icone: Icons.person, cor: Colors.red),
    Contato(nome: 'Lulu', telefone: '(21) 92345-6789', icone: Icons.person_outline, cor: Colors.green),
    Contato(nome: 'BIBI', telefone: '(31) 93456-7890', icone: Icons.face, cor: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contatos')),
      body: ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) {
      final contato = contatos[index];
      return Card(
      color: contato.cor.withOpacity(0.12),
      child: ListTile(
      leading: Icon(contato.icone, color: contato.cor),
      title: Text(contato.nome),
      subtitle: Text(contato.telefone),
      onTap: () {
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => DetalheContato(
      nome: contato.nome,
      telefone: contato.telefone,
      cor: contato.cor,
      icone: contato.icone,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetalheContato extends StatelessWidget {
  final String nome;
  final String telefone;
  final IconData icone;
  final Color cor;

const DetalheContato({
    super.key,
    required this.nome,
    required this.telefone,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
     return Scaffold(
     appBar: AppBar(
     title: const Text('Detalhes'),
     backgroundColor: cor,
  ),

     body: Padding(
     padding: const EdgeInsets.all(16),
     child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
     ListTile(
     leading: Icon(icone, size: 48, color: cor),
     title: Text(nome, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
     subtitle: Text(telefone, style: const TextStyle(fontSize: 18)),
  ),

     const SizedBox(height: 20),
     ElevatedButton.icon(
     icon: const Icon(Icons.call),
     label: const Text('Ligar'),
     style: ElevatedButton.styleFrom(backgroundColor: cor),
     onPressed: () {
     ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text('Ligando para $nome...')),
    );
   },
 ),

     const SizedBox(height: 12),
     ElevatedButton(
     onPressed: () => Navigator.pop(context),
     child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}