import 'package:flutter/material.dart';
import 'blocs/note_bloc.dart';
import 'pages/homepage.dart';
import 'pages/add_note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NoteBloc _noteBloc = NoteBloc(); // 🔹 buat satu instance bloc

  @override
  void dispose() {
    _noteBloc.dispose(); // 🔹 tutup stream kalau app ditutup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // 🔹 Routing konfigurasi
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(noteBloc: _noteBloc),
        '/add-note': (context) => AddNotePage(noteBloc: _noteBloc),
      },
    );
  }
}
