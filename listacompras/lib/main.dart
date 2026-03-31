import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      useMaterial3: true,
    ),
    home: ListaCompras(),
  ));
}

class ListaCompras extends StatefulWidget {
  @override
  _ListaComprasState createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  
  List<String> itens = [];
  List<bool> comprado = [];
  TextEditingController controller = TextEditingController();

  
  void adicionarItem() {
    if (controller.text.isNotEmpty) {
      setState(() {
        itens.add(controller.text);
        comprado.add(false);
        controller.clear();
      });
      salvarDados();
    }
  }

  
  void alternarComprado(int index) {
    setState(() {
      comprado[index] = !comprado[index]; 
    });
    salvarDados();
  }

  
  void removerItem(int index) {
    setState(() {
      itens.removeAt(index);
      comprado.removeAt(index);
    });
    salvarDados();
  }

  
  void limparLista() {
    setState(() {
      itens.clear();
      comprado.clear();
    });
    salvarDados();
  }

  
  void salvarDados() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("itens", itens);
    prefs.setStringList(
      "comprado",
      comprado.map((e) => e.toString()).toList(), 
    );
  }

  
  void carregarDados() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      itens = prefs.getStringList("itens") ?? [];
      List<String> listaBool = prefs.getStringList("comprado") ?? [];
      comprado = listaBool.map((e) => e == "true").toList(); // "true" → true
    });
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  // ── Contador de itens pendentes ──
  int get itensPendentes => comprado.where((c) => !c).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(
          itens.isEmpty
              ? "Lista de Compras"
              : "Compras ($itensPendentes restantes)",
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          
            IconButton(
              icon: Icon(Icons.delete_sweep),
              tooltip: "Limpar lista",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Limpar lista?"),
                    content: Text("Todos os itens serão removidos."),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () {
                          limparLista();
                          Navigator.pop(ctx);
                        },
                        child: Text("Limpar"),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "Adicionar item",
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => adicionarItem(),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: adicionarItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  ),
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),

          
          if (itens.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${comprado.where((c) => c).length} de ${itens.length} comprados",
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: itens.isEmpty
                        ? 0
                        : comprado.where((c) => c).length / itens.length,
                    backgroundColor: Colors.grey[200],
                    color: Colors.teal,
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),

          Expanded(
            child: itens.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.shopping_cart_outlined,
                            size: 64, color: Colors.grey[300]),
                        SizedBox(height: 12),
                        Text(
                          "Lista vazia",
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: itens.length,
                    itemBuilder: (context, index) {
                      final estaComprado = comprado[index];
                      return ListTile(
                        
                        tileColor: estaComprado
                            ? Colors.green.shade50
                            : null,
                        leading: Checkbox(
                          value: estaComprado,
                          activeColor: Colors.teal,
                          onChanged: (_) => alternarComprado(index),
                        ),
                        title: Text(
                          itens[index],
                          style: TextStyle(
                            
                            decoration: estaComprado
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: estaComprado
                                ? Colors.grey
                                : Colors.black87,
                          ),
                        ),
                        onTap: () => alternarComprado(index),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red[300]),
                          onPressed: () => removerItem(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}