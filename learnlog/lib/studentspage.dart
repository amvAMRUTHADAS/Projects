
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class StudentsPage extends StatelessWidget {
//   final String studentId;

//   const StudentsPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Students', style: TextStyle(color: Colors.white)),
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
//           stream: FirebaseFirestore.instance.collection('students').snapshots(),
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
//                   'No students found.',
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
//                       data['name'] ?? 'Unknown',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(data['email'] ?? 'No email'),
//                     leading: const Icon(Icons.person, color: Colors.teal),
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

// class StudentsPage extends StatelessWidget {
//   final String studentId;

//   const StudentsPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Students', style: TextStyle(color: Colors.white)),
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
//           stream: FirebaseFirestore.instance.collection('students').snapshots(),
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
//                   'No students found.',
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
//                 final docId = docs[index].id; // Get the document ID for deletion

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   child: ListTile(
//                     title: Text(
//                       data['name'] ?? 'Unknown',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     leading: const Icon(Icons.person, color: Colors.teal),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () async {
//                         // Show confirmation dialog
//                         bool confirmDelete = await showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: const Text('Confirm Delete'),
//                             content: const Text('Are you sure you want to delete this student?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, false),
//                                 child: const Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, true),
//                                 child: const Text('Delete'),
//                               ),
//                             ],
//                           ),
//                         );

//                         if (confirmDelete == true) {
//                           try {
//                             await FirebaseFirestore.instance
//                                 .collection('students')
//                                 .doc(docId)
//                                 .delete();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('Student deleted successfully')),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Error deleting student: $e')),
//                             );
//                           }
//                         }
//                       },
//                     ),
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

// class StudentsPage extends StatelessWidget {
//   final String studentId;

//   const StudentsPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Students', style: TextStyle(color: Colors.white)),
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
//           stream: FirebaseFirestore.instance.collection('students').snapshots(),
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
//                   'No students found.',
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
//                 final docId = docs[index].id; // Get the document ID for deletion

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   child: ListTile(
//                     title: Text(
//                       'Name: ${data['name'] ?? 'Unknown'}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       'Division: ${data['className'] ?? 'N/A'}\n'
//                       'Roll No: ${data['rollNo'] ?? 'N/A'}',
//                     ),
//                     leading: const Icon(Icons.person, color: Colors.teal),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () async {
//                         // Show confirmation dialog
//                         bool confirmDelete = await showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: const Text('Confirm Delete'),
//                             content: const Text('Are you sure you want to delete this student?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, false),
//                                 child: const Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, true),
//                                 child: const Text('Delete'),
//                               ),
//                             ],
//                           ),
//                         );

//                         if (confirmDelete == true) {
//                           try {
//                             await FirebaseFirestore.instance
//                                 .collection('students')
//                                 .doc(docId)
//                                 .delete();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(content: Text('Student deleted successfully')),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(content: Text('Error deleting student: $e')),
//                             );
//                           }
//                         }
//                       },
//                     ),
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

// class StudentsPage extends StatelessWidget {
//   final String studentId;

//   const StudentsPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Students', style: TextStyle(color: Colors.white)),
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
//           stream: FirebaseFirestore.instance.collection('users').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                   child: Text('Error: ${snapshot.error}',
//                       style: const TextStyle(color: Colors.white)));
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                   child: CircularProgressIndicator(color: Colors.white));
//             }
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'No students found.',
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
//                 final docId = docs[index].id; // Get the document ID for deletion

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: ListTile(
//                     title: Text(
//                       'Name: ${data['student_name'] ?? 'Unknown'}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       'Division: ${data['division'] ?? 'N/A'}\n'
//                       'Roll No: ${data['roll_number'] ?? 'N/A'}',
//                     ),
//                     leading: const Icon(Icons.person, color: Colors.teal),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () async {
//                         // Show confirmation dialog
//                         bool confirmDelete = await showDialog(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: const Text('Confirm Delete'),
//                             content: const Text(
//                                 'Are you sure you want to delete this student?'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, false),
//                                 child: const Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, true),
//                                 child: const Text('Delete'),
//                               ),
//                             ],
//                           ),
//                         );

//                         if (confirmDelete == true) {
//                           try {
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc(docId)
//                                 .delete();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Student deleted successfully')),
//                             );
//                           } catch (e) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                   content: Text('Error deleting student: $e')),
//                             );
//                           }
//                         }
//                       },
//                     ),
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

// class StudentsPage extends StatelessWidget {
//   final String studentId;

//   const StudentsPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Students', style: TextStyle(color: Colors.white)),
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
//           stream: FirebaseFirestore.instance.collection('users').snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   'Error: ${snapshot.error}',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               );
//             }
//             if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return const Center(
//                 child: Text(
//                   'No students found.',
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
//                 final docId = docs[index].id; // Get the document ID for deletion

//                 return Card(
//                   elevation: 4,
//                   margin: const EdgeInsets.symmetric(vertical: 8.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: ListTile(
//                     title: Text(
//                       'Name: ${data['student_name'] ?? 'Unknown'}',
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       'Division: ${data['division'] ?? 'N/A'}\n'
//                       'Roll No: ${data['roll_number'] ?? 'N/A'}',
//                     ),
//                     leading: const Icon(Icons.person, color: Colors.teal),
//                     trailing: IconButton(
//                       icon: const Icon(Icons.delete, color: Colors.red),
//                       onPressed: () async {
//                         // Debugging: Log the document ID
//                         print('Attempting to delete document ID: $docId');

//                         // Show confirmation dialog
//                         final bool? confirmDelete = await showDialog<bool>(
//                           context: context,
//                           builder: (context) => AlertDialog(
//                             title: const Text('Confirm Delete'),
//                             content: const Text(
//                               'Are you sure you want to delete this student?',
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, false),
//                                 child: const Text('Cancel'),
//                               ),
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, true),
//                                 child: const Text('Delete'),
//                               ),
//                             ],
//                           ),
//                         );

//                         // Debugging: Log the dialog result
//                         print('Confirm Delete: $confirmDelete');

//                         if (confirmDelete == true) {
//                           try {
//                             // Attempt to delete the document
//                             await FirebaseFirestore.instance
//                                 .collection('users')
//                                 .doc(docId)
//                                 .delete();
//                             // Show success message
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Student deleted successfully'),
//                                 backgroundColor: Colors.green,
//                               ),
//                             );
//                           } catch (e) {
//                             // Debugging: Log the error
//                             print('Error deleting student: $e');
//                             // Show error message
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Error deleting student: $e'),
//                                 backgroundColor: Colors.red,
//                               ),
//                             );
//                           }
//                         }
//                       },
//                     ),
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

// class StudentsPage extends StatefulWidget {
//   final String studentId;

//   const StudentsPage({super.key, required this.studentId});

//   @override
//   State<StudentsPage> createState() => _StudentsPageState();
// }

// class _StudentsPageState extends State<StudentsPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 12, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Widget _buildStudentList(String classNumber) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('class', isEqualTo: classNumber)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(
//               'Error: ${snapshot.error}',
//               style: const TextStyle(color: Colors.white),
//             ),
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(color: Colors.white),
//           );
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(
//             child: Text(
//               'No students found for this class.',
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           );
//         }
//         final docs = snapshot.data!.docs;
//         return ListView.builder(
//           padding: const EdgeInsets.all(16.0),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             final docId = docs[index].id;

//             return Card(
//               elevation: 4,
//               margin: const EdgeInsets.symmetric(vertical: 8.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 title: Text(
//                   'Name: ${data['student_name'] ?? 'Unknown'}',
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text(
//                   'Class: ${data['class'] ?? 'N/A'}\n'
//                   'Roll No: ${data['roll_number'] ?? 'N/A'}',
//                 ),
//                 leading: const Icon(Icons.person, color: Colors.teal),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: () async {
//                     print('Attempting to delete document ID: $docId');
//                     final bool? confirmDelete = await showDialog<bool>(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: const Text('Confirm Delete'),
//                         content: const Text(
//                           'Are you sure you want to delete this student?',
//                         ),
//                         actions: [
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, false),
//                             child: const Text('Cancel'),
//                           ),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, true),
//                             child: const Text('Delete'),
//                           ),
//                         ],
//                       ),
//                     );
//                     print('Confirm Delete: $confirmDelete');
//                     if (confirmDelete == true) {
//                       try {
//                         await FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(docId)
//                             .delete();
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Student deleted successfully'),
//                             backgroundColor: Colors.green,
//                           ),
//                         );
//                       } catch (e) {
//                         print('Error deleting student: $e');
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Error deleting student: $e'),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       }
//                     }
//                   },
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Students', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF008080),
//         iconTheme: const IconThemeData(color: Colors.white),
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: true,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           indicatorColor: Colors.white,
//           tabs: const [
//             Tab(text: 'Class 1'),
//             Tab(text: 'Class 2'),
//             Tab(text: 'Class 3'),
//             Tab(text: 'Class 4'),
//             Tab(text: 'Class 5'),
//             Tab(text: 'Class 6'),
//             Tab(text: 'Class 7'),
//             Tab(text: 'Class 8'),
//             Tab(text: 'Class 9'),
//             Tab(text: 'Class 10'),
//             Tab(text: 'Class 11'),
//             Tab(text: 'Class 12'),
//           ],
//         ),
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
//         child: TabBarView(
//           controller: _tabController,
//           children: [
//             _buildStudentList('1'),
//             _buildStudentList('2'),
//             _buildStudentList('3'),
//             _buildStudentList('4'),
//             _buildStudentList('4'),
//             _buildStudentList('6'),
//             _buildStudentList('7'),
//             _buildStudentList('8'),
//             _buildStudentList('9'),
//             _buildStudentList('10'),
//             _buildStudentList('11'),
//             _buildStudentList('12'),
//           ],
//         ),
//       ),
//     );
//   }
// }














import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  final String studentId;

  const StudentsPage({super.key, required this.studentId});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 12, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildStudentList(String classNumber) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('class', isEqualTo: classNumber)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No students found for this class.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
        }
        final docs = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final docId = docs[index].id;

            return Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(
                  'Name: ${data['student_name'] ?? 'Unknown'}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Class: ${data['class'] ?? 'N/A'}\n'
                  'Division: ${data['division'] ?? 'N/A'}\n'
                  'Roll No: ${data['roll_number'] ?? 'N/A'}',
                ),
                leading: const Icon(Icons.person, color: Colors.teal),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditStudentPage(
                              docId: docId,
                              studentData: data,
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        print('Attempting to delete document ID: $docId');
                        final bool? confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Delete'),
                            content: const Text(
                              'Are you sure you want to delete this student?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                        print('Confirm Delete: $confirmDelete');
                        if (confirmDelete == true) {
                          try {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(docId)
                                .delete();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Student deleted successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } catch (e) {
                            print('Error deleting student: $e');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error deleting student: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Students', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF008080),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Class 1'),
            Tab(text: 'Class 2'),
            Tab(text: 'Class 3'),
            Tab(text: 'Class 4'),
            Tab(text: 'Class 5'),
            Tab(text: 'Class 6'),
            Tab(text: 'Class 7'),
            Tab(text: 'Class 8'),
            Tab(text: 'Class 9'),
            Tab(text: 'Class 10'),
            Tab(text: 'Class 11'),
            Tab(text: 'Class 12'),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF008080),
              Color(0xFF20B2AA),
              Color(0xFF40E0D0),
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildStudentList('1'),
            _buildStudentList('2'),
            _buildStudentList('3'),
            _buildStudentList('4'),
            _buildStudentList('5'),
            _buildStudentList('6'),
            _buildStudentList('7'),
            _buildStudentList('8'),
            _buildStudentList('9'),
            _buildStudentList('10'),
            _buildStudentList('11'),
            _buildStudentList('12'),
          ],
        ),
      ),
    );
  }
}

class EditStudentPage extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> studentData;

  const EditStudentPage({super.key, required this.docId, required this.studentData});

  @override
  State<EditStudentPage> createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String? _studentNameError;
  String? _rollNumberError;
  String? _usernameError;
  String? _classError;
  String? _divisionError;

  String? _selectedClass;
  String? _selectedDivision;
  final List<String> _classes = List.generate(12, (index) => (index + 1).toString());
  final List<String> _divisions = ['A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
    // Pre-populate fields with existing student data
    _studentNameController.text = widget.studentData['student_name'] ?? '';
    _rollNumberController.text = widget.studentData['roll_number'] ?? '';
    _usernameController.text = widget.studentData['username'] ?? '';
    _selectedClass = widget.studentData['class'] ?? '';
    _selectedDivision = widget.studentData['division'] ?? '';
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _rollNumberController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  String? _validateStudentName(String name) {
    if (name.isEmpty) {
      return 'Student name cannot be empty';
    }
    if (name.length < 2) {
      return 'Student name must be at least 2 characters long';
    }
    return null;
  }

  String? _validateRollNumber(String rollNumber) {
    if (rollNumber.isEmpty) {
      return 'Roll number cannot be empty';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(rollNumber)) {
      return 'Roll number must contain only numbers';
    }
    return null;
  }

  String? _validateClass() {
    if (_selectedClass == null || _selectedClass!.isEmpty) {
      return 'Please select a class';
    }
    return null;
  }

  String? _validateDivision() {
    if (_selectedDivision == null || _selectedDivision!.isEmpty) {
      return 'Please select a division';
    }
    return null;
  }

  String? _validateUsername(String username) {
    if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%)]').hasMatch(username)) {
      return 'Username must not contain special characters';
    }
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  Future<void> _updateStudent() async {
    setState(() {
      _studentNameError = _validateStudentName(_studentNameController.text);
      _rollNumberError = _validateRollNumber(_rollNumberController.text);
      _classError = _validateClass();
      _divisionError = _validateDivision();
      _usernameError = _validateUsername(_usernameController.text);
    });

    if (_studentNameError == null &&
        _rollNumberError == null &&
        _classError == null &&
        _divisionError == null &&
        _usernameError == null) {
      try {
        // Check if username already exists (excluding current document)
        final QuerySnapshot existingUsers = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: _usernameController.text)
            .get();
        if (existingUsers.docs.isNotEmpty &&
            existingUsers.docs.any((doc) => doc.id != widget.docId)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Username already exists. Please choose another.')),
          );
          return;
        }

        // Check if roll number already exists in the same class and division (excluding current document)
        final QuerySnapshot existingRollNumbers = await FirebaseFirestore.instance
            .collection('users')
            .where('roll_number', isEqualTo: _rollNumberController.text)
            .where('class', isEqualTo: _selectedClass)
            .where('division', isEqualTo: _selectedDivision)
            .get();
        if (existingRollNumbers.docs.isNotEmpty &&
            existingRollNumbers.docs.any((doc) => doc.id != widget.docId)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Roll number already exists in this class and division.')),
          );
          return;
        }

        // Update student in Firestore
        await FirebaseFirestore.instance.collection('users').doc(widget.docId).update({
          'student_name': _studentNameController.text,
          'roll_number': _rollNumberController.text,
          'class': _selectedClass,
          'division': _selectedDivision,
          'username': _usernameController.text,
          'updated_at': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student updated successfully'), backgroundColor: Colors.green),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating student: $e'), backgroundColor: Colors.red),
        );
        print('Update error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors in the form.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF008080),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit Student Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Student Name Field
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _studentNameController,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                        labelText: 'Student Name',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        errorText: _studentNameError,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _studentNameError = _validateStudentName(value);
                        });
                      },
                    ),
                  ),
                ),

                // Roll Number Field
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _rollNumberController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.numbers, color: Colors.grey),
                        labelText: 'Roll Number',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        errorText: _rollNumberError,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _rollNumberError = _validateRollNumber(value);
                        });
                      },
                    ),
                  ),
                ),

                // Class Dropdown
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: DropdownButtonFormField<String>(
                      value: _selectedClass,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.class_, color: Colors.grey),
                        labelText: 'Class',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        errorText: _classError,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      items: _classes.map((String classNum) {
                        return DropdownMenuItem<String>(
                          value: classNum,
                          child: Text(
                            'Class $classNum',
                            style: const TextStyle(color: Colors.black87),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedClass = newValue;
                          _classError = _validateClass();
                        });
                      },
                    ),
                  ),
                ),

                // Division Dropdown
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: DropdownButtonFormField<String>(
                      value: _selectedDivision,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.group, color: Colors.grey),
                        labelText: 'Division',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        errorText: _divisionError,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      items: _divisions.map((String division) {
                        return DropdownMenuItem<String>(
                          value: division,
                          child: Text(
                            'Division $division',
                            style: const TextStyle(color: Colors.black87),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDivision = newValue;
                          _divisionError = _validateDivision();
                        });
                      },
                    ),
                  ),
                ),

                // Username Field
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: TextField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person, color: Colors.grey),
                        labelText: 'Username',
                        labelStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        errorText: _usernameError,
                        errorStyle: const TextStyle(color: Colors.redAccent),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _usernameError = _validateUsername(value);
                        });
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Update Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008080),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 5,
                    ),
                    onPressed: _updateStudent,
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 1.5,
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
}




































