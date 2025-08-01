// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:setnotes/note.dart';
// import 'package:image_picker/image_picker.dart'; // Import image_picker
// import 'dart:io'; // Required for File operations
// import 'package:path_provider/path_provider.dart'; // For getting app's document directory
// import 'dart:ui' as ui; // For image manipulation in drawing screen
// import 'package:flutter/rendering.dart'; // For RepaintBoundary in drawing screen


// class NoteEditScreen extends StatefulWidget {
//   final Note note;
//   final VoidCallback onNoteUpdated;
//   final Function(String) onNoteDeleted;

//   const NoteEditScreen({
//     super.key,
//     required this.note,
//     required this.onNoteUpdated,
//     required this.onNoteDeleted,
//   });

//   @override
//   _NoteEditScreenState createState() => _NoteEditScreenState();
// }

// class _NoteEditScreenState extends State<NoteEditScreen> {
//   late TextEditingController _contentController;
//   late TextEditingController _titleController;
//   late bool _currentIsPinned;
//   late bool _currentHasReminder;
//   late bool _currentIsArchived;
//   String? _currentImagePath; // New state variable for image path

//   @override
//   void initState() {
//     super.initState();
//     _contentController = TextEditingController(text: widget.note.content);
//     _titleController = TextEditingController(text: widget.note.title);
//     _currentIsPinned = widget.note.isPinned;
//     _currentHasReminder = widget.note.hasReminder;
//     _currentIsArchived = widget.note.isArchived;
//     // Initialize _currentImagePath from the note model's imagePath
//     _currentImagePath = widget.note.imagePath; 

//     _titleController.addListener(_saveNoteOnTextChange);
//     _contentController.addListener(_saveNoteOnTextChange);
//   }

//   @override
//   void dispose() {
//     _titleController.removeListener(_saveNoteOnTextChange);
//     _contentController.removeListener(_saveNoteOnTextChange);
//     _contentController.dispose();
//     _titleController.dispose();
//     super.dispose();
//   }

//   void _startDrawing() {
//     Navigator.pop(context); // Close the bottom sheet
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => DrawingScreen(
//           onDrawingComplete: (String drawingPath) {
//             setState(() {
//               _currentImagePath = drawingPath;
//             });
//             _saveNote(); // Save the note with the new image path
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Drawing saved!'),
//                 backgroundColor: Color(0xFF303134),
//                 duration: Duration(seconds: 1),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void _saveNoteOnTextChange() {
//     _saveNote();
//   }

//   void _saveNote() {
//     widget.note.content = _contentController.text;
//     widget.note.title = _titleController.text;
//     widget.note.isPinned = _currentIsPinned;
//     widget.note.hasReminder = _currentHasReminder;
//     widget.note.isArchived = _currentIsArchived;
//     // Save the image path to the Note model
//     widget.note.imagePath = _currentImagePath; 
//     widget.onNoteUpdated(); // Notify parent to persist the updated note
//   }

//   void _togglePin() {
//     setState(() {
//       _currentIsPinned = !_currentIsPinned;
//       _saveNote();
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(_currentIsPinned ? 'Note pinned' : 'Note unpinned'),
//         backgroundColor: const Color(0xFF303134),
//         duration: const Duration(seconds: 1),
//       ),
//     );
//   }

//   void _deleteNote() {
//     widget.onNoteDeleted(widget.note.id);
//     // Optionally, delete the associated image file here
//     if (_currentImagePath != null && File(_currentImagePath!).existsSync()) {
//       try {
//         File(_currentImagePath!).deleteSync();
//         print('Deleted image file: $_currentImagePath');
//       } catch (e) {
//         print('Error deleting image file: $e');
//       }
//     }
//     Navigator.pop(context);
//   }

//   void _showDeleteDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: const Color.fromARGB(255, 78, 77, 73),
//           title: const Text(
//             'Delete note?',
//             style: TextStyle(color: Colors.white),
//           ),
//           content: Text(
//             'This note will be deleted permanently.',
//             style: TextStyle(color: Colors.grey[300]),
//           ),
//           actions: [
//             TextButton(
//               child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: const Text('Delete', style: TextStyle(color: Colors.red)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _deleteNote();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Helper function to save image files to app's document directory
//   Future<String?> _saveImageToFile(XFile? xFile) async {
//     if (xFile == null) return null;
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${xFile.name}';
//       final String newPath = '${directory.path}/$fileName';
//       final File newFile = await File(xFile.path).copy(newPath);
//       return newFile.path;
//     } catch (e) {
//       print("Error saving image to file: $e");
//       return null;
//     }
//   }

//   Future<void> _pickImage() async {
//     Navigator.pop(context); // Close the bottom sheet
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);

//     if (image != null) {
//       final String? savedPath = await _saveImageToFile(image);
//       if (savedPath != null) {
//         setState(() {
//           _currentImagePath = savedPath; // Store the permanent path
//         });
//         _saveNote(); // Save the note with the new image path
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Image selected: ${savedPath.split('/').last}'),
//             backgroundColor: const Color(0xFF303134),
//             duration: const Duration(seconds: 1),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to save image.'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No image selected'),
//           backgroundColor: Color(0xFF303134),
//           duration: Duration(seconds: 1),
//         ),
//       );
//     }
//   }

//   Future<void> _takePhoto() async {
//     Navigator.pop(context); // Close the bottom sheet
//     final ImagePicker picker = ImagePicker();
//     final XFile? photo = await picker.pickImage(source: ImageSource.camera);

//     if (photo != null) {
//       final String? savedPath = await _saveImageToFile(photo);
//       if (savedPath != null) {
//         setState(() {
//           _currentImagePath = savedPath; // Store the permanent path
//         });
//         _saveNote(); // Save the note with the new image path
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Photo taken: ${savedPath.split('/').last}'),
//             backgroundColor: const Color(0xFF303134),
//             duration: const Duration(seconds: 1),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Failed to save photo.'),
//             backgroundColor: Colors.red,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No photo taken'),
//           backgroundColor: Color(0xFF303134),
//           duration: Duration(seconds: 1),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF202124),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF202124),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             _saveNote();
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _currentIsPinned ? Icons.push_pin : Icons.push_pin_outlined,
//               color: _currentIsPinned ? Colors.blue : Colors.white,
//             ),
//             onPressed: _togglePin,
//           ),
//           IconButton(
//             icon: const Icon(Icons.delete_outline, color: Colors.white),
//             onPressed: _showDeleteDialog,
//           ),
//           IconButton(
//             icon: const Icon(Icons.add_box_outlined, color: Colors.white),
//             onPressed: _showAddOptions,
//           ),
//           IconButton(
//             icon: const Icon(Icons.palette_outlined, color: Colors.white),
//             onPressed: _showColorPicker,
//           ),
//           IconButton(
//             icon: const Icon(Icons.text_format, color: Colors.white),
//             onPressed: _showTextFormatting,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//               ),
//               decoration: InputDecoration(
//                 hintText: 'Title',
//                 hintStyle: TextStyle(color: Colors.grey[500]),
//                 border: InputBorder.none,
//               ),
//             ),
//             // Display the image/drawing if a path exists and the file exists
//             if (_currentImagePath != null && File(_currentImagePath!).existsSync())
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0),
//                 child: Image.file(
//                   File(_currentImagePath!),
//                   height: 150,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             Expanded(
//               child: TextField(
//                 controller: _contentController,
//                 style: const TextStyle(color: Colors.white, fontSize: 16),
//                 maxLines: null,
//                 expands: true,
//                 textAlignVertical: TextAlignVertical.top,
//                 decoration: InputDecoration(
//                   hintText: 'Note',
//                   hintStyle: TextStyle(color: Colors.grey[500]),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 50,
//         color: const Color(0xFF202124),
//         child: Row(
//           children: [
//             const Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(right: 16),
//               child: Text(
//                 'Edited ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
//                 style: TextStyle(color: Colors.grey[500], fontSize: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showAddOptions() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF303134),
//       builder: (context) => SizedBox(
//         height: 200,
//         child: Column(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.image, color: Colors.white),
//               title: const Text('Add image',
//                   style: TextStyle(color: Colors.white)),
//               onTap: _pickImage, // Call the image picker
//             ),
//             ListTile(
//               leading:
//                   const Icon(Icons.camera_alt_outlined, color: Colors.white),
//               title: const Text('Take photo',
//                   style: TextStyle(color: Colors.white)),
//               onTap: _takePhoto, // Call the new _takePhoto function
//             ),
//             ListTile(
//               leading: const Icon(Icons.draw_outlined, color: Colors.white),
//               title:
//                   const Text('Drawing', style: TextStyle(color: Colors.white)),
//               onTap: _startDrawing, // Call the new _startDrawing function
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showColorPicker() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF303134),
//       builder: (context) => Container(
//         height: 120,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const Text('Choose color',
//                 style: TextStyle(color: Colors.white, fontSize: 16)),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _colorOption(Colors.white),
//                 _colorOption(Colors.red[100]!),
//                 _colorOption(Colors.orange[100]!),
//                 _colorOption(Colors.yellow[100]!),
//                 _colorOption(Colors.green[100]!),
//                 _colorOption(Colors.blue[100]!),
//                 _colorOption(Colors.purple[100]!),
//                 _colorOption(const Color.fromARGB(255, 165, 17, 99)),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _colorOption(Color color) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           widget.note.color = color;
//         });
//         _saveNote();
//         Navigator.pop(context);
//       },
//       child: Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.grey[600]!),
//         ),
//       ),
//     );
//   }

//   void _showTextFormatting() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color(0xFF303134),
//       builder: (context) => SizedBox(
//         height: 200,
//         child: Column(
//           children: [
//             ListTile(
//               leading:
//                   const Icon(Icons.format_list_bulleted, color: Colors.white),
//               title: const Text('Bullet list',
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 _contentController.text += '\n• ';
//                 _contentController.selection = TextSelection.fromPosition(
//                   TextPosition(offset: _contentController.text.length),
//                 );
//                 _saveNote();
//               },
//             ),
//             ListTile(
//               leading:
//                   const Icon(Icons.format_list_numbered, color: Colors.white),
//               title: const Text('Numbered list',
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 _contentController.text += '1. ';
//                 _contentController.selection = TextSelection.fromPosition(
//                   TextPosition(offset: _contentController.text.length),
//                 );
//                 _saveNote();
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.check_box, color: Colors.white),
//               title: const Text('Add checklist',
//                   style: TextStyle(color: Colors.white)),
//               onTap: () {
//                 Navigator.pop(context);
//                 _contentController.text += '☐ ';
//                 _contentController.selection = TextSelection.fromPosition(
//                   TextPosition(offset: _contentController.text.length),
//                 );
//                 _saveNote();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DrawingScreen extends StatefulWidget {
//   final Function(String) onDrawingComplete;

//   const DrawingScreen({super.key, required this.onDrawingComplete});

//   @override
//   _DrawingScreenState createState() => _DrawingScreenState();
// }

// class _DrawingScreenState extends State<DrawingScreen> {
//   List<Offset?> points = <Offset?>[];
//   Color selectedColor = Colors.black;
//   double strokeWidth = 2.0;
//   final GlobalKey _drawingKey = GlobalKey(); // Key to capture the drawing widget

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF202124),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF202124),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Drawing', style: TextStyle(color: Colors.white)),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.clear, color: Colors.white),
//             onPressed: _clearDrawing,
//           ),
//           IconButton(
//             icon: const Icon(Icons.check, color: Colors.green),
//             onPressed: _saveDrawing,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Drawing tools
//           Container(
//             height: 130,
//             color: const Color(0xFF303134),
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 // Color picker
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildColorButton(Colors.black),
//                     _buildColorButton(Colors.red),
//                     _buildColorButton(Colors.blue),
//                     _buildColorButton(Colors.green),
//                     _buildColorButton(Colors.yellow),
//                     _buildColorButton(Colors.purple),
//                     _buildColorButton(Colors.orange),
//                     _buildColorButton(Colors.pink),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 // Stroke width slider
//                 Row(
//                   children: [
//                     const Text('Brush size:',
//                         style: TextStyle(color: Colors.white)),
//                     Expanded(
//                       child: Slider(
//                         value: strokeWidth,
//                         min: 1.0,
//                         max: 10.0,
//                         divisions: 9,
//                         activeColor: Colors.white,
//                         onChanged: (value) =>
//                             setState(() => strokeWidth = value),
//                       ),
//                     ),
//                     Text('${strokeWidth.toInt()}',
//                         style: const TextStyle(color: Colors.white)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           // Drawing canvas
//           Expanded(
//             child: Container(
//               width: double.infinity,
//               color: Colors.white,
//               // Wrap with RepaintBoundary to capture the drawing
//               child: RepaintBoundary(
//                 key: _drawingKey, // Assign the GlobalKey
//                 child: GestureDetector(
//                   onPanStart: (details) {
//                     setState(() {
//                       points.add(details.localPosition);
//                     });
//                   },
//                   onPanUpdate: (details) {
//                     setState(() {
//                       points.add(details.localPosition);
//                     });
//                   },
//                   onPanEnd: (details) {
//                     setState(() {
//                       points.add(null); // Add null to separate strokes
//                     });
//                   },
//                   child: CustomPaint(
//                     painter: DrawingPainter(points, selectedColor, strokeWidth),
//                     size: Size.infinite,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildColorButton(Color color) {
//     return GestureDetector(
//       onTap: () => setState(() => selectedColor = color),
//       child: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: color,
//           shape: BoxShape.circle,
//           border: selectedColor == color
//               ? Border.all(color: Colors.white, width: 3)
//               : Border.all(color: Colors.grey, width: 1),
//         ),
//       ),
//     );
//   }

//   void _clearDrawing() {
//     setState(() {
//       points.clear();
//     });
//   }

//   Future<void> _saveDrawing() async {
//     try {
//       // Find the render object associated with the _drawingKey
//       RenderRepaintBoundary boundary =
//           _drawingKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

//       // Convert the boundary to an image
//       ui.Image image = await boundary.toImage(pixelRatio: 3.0); // Adjust pixelRatio for quality

//       // Get the byte data in PNG format
//       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//       if (byteData == null) {
//         print("Failed to get byte data from drawing.");
//         return;
//       }

//       // Get the application's document directory
//       final directory = await getApplicationDocumentsDirectory();
//       final String fileName = 'drawing_${DateTime.now().millisecondsSinceEpoch}.png';
//       final File file = File('${directory.path}/$fileName');

//       // Write the bytes to the file
//       await file.writeAsBytes(byteData.buffer.asUint8List());

//       // Pass the saved file's path back to the calling screen
//       widget.onDrawingComplete(file.path);
//       Navigator.pop(context);
//     } catch (e) {
//       print("Error saving drawing: $e");
//       // Optionally show a SnackBar to the user
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to save drawing: $e'),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
// }

// class DrawingPainter extends CustomPainter {
//   final List<Offset?> points;
//   final Color color;
//   final double strokeWidth;

//   DrawingPainter(this.points, this.color, this.strokeWidth);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = color
//       ..strokeCap = StrokeCap.round
//       ..strokeWidth = strokeWidth
//       ..style = PaintingStyle.stroke;

//     for (int i = 0; i < points.length - 1; i++) {
//       if (points[i] != null && points[i + 1] != null) {
//         canvas.drawLine(points[i]!, points[i + 1]!, paint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     // Only repaint if points, color, or strokeWidth has changed
//     final DrawingPainter oldPainter = oldDelegate as DrawingPainter;
//     return oldPainter.points != points ||
//            oldPainter.color != color ||
//            oldPainter.strokeWidth != strokeWidth;
//   }
// }





import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:setnotes/note.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // Required for File operations
import 'package:path_provider/path_provider.dart'; // For getting app's document directory
import 'dart:ui' as ui; // For image manipulation in drawing screen
import 'package:flutter/rendering.dart'; // For RepaintBoundary in drawing screen


class NoteEditScreen extends StatefulWidget {
  final Note note;
  final VoidCallback onNoteUpdated;
  final Function(String) onNoteDeleted;

  const NoteEditScreen({
    super.key,
    required this.note,
    required this.onNoteUpdated,
    required this.onNoteDeleted,
  });

  @override
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State<NoteEditScreen> {
  late TextEditingController _contentController;
  late TextEditingController _titleController;
  late bool _currentIsPinned;
  late bool _currentHasReminder;
  late bool _currentIsArchived;
  String? _currentImagePath; // New state variable for image path

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.note.content);
    _titleController = TextEditingController(text: widget.note.title);
    _currentIsPinned = widget.note.isPinned;
    _currentHasReminder = widget.note.hasReminder;
    _currentIsArchived = widget.note.isArchived;
    // Initialize _currentImagePath from the note model's imagePath
    _currentImagePath = widget.note.imagePath; 

    _titleController.addListener(_saveNoteOnTextChange);
    _contentController.addListener(_saveNoteOnTextChange);
  }

  @override
  void dispose() {
    _titleController.removeListener(_saveNoteOnTextChange);
    _contentController.removeListener(_saveNoteOnTextChange);
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _startDrawing() {
    Navigator.pop(context); // Close the bottom sheet
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DrawingScreen(
          onDrawingComplete: (String drawingPath) {
            setState(() {
              _currentImagePath = drawingPath;
            });
            _saveNote(); // Save the note with the new image path
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Drawing saved!'),
                backgroundColor: Color(0xFF303134),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }

  void _saveNoteOnTextChange() {
    _saveNote();
  }

  void _saveNote() {
    widget.note.content = _contentController.text;
    widget.note.title = _titleController.text;
    widget.note.isPinned = _currentIsPinned;
    widget.note.hasReminder = _currentHasReminder;
    widget.note.isArchived = _currentIsArchived;
    // Save the image path to the Note model
    widget.note.imagePath = _currentImagePath; 
    widget.onNoteUpdated(); // Notify parent to persist the updated note
  }

  void _togglePin() {
    setState(() {
      _currentIsPinned = !_currentIsPinned;
      _saveNote();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_currentIsPinned ? 'Note pinned' : 'Note unpinned'),
        backgroundColor: const Color(0xFF303134),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _deleteNote() {
    widget.onNoteDeleted(widget.note.id);
    // Optionally, delete the associated image file here
    if (_currentImagePath != null && File(_currentImagePath!).existsSync()) {
      try {
        File(_currentImagePath!).deleteSync();
        print('Deleted image file: $_currentImagePath');
      } catch (e) {
        print('Error deleting image file: $e');
      }
    }
    Navigator.pop(context);
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 78, 77, 73),
          title: const Text(
            'Delete note?',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'This note will be deleted permanently.',
            style: TextStyle(color: Colors.grey[300]),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteNote();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper function to save image files to app's document directory
  Future<String?> _saveImageToFile(XFile? xFile) async {
    if (xFile == null) return null;
    try {
      final directory = await getApplicationDocumentsDirectory();
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}_${xFile.name}';
      final String newPath = '${directory.path}/$fileName';
      final File newFile = await File(xFile.path).copy(newPath);
      return newFile.path;
    } catch (e) {
      print("Error saving image to file: $e");
      return null;
    }
  }

  Future<void> _pickImage() async {
    Navigator.pop(context); // Close the bottom sheet
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final String? savedPath = await _saveImageToFile(image);
      if (savedPath != null) {
        setState(() {
          _currentImagePath = savedPath; // Store the permanent path
        });
        _saveNote(); // Save the note with the new image path
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image selected: ${savedPath.split('/').last}'),
            backgroundColor: const Color(0xFF303134),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save image.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected'),
          backgroundColor: Color(0xFF303134),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    Navigator.pop(context); // Close the bottom sheet
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      final String? savedPath = await _saveImageToFile(photo);
      if (savedPath != null) {
        setState(() {
          _currentImagePath = savedPath; // Store the permanent path
        });
        _saveNote(); // Save the note with the new image path
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Photo taken: ${savedPath.split('/').last}'),
            backgroundColor: const Color(0xFF303134),
            duration: const Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save photo.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No photo taken'),
          backgroundColor: Color(0xFF303134),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202124),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202124),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            _saveNote();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _currentIsPinned ? Icons.push_pin : Icons.push_pin_outlined,
              color: _currentIsPinned ? Colors.blue : Colors.white,
            ),
            onPressed: _togglePin,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: _showDeleteDialog,
          ),
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Colors.white),
            onPressed: _showAddOptions,
          ),
          IconButton(
            icon: const Icon(Icons.palette_outlined, color: Colors.white),
            onPressed: _showColorPicker,
          ),
          IconButton(
            icon: const Icon(Icons.text_format, color: Colors.white),
            onPressed: _showTextFormatting,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: InputBorder.none,
              ),
            ),
            // Display the image/drawing if a path exists and the file exists
            if (_currentImagePath != null && File(_currentImagePath!).existsSync())
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.file(
                  File(_currentImagePath!),
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Note',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: const Color(0xFF202124),
        child: Row(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                'Edited ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF303134),
      builder: (context) => SizedBox(
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.image, color: Colors.white),
              title: const Text('Add image',
                  style: TextStyle(color: Colors.white)),
              onTap: _pickImage, // Call the image picker
            ),
            ListTile(
              leading:
                  const Icon(Icons.camera_alt_outlined, color: Colors.white),
              title: const Text('Take photo',
                  style: TextStyle(color: Colors.white)),
              onTap: _takePhoto, // Call the new _takePhoto function
            ),
            ListTile(
              leading: const Icon(Icons.draw_outlined, color: Colors.white),
              title:
                  const Text('Drawing', style: TextStyle(color: Colors.white)),
              onTap: _startDrawing, // Call the new _startDrawing function
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF303134),
      builder: (context) => Container(
        height: 120,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Choose color',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _colorOption(Colors.white),
                _colorOption(Colors.red[100]!),
                _colorOption(Colors.orange[100]!),
                _colorOption(Colors.yellow[100]!),
                _colorOption(Colors.green[100]!),
                _colorOption(Colors.blue[100]!),
                _colorOption(Colors.purple[100]!),
                _colorOption(const Color.fromARGB(255, 165, 17, 99)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorOption(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.note.color = color;
        });
        _saveNote();
        Navigator.pop(context);
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[600]!),
        ),
      ),
    );
  }

  void _showTextFormatting() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF303134),
      builder: (context) => SizedBox(
        height: 200,
        child: Column(
          children: [
            ListTile(
              leading:
                  const Icon(Icons.format_list_bulleted, color: Colors.white),
              title: const Text('Bullet list',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _contentController.text += '\n• ';
                _contentController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _contentController.text.length),
                );
                _saveNote();
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.format_list_numbered, color: Colors.white),
              title: const Text('Numbered list',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _contentController.text += '1. ';
                _contentController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _contentController.text.length),
                );
                _saveNote();
              },
            ),
            ListTile(
              leading: const Icon(Icons.check_box, color: Colors.white),
              title: const Text('Add checklist',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                _contentController.text += '☐ ';
                _contentController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _contentController.text.length),
                );
                _saveNote();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawingScreen extends StatefulWidget {
  final Function(String) onDrawingComplete;

  const DrawingScreen({super.key, required this.onDrawingComplete});

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<Offset?> points = <Offset?>[];
  Color selectedColor = Colors.black;
  double strokeWidth = 2.0;
  final GlobalKey _drawingKey = GlobalKey(); // Key to capture the drawing widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF202124),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202124),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Drawing', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: _clearDrawing,
          ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: _saveDrawing,
          ),
        ],
      ),
      body: Column(
        children: [
          // Drawing tools
          Container(
            height: 130,
            color: const Color(0xFF303134),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Color picker
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildColorButton(Colors.black),
                    _buildColorButton(Colors.red),
                    _buildColorButton(Colors.blue),
                    _buildColorButton(Colors.green),
                    _buildColorButton(Colors.yellow),
                    _buildColorButton(Colors.purple),
                    _buildColorButton(Colors.orange),
                    _buildColorButton(Colors.pink),
                  ],
                ),
                const SizedBox(height: 5),
                // Stroke width slider
                Row(
                  children: [
                    const Text('Brush size:',
                        style: TextStyle(color: Colors.white)),
                    Expanded(
                      child: Slider(
                        value: strokeWidth,
                        min: 1.0,
                        max: 10.0,
                        divisions: 9,
                        activeColor: Colors.white,
                        onChanged: (value) =>
                            setState(() => strokeWidth = value),
                      ),
                    ),
                    Text('${strokeWidth.toInt()}',
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          // Drawing canvas
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              // Wrap with RepaintBoundary to capture the drawing
              child: RepaintBoundary(
                key: _drawingKey, // Assign the GlobalKey
                child: GestureDetector(
                  onPanStart: (details) {
                    setState(() {
                      points.add(details.localPosition);
                    });
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      points.add(details.localPosition);
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      points.add(null); // Add null to separate strokes
                    });
                  },
                  child: CustomPaint(
                    painter: DrawingPainter(points, selectedColor, strokeWidth),
                    size: Size.infinite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: selectedColor == color
              ? Border.all(color: Colors.white, width: 3)
              : Border.all(color: Colors.grey, width: 1),
        ),
      ),
    );
  }

  void _clearDrawing() {
    setState(() {
      points.clear();
    });
  }

  Future<void> _saveDrawing() async {
    try {
      // Find the render object associated with the _drawingKey
      RenderRepaintBoundary boundary =
          _drawingKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // Convert the boundary to an image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0); // Adjust pixelRatio for quality

      // Get the byte data in PNG format
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        print("Failed to get byte data from drawing.");
        return;
      }

      // Get the application's document directory
      final directory = await getApplicationDocumentsDirectory();
      final String fileName = 'drawing_${DateTime.now().millisecondsSinceEpoch}.png';
      final File file = File('${directory.path}/$fileName');

      // Write the bytes to the file
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // Pass the saved file's path back to the calling screen
      widget.onDrawingComplete(file.path);
      Navigator.pop(context);
    } catch (e) {
      print("Error saving drawing: $e");
      // Optionally show a SnackBar to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save drawing: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  DrawingPainter(this.points, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // Only repaint if points, color, or strokeWidth has changed
    final DrawingPainter oldPainter = oldDelegate as DrawingPainter;
    return oldPainter.points != points ||
           oldPainter.color != color ||
           oldPainter.strokeWidth != strokeWidth;
  }
}
