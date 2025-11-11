import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../blocs/note_bloc.dart';

class AddNotePage extends StatefulWidget {
  final NoteBloc noteBloc;
  final Note? note; 

  const AddNotePage({
    super.key,
    required this.noteBloc,
    this.note,
  });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Note' : 'Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text(isEditing ? 'Update Note' : 'Save Note'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    final isEditing = widget.note != null;

    final newNote = Note(
      id: isEditing ? widget.note!.id : DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text,
      content: _contentController.text,
      createdAt: isEditing ? widget.note!.createdAt : DateTime.now(),
    );

    if (isEditing) {
      widget.noteBloc.updateNote(newNote);
    } else {
      widget.noteBloc.addNote(newNote);
    }

    Navigator.pop(context);
  }
}
