// import 'package:flutter/material.dart';
// import 'package:setnotes/note.dart';
// import 'package:setnotes/notecard.dart';

// class StaggeredGridView extends StatelessWidget {
//   final List<Note> notes;
//   final Function(String) onNoteDeleted;
//   final Function(Note) onNoteEdited; // Add this callback

//   const StaggeredGridView({
//     super.key,
//     required this.notes,
//     required this.onNoteDeleted,
//     required this.onNoteEdited, // Require the callback
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 8,
//         mainAxisSpacing: 8,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: notes.length,
//       itemBuilder: (context, index) {
//         return NoteCard(
//           note: notes[index],
//           onNoteDeleted: onNoteDeleted,
//           onNoteEdited: onNoteEdited, // Pass the callback
//         );
//       },
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:setnotes/note.dart';
import 'package:setnotes/notecard.dart';

class StaggeredGridView extends StatelessWidget {
  final List<Note> notes;
  final Function(String) onNoteDeleted;
  final Function(Note) onNoteEdited; // Add this callback

  const StaggeredGridView({
    super.key,
    required this.notes,
    required this.onNoteDeleted,
    required this.onNoteEdited, // Require the callback
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteCard(
          note: notes[index],
          onNoteDeleted: onNoteDeleted,
          onNoteEdited: onNoteEdited, // Pass the callback
        );
      },
    );
  }
}