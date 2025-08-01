// import 'package:flutter/material.dart';
// import 'package:setnotes/keepnote.dart';
// import 'package:setnotes/splashscreen.dart'; // Ensure this file exists

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Keep Notes',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: const Color(0xFF202124),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF202124),
//           elevation: 0,
//         ),
//       ),
//       home: SplashScreen(), // Start with splash screen
//       debugShowCheckedModeBanner: false,
//       routes: {
//         '/home': (context) => const KeepNotesApp(),
//       },
//     );
//   }
// }

// // lib/note.dart


// class Note {
//   String id;
//   String title;
//   String content;
//   DateTime createdTime;
//   bool isPinned;
//   bool hasReminder;
//   bool isArchived;
//   Color color;
//   String? imagePath; // <--- Add this line for image/drawing path

//   Note({
//     required this.id,
//     this.title = '',
//     this.content = '',
//     required this.createdTime,
//     this.isPinned = false,
//     this.hasReminder = false,
//     this.isArchived = false,
//     this.color = Colors.white,
//     this.imagePath, // <--- Add this to the constructor
//   });

//   // You might also need methods to convert Note to/from JSON for persistence
//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'title': title,
//         'content': content,
//         'createdTime': createdTime.toIso8601String(),
//         'isPinned': isPinned,
//         'hasReminder': hasReminder,
//         'isArchived': isArchived,
//         'colorValue': color.value, // Store color as int value
//         'imagePath': imagePath, // <--- Include imagePath in JSON
//       };

//   factory Note.fromJson(Map<String, dynamic> json) => Note(
//         id: json['id'],
//         title: json['title'] ?? '',
//         content: json['content'] ?? '',
//         createdTime: DateTime.parse(json['createdTime']),
//         isPinned: json['isPinned'] ?? false,
//         hasReminder: json['hasReminder'] ?? false,
//         isArchived: json['isArchived'] ?? false,
//         color: Color(json['colorValue'] ?? Colors.white.value),
//         imagePath: json['imagePath'], // <--- Retrieve imagePath from JSON
//       );
// }



import 'package:flutter/material.dart';
import 'package:setnotes/keepnote.dart';
import 'package:setnotes/splashscreen.dart'; // Ensure this file exists

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF202124),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF202124),
          elevation: 0,
        ),
      ),
      home: SplashScreen(), // Start with splash screen
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => const KeepNotesApp(),
      },
    );
  }
}

// lib/note.dart


class Note {
  String id;
  String title;
  String content;
  DateTime createdTime;
  bool isPinned;
  bool hasReminder;
  bool isArchived;
  Color color;
  String? imagePath; // <--- Add this line for image/drawing path

  Note({
    required this.id,
    this.title = '',
    this.content = '',
    required this.createdTime,
    this.isPinned = false,
    this.hasReminder = false,
    this.isArchived = false,
    this.color = Colors.white,
    this.imagePath, // <--- Add this to the constructor
  });

  // You might also need methods to convert Note to/from JSON for persistence
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdTime': createdTime.toIso8601String(),
        'isPinned': isPinned,
        'hasReminder': hasReminder,
        'isArchived': isArchived,
        'colorValue': color.value, // Store color as int value
        'imagePath': imagePath, // <--- Include imagePath in JSON
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'] ?? '',
        content: json['content'] ?? '',
        createdTime: DateTime.parse(json['createdTime']),
        isPinned: json['isPinned'] ?? false,
        hasReminder: json['hasReminder'] ?? false,
        isArchived: json['isArchived'] ?? false,
        color: Color(json['colorValue'] ?? Colors.white.value),
        imagePath: json['imagePath'], // <--- Retrieve imagePath from JSON
      );
}
