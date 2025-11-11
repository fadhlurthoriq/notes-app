import 'package:flutter/material.dart';
import '../widgets/note_card.dart';
import '../models/note_model.dart';
import '../blocs/note_bloc.dart';
import 'add_note.dart'; 

class HomePage extends StatefulWidget {
  final NoteBloc noteBloc;
  const HomePage({super.key, required this.noteBloc});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NoteBloc _noteBloc = NoteBloc();

  @override
  void dispose() {
    _noteBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: StreamBuilder<List<Note>>(
        stream: _noteBloc.notesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada catatan'));
          }

          final notes = snapshot.data!;
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteCard(
                note: note,
                onDelete: () {
                  _noteBloc.deleteNote(note.id!);
                },
                noteBloc: _noteBloc
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddNotePage(noteBloc: _noteBloc),
      ),
    );
  },
  child: const Icon(Icons.add),
),

    );
  }
}
