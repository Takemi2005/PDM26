import 'package:flutter/material.dart';

void main() {
     runApp(MaterialApp(home: const TodoPage()));
}

class MyApp extends StatelessWidget {
     const MyApp({super.key});

@override
Widget build(BuildContext context) {
      return const MaterialApp(
home: TodoPage(),
  );
 }
}   


class TodoPage extends StatefulWidget {
     const TodoPage({super.key});

@override
State<TodoPage> createState() => _TodoPageState();
}


class _TodoPageState extends State<TodoPage> {
  @override
Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: const Text("Tarefas"),
),
    body: const Text("Em construção"),
  );
 }
}


final List<String> tarefasList = [];
final TextEditingController controller = TextEditingController();


body: Column(
children: [
TextField(
controller: controller,
),
ElevatedButton(
onPressed: () {},
child: const Text("Adicionar"),
  ),
 ],
),



void adicionarTarefa() {
    setState(() {
    tarefasList.add(controller.text);
});
controller.clear();
}


ElevatedButton(
  onPressed: adicionarTarefa,
  child: const Text("Adicionar"),
),

Expanded(
child: ListView.builder(
  itemCount: tarefasList.length,
  itemBuilder: (context, index) {

return ListTile(
   title: Text(tarefasList[index]),
    );
  },
 ),
),


void removerTarefa(int index) {
   setState(() {
tarefasList.removeAt(index);
 });
}


trailing: IconButton(
  icon: const Icon(Icons.delete),
  onPressed: () => removerTarefa(index),
),