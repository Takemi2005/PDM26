import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart'; // 5° Persistência
import 'package:path/path.dart';


void main() {
  runApp(MaterialApp(home: NotesApp()));
}

class DatabaseHelper { // 6° Organização do Código
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, description TEXT)', // Tabela obrigatória
        );
      },
    );
  }

  Future<List<Map>> getNotes() async {
    final db = await database;
    return db.query('notes');
  }

  Future<void> insertNote(String title, String description) async {
    final db = await database;
    await db.insert('notes', {'title': title, 'description': description}); 
  }

  Future<void> updateNote(int id, String title, String description) async {
    final db = await database;
    await db.update('notes', {'title': title, 'description': description},
        where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id]); 
  }
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState(); 
}

class _NotesAppState extends State<NotesApp> { //  1° Cadastro (Create) 
  final _titleController = TextEditingController(); 
  final _descriptionController = TextEditingController(); 
  List<Map> _notes = [];
  int? _editingId;

  @override
  void initState() {
  super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await DatabaseHelper().getNotes();
    setState(() => _notes = notes);
  }

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty) return;

    if (_editingId == null) {
      await DatabaseHelper()
          .insertNote(_titleController.text, _descriptionController.text);
    } else {
      await DatabaseHelper().updateNote(
          _editingId!, _titleController.text, _descriptionController.text);
      _editingId = null;
    }

    _titleController.clear();
    _descriptionController.clear();
    _loadNotes();
  }

  Future<void> _deleteNote(int id) async { // 3° Remoção (Delete)
    await DatabaseHelper().deleteNote(id);
    _loadNotes(); // Atualiza lista 
  }

  void _editNote(Map note) { // 4°Edição (Update)
    _titleController.text = note['title'];
    _descriptionController.text = note['description'];
    _editingId = note['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Título'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Descrição'),
                ),
                ElevatedButton(
                  onPressed: _saveNote,
                  child: Text(_editingId == null ? 'Salvar' : 'Atualizar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder( //  2°Listagem (Read)
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note['title']),
                  subtitle: Text(note['description']),
                  onTap: () => _editNote(note),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteNote(note['id']),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}