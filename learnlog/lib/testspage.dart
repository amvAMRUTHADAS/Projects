
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TestsPage extends StatelessWidget {
//   final String studentId;

//   const TestsPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tests', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF008080),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF008080),
//               Color(0xFF20B2AA),
//               Color(0xFF40E0D0),
//             ],
//           ),
//         ),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('tests')
//               .where('studentId', isEqualTo: studentId)
//               .orderBy('date', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: Colors.white));
//             }
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'No tests found.',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               );
//             }
//             final docs = snapshot.data!.docs;
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: docs.length,
//               itemBuilder: (context, index) {
//                 final data = docs[index].data() as Map<String, dynamic>;
//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   child: ListTile(
//                     title: Text(
//                       data['subject'] ?? 'Unknown',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text('Date: ${data['date']} | Score: ${data['score'] ?? 'N/A'}'),
//                     leading: const Icon(Icons.assignment, color: Colors.teal),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TestsPage extends StatelessWidget {
//   final String studentId;

//   const TestsPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tests', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF008080),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF008080),
//               Color(0xFF20B2AA),
//               Color(0xFF40E0D0),
//             ],
//           ),
//         ),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('tests')
//               .where('studentId', isEqualTo: studentId)
//               .orderBy('date', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator(color: Colors.white));
//             }
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'No tests found.',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               );
//             }
//             final docs = snapshot.data!.docs;
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: docs.length,
//               itemBuilder: (context, index) {
//                 final data = docs[index].data() as Map<String, dynamic>;
//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   child: ListTile(
//                     title: Text(
//                       data['subject'] ?? 'Unknown',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text('Date: ${data['date']} | Score: ${data['score'] ?? 'N/A'}'),
//                     leading: const Icon(Icons.assignment, color: Colors.teal),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AddTestPage extends StatefulWidget {
//   final String studentId;

//   const AddTestPage({super.key, required this.studentId});

//   @override
//   _AddTestPageState createState() => _AddTestPageState();
// }

// class _AddTestPageState extends State<AddTestPage> {
//   final _formKey = GlobalKey<FormState>();
//   DateTime _selectedDate = DateTime.parse('2024-10-18');
//   final _titleController = TextEditingController();
//   final _totalMarksController = TextEditingController();
//   final _passingMarksController = TextEditingController();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   void _addTest() {
//     if (_formKey.currentState!.validate()) {
//       FirebaseFirestore.instance.collection('tests').add({
//         'studentId': widget.studentId,
//         'date': _selectedDate.toIso8601String(),
//         'subject': _titleController.text,
//         'totalMarks': int.parse(_totalMarksController.text),
//         'passingMarks': int.parse(_passingMarksController.text),
//         'score': 0, // Default score, can be updated later
//       });
//       Navigator.pop(context); // Return to previous screen
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Add Test', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF008080),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               InkWell(
//                 onTap: () => _selectDate(context),
//                 child: InputDecorator(
//                   decoration: const InputDecoration(labelText: 'Select Test Date'),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('${_selectedDate.day} ${_selectedDate.month} ${_selectedDate.year}'),
//                       const Icon(Icons.calendar_today),
//                     ],
//                   ),
//                 ),
//               ),
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'Write Test Title', hintText: 'Eg. Full Book Test'),
//                 validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
//               ),
//               TextFormField(
//                 controller: _totalMarksController,
//                 decoration: const InputDecoration(labelText: 'Enter Total Marks', hintText: 'Eg. 100'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) => value!.isEmpty ? 'Please enter total marks' : null,
//               ),
//               TextFormField(
//                 controller: _passingMarksController,
//                 decoration: const InputDecoration(labelText: 'Passing Marks', hintText: 'Eg. 40'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) => value!.isEmpty ? 'Please enter passing marks' : null,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _addTest,
//                 child: const Text('Add'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTestPage extends StatefulWidget {
  final String studentId;

  const AddTestPage({super.key, required this.studentId});

  @override
  _AddTestPageState createState() => _AddTestPageState();
}

class _AddTestPageState extends State<AddTestPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now(); // Changed initial date to now for better UX
  final _titleController = TextEditingController();
  final _totalMarksController = TextEditingController();
  final _passingMarksController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _totalMarksController.dispose();
    _passingMarksController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 13, 74, 83), // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Body text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addTest() {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance.collection('tests').add({
        'studentId': widget.studentId,
        'date': Timestamp.fromDate(_selectedDate), // Store as Firestore Timestamp
        'subject': _titleController.text,
        'totalMarks': int.parse(_totalMarksController.text),
        'passingMarks': int.parse(_passingMarksController.text),
        'score': 0, // Default score, can be updated later
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp for ordering
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Test added successfully!')),
        );
        Navigator.pop(context); // Return to previous screen
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add test: $error')),
        );
        print('Error adding test: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add New Test',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 45, 50), // Match top gradient color
        iconTheme: const IconThemeData(color: Colors.white), // Back button color
        elevation: 0, // Remove shadow for seamless gradient
      ),
      body: Container( // This container will hold the gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 4, 45, 50), // Darker Teal
              Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
              Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
              Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Increased padding
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Date Picker Input
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // Slightly transparent white background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Select Test Date',
                        labelStyle: TextStyle(color: Colors.grey[700]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                          const Icon(Icons.calendar_today, color: Color.fromARGB(255, 13, 74, 83)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Test Title
                _buildTextFormField(
                  controller: _titleController,
                  labelText: 'Write Test Title',
                  hintText: 'Eg. Full Book Test',
                  validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                ),
                const SizedBox(height: 10),

                // Total Marks
                _buildTextFormField(
                  controller: _totalMarksController,
                  labelText: 'Enter Total Marks',
                  hintText: 'Eg. 100',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter total marks';
                    if (int.tryParse(value) == null) return 'Please enter a valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Passing Marks
                _buildTextFormField(
                  controller: _passingMarksController,
                  labelText: 'Passing Marks',
                  hintText: 'Eg. 40',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) return 'Please enter passing marks';
                    if (int.tryParse(value) == null) return 'Please enter a valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Add Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addTest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 13, 74, 83), // Button color from gradient
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 5,
                    ),
                    child: const Text(
                      'ADD TEST',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build consistent TextFormField styling
  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(color: Colors.grey[700]),
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none, // No border by default
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color.fromARGB(255, 13, 74, 83), width: 2), // Highlighted border
          ),
          errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 13),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        validator: validator,
      ),
    );
  }
}