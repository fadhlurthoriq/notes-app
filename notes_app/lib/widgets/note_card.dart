import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../blocs/note_bloc.dart';
import '../pages/add_note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onDelete;
  final NoteBloc noteBloc;

  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.noteBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotePage(
                noteBloc: noteBloc,
                note: note,
              ),
            ),
          );
        },
      ),
    );
  }
}
