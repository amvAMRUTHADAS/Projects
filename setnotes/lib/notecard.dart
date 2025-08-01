// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:setnotes/note.dart'; // Import Note model



// class NoteCard extends StatelessWidget {
//   final Note note;
//   final Function(String) onNoteDeleted;
//   final Function(Note) onNoteEdited;

//   const NoteCard({
//     super.key,
//     required this.note,
//     required this.onNoteDeleted,
//     required this.onNoteEdited,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onNoteEdited(note);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: note.color,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: Colors.grey[300]!),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Display title if available
//               if (note.title.isNotEmpty)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8.0),
//                   child: Text(
//                     note.title,
//                     style: const TextStyle(
//                       color: Colors.black, // Or choose a contrasting color
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               if (note.imagePath != null)
//                 Expanded(
//                   child: CustomPaint(
//                     // You'll need to ensure DrawingPainter is imported or defined
//                     painter: DrawingPainter(note.content),
//                     child: Container(),
//                   ),
//                 )
//               else
//                 Expanded(
//                   child: Text(
//                     note.content,
//                     style: const TextStyle(
//                       color: Colors.black87,
//                       fontSize: 14,
//                       height: 1.4,
//                     ),
//                     maxLines: 10,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed to spaceBetween
//                 children: [
//                   Row(
//                     children: [
//                       // Pinned icon
//                       if (note.isPinned)
//                         const Icon(Icons.push_pin, color: Colors.black54, size: 18),
//                       // Reminder icon
//                       if (note.hasReminder)
//                         const Padding(
//                           padding: EdgeInsets.only(left: 4.0),
//                           child: Icon(Icons.notifications_active, color: Colors.black54, size: 18),
//                         ),
//                       // Archived icon (consider showing this only in an "archived" view)
//                       if (note.isArchived)
//                          const Padding(
//                           padding: EdgeInsets.only(left: 4.0),
//                           child: Icon(Icons.archive, color: Colors.black54, size: 18),
//                         ),
//                     ],
//                   ),
//                   Icon(
//                     Icons.more_vert,
//                     color: Colors.grey[600],
//                     size: 18,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Ensure DrawingPainter is defined or imported correctly
// // If not, you'll need to add it or import its file.
// class DrawingPainter extends CustomPainter {
//   final String content;

//   DrawingPainter(this.content);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..strokeWidth = 3.0
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     if (content == '•') {
//       Paint dotPaint = Paint()
//         ..color = Colors.blue
//         ..style = PaintingStyle.fill;
//       canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 4, dotPaint);
//     } else if (content == 'Dart') {
//       Path path = Path();
//       path.moveTo(size.width * 0.1, size.height * 0.2);
//       path.lineTo(size.width * 0.1, size.height * 0.5);
//       path.moveTo(size.width * 0.1, size.height * 0.2);
//       path.quadraticBezierTo(
//         size.width * 0.2,
//         size.height * 0.15,
//         size.width * 0.2,
//         size.height * 0.35,
//       );

//       path.moveTo(size.width * 0.25, size.height * 0.3);
//       path.lineTo(size.width * 0.35, size.height * 0.4);

//       path.moveTo(size.width * 0.4, size.height * 0.25);
//       path.lineTo(size.width * 0.4, size.height * 0.45);

//       path.moveTo(size.width * 0.2, size.height * 0.6);
//       path.quadraticBezierTo(
//         size.width * 0.4,
//         size.height * 0.7,
//         size.width * 0.6,
//         size.height * 0.65,
//       );

//       canvas.drawPath(path, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setnotes/note.dart'; // Import Note model



class NoteCard extends StatelessWidget {
  final Note note;
  final Function(String) onNoteDeleted;
  final Function(Note) onNoteEdited;

  const NoteCard({
    super.key,
    required this.note,
    required this.onNoteDeleted,
    required this.onNoteEdited,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onNoteEdited(note);
      },
      child: Container(
        decoration: BoxDecoration(
          color: note.color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display title if available
              if (note.title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    note.title,
                    style: const TextStyle(
                      color: Colors.black, // Or choose a contrasting color
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (note.imagePath != null)
                Expanded(
                  child: CustomPaint(
                    // You'll need to ensure DrawingPainter is imported or defined
                    painter: DrawingPainter(note.content),
                    child: Container(),
                  ),
                )
              else
                Expanded(
                  child: Text(
                    note.content,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      height: 1.4,
                    ),
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Changed to spaceBetween
                children: [
                  Row(
                    children: [
                      // Pinned icon
                      if (note.isPinned)
                        const Icon(Icons.push_pin, color: Colors.black54, size: 18),
                      // Reminder icon
                      if (note.hasReminder)
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Icon(Icons.notifications_active, color: Colors.black54, size: 18),
                        ),
                      // Archived icon (consider showing this only in an "archived" view)
                      if (note.isArchived)
                         const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Icon(Icons.archive, color: Colors.black54, size: 18),
                        ),
                    ],
                  ),
                  Icon(
                    Icons.more_vert,
                    color: Colors.grey[600],
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Ensure DrawingPainter is defined or imported correctly
// If not, you'll need to add it or import its file.
class DrawingPainter extends CustomPainter {
  final String content;

  DrawingPainter(this.content);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (content == '•') {
      Paint dotPaint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.3), 4, dotPaint);
    } else if (content == 'Dart') {
      Path path = Path();
      path.moveTo(size.width * 0.1, size.height * 0.2);
      path.lineTo(size.width * 0.1, size.height * 0.5);
      path.moveTo(size.width * 0.1, size.height * 0.2);
      path.quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.15,
        size.width * 0.2,
        size.height * 0.35,
      );

      path.moveTo(size.width * 0.25, size.height * 0.3);
      path.lineTo(size.width * 0.35, size.height * 0.4);

      path.moveTo(size.width * 0.4, size.height * 0.25);
      path.lineTo(size.width * 0.4, size.height * 0.45);

      path.moveTo(size.width * 0.2, size.height * 0.6);
      path.quadraticBezierTo(
        size.width * 0.4,
        size.height * 0.7,
        size.width * 0.6,
        size.height * 0.65,
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}