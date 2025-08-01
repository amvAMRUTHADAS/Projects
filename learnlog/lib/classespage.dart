// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ClassesPage extends StatelessWidget {
//   final String studentId;

//   const ClassesPage({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Classes', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF008080),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color.fromARGB(255, 4, 45, 50), // Darker Teal
//               Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//               Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
//               Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
//             ],
//           ),
//         ),
//         child: StreamBuilder<QuerySnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection('classes')
//               .where('students', arrayContains: studentId)
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
//                   'No classes found.',
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
//                     subtitle: Text(data['schedule'] ?? 'No schedule'),
//                     leading: const Icon(Icons.class_, color: Colors.teal),
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
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId; // The ID of the logged-in student's document

//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchStudentData();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     try {
//       DocumentSnapshot studentDoc = await FirebaseFirestore.instance
//           .collection('users') // Assuming student data is in 'users' collection
//           .doc(widget.studentId)
//           .get();

//       if (studentDoc.exists) {
//         setState(() {
//           _studentData = studentDoc.data() as Map<String, dynamic>?;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Student data not found.';
//           _isLoading = false;
//         });
//         print('Error: Student document with ID ${widget.studentId} not found.');
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load student data: $e';
//         _isLoading = false;
//       });
//       print('Error fetching student data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color.fromARGB(255, 4, 45, 50), // Darker Teal
//               Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//               Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
//               Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Top Section: Student Information
//             Padding(
//               padding: const EdgeInsets.only(
//                   top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
//               child: _isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(
//                           child: Text(
//                             _errorMessage!,
//                             style: const TextStyle(color: Colors.redAccent, fontSize: 16),
//                           ),
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Student name: ${_studentData?['name'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Roll No: ${_studentData?['rollNo'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Division: ${_studentData?['division'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//             ),

//             // Tab Bar
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(
//                   top: BorderSide(color: Colors.white54, width: 0.5),
//                   bottom: BorderSide(color: Colors.white54, width: 0.5),
//                 ),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white, // Color of the selected tab indicator
//                 labelColor: Colors.white, // Color of the selected tab label
//                 unselectedLabelColor: Colors.white70, // Color of unselected tab labels
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 unselectedLabelStyle: const TextStyle(fontSize: 16),
//                 tabs: const [
//                   Tab(text: 'Results'),
//                   Tab(text: 'Progress'),
//                 ],
//               ),
//             ),

//             // Tab Bar View (Content for each tab)
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   // Placeholder for Results content
//                   _isLoading
//                       ? const Center(
//                           child: CircularProgressIndicator(color: Colors.white),
//                         )
//                       : ResultsTabContent(studentId: widget.studentId),
//                   // Placeholder for Progress content
//                   _isLoading
//                       ? const Center(
//                           child: CircularProgressIndicator(color: Colors.white),
//                         )
//                       : ProgressTabContent(studentId: widget.studentId),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // --- Placeholder Widgets for Tab Content ---

// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text(
//             'Your Test Results will appear here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           // Example: A button to add a new test, if that's part of the flow
//           ElevatedButton.icon(
//             onPressed: () {
//               // Navigate to AddTestPage
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddTestPage(studentId: studentId),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromARGB(255, 13, 74, 83), // Button color
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text(
//             'Your learning progress charts and insights will be displayed here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// // Attendance class (unchanged from AttendancePage)
// class Attendance {
//   final String studentId;
//   final String studentName;
//   final String className;
//   final String division;
//   final String rollNo;
//   final String status;
//   final Timestamp date;

//   Attendance({
//     required this.studentId,
//     required this.studentName,
//     required this.className,
//     required this.division,
//     required this.rollNo,
//     required this.status,
//     required this.date,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'studentId': studentId,
//       'studentName': studentName,
//       'className': className,
//       'division': division,
//       'rollNo': rollNo,
//       'status': status,
//       'date': date,
//     };
//   }

//   factory Attendance.fromMap(Map<String, dynamic> map) {
//     return Attendance(
//       studentId: map['studentId'] ?? '',
//       studentName: map['studentName'] ?? '',
//       className: map['className'] ?? '',
//       division: map['division'] ?? '',
//       rollNo: map['rollNo'] ?? '',
//       status: map['status'] ?? '',
//       date: map['date'] is Timestamp
//           ? map['date']
//           : Timestamp.fromDate(DateTime.parse(map['date'])),
//     );
//   }
// }

// class Classespage extends StatefulWidget {
//   final String studentId;

//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;
//   late DateTime currentDate;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this); // Added Attendance tab
//     _fetchStudentData();
//     currentDate = DateTime.now();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(currentDate));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     try {
//       DocumentSnapshot studentDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.studentId)
//           .get();

//       if (studentDoc.exists) {
//         setState(() {
//           _studentData = studentDoc.data() as Map<String, dynamic>?;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Student data not found.';
//           _isLoading = false;
//         });
//         print('Error: Student document with ID ${widget.studentId} not found.');
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load student data: $e';
//         _isLoading = false;
//       });
//       print('Error fetching student data: $e');
//     }
//   }

//   Widget _buildAttendanceTab() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: TextField(
//                   controller: _dateController,
//                   decoration: InputDecoration(
//                     labelText: 'Date',
//                     labelStyle: const TextStyle(color: Colors.white),
//                     enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
//                     focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.calendar_today, color: Colors.white),
//                       onPressed: () {
//                         showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(2000),
//                           lastDate: DateTime(2100),
//                         ).then((selectedDate) {
//                           if (selectedDate != null) {
//                             setState(() {
//                               _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//                             });
//                           }
//                         });
//                       },
//                     ),
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   readOnly: true,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Text(
//             'Attendance Records for ${_studentData?['student_name'] ?? 'Student'} on ${_dateController.text}',
//             style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Expanded(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('attendance')
//                 .where('studentId', isEqualTo: widget.studentId)
//                 .where('date', isEqualTo: Timestamp.fromDate(DateFormat('yyyy-MM-dd').parse(_dateController.text)))
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return const Text('Error loading attendance records', style: TextStyle(color: Colors.white));
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator(color: Colors.white));
//               }
//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const Text(
//                   'No attendance records found for this date.',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 );
//               }

//               final attendanceRecords = snapshot.data!.docs;
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: attendanceRecords.length,
//                 itemBuilder: (context, index) {
//                   final attendance = Attendance.fromMap(attendanceRecords[index].data() as Map<String, dynamic>);
//                   return ListTile(
//                     title: Text(
//                       attendance.studentName,
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       'Class: ${attendance.className} | Division: ${attendance.division} | Roll No: ${attendance.rollNo}',
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                     trailing: Text(
//                       attendance.status.capitalize(),
//                       style: TextStyle(
//                         color: attendance.status == 'present' ? Colors.green : Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color.fromARGB(255, 4, 45, 50), // Darker Teal
//               Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//               Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
//               Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Top Section: Student Information
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(
//                           child: Text(
//                             _errorMessage!,
//                             style: const TextStyle(color: Colors.redAccent, fontSize: 16),
//                           ),
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               _studentData?['student_name'] ?? 'N/A',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Class: ${_studentData?['class'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Division: ${_studentData?['division'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Roll No: ${_studentData?['roll_number'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//             ),

//             // Tab Bar
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(
//                   top: BorderSide(color: Colors.white54, width: 0.5),
//                   bottom: BorderSide(color: Colors.white54, width: 0.5),
//                 ),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 unselectedLabelStyle: const TextStyle(fontSize: 16),
//                 tabs: const [
//                   Tab(text: 'Results'),
//                   Tab(text: 'Progress'),
//                   Tab(text: 'Attendance'),
//                 ],
//               ),
//             ),

//             // Tab Bar View
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _isLoading
//                       ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                       : ResultsTabContent(studentId: widget.studentId),
//                   _isLoading
//                       ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                       : ProgressTabContent(studentId: widget.studentId),
//                   _isLoading
//                       ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                       : _buildAttendanceTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Placeholder Widgets for Tab Content
// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text(
//             'Your Test Results will appear here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddTestPage(studentId: studentId),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF40A4D0),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text(
//             'Your learning progress charts and insights will be displayed here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Extension to capitalize strings
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${substring(1)}";
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart'; // Ensure this file exists and contains AddTestPage

// // Attendance class (unchanged)
// class Attendance {
//   final String studentId;
//   final String studentName;
//   final String className;
//   final String division;
//   final String rollNo;
//   final String status;
//   final Timestamp date;

//   Attendance({
//     required this.studentId,
//     required this.studentName,
//     required this.className,
//     required this.division,
//     required this.rollNo,
//     required this.status,
//     required this.date,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'studentId': studentId,
//       'studentName': studentName,
//       'className': className,
//       'division': division,
//       'rollNo': rollNo,
//       'status': status,
//       'date': date,
//     };
//   }

//   factory Attendance.fromMap(Map<String, dynamic> map) {
//     return Attendance(
//       studentId: map['studentId'] ?? '',
//       studentName: map['studentName'] ?? '',
//       className: map['className'] ?? '',
//       division: map['division'] ?? '',
//       rollNo: map['rollNo'] ?? '',
//       status: map['status'] ?? '',
//       date: map['date'] is Timestamp
//           ? map['date']
//           : Timestamp.fromDate(DateTime.parse(map['date'])),
//     );
//   }
// }

// class Classespage extends StatefulWidget {
//   final String studentId;

//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;
//   late DateTime currentDate;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this); // Results, Progress, Attendance tabs
//     _fetchStudentData();
//     currentDate = DateTime.now();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(currentDate));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     try {
//       DocumentSnapshot studentDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.studentId)
//           .get();

//       if (studentDoc.exists) {
//         setState(() {
//           _studentData = studentDoc.data() as Map<String, dynamic>?;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Student data not found.';
//           _isLoading = false;
//         });
//         print('Error: Student document with ID ${widget.studentId} not found.');
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load student data: $e';
//         _isLoading = false;
//       });
//       print('Error fetching student data: $e');
//     }
//   }

//   Future<void> _markAttendance(String studentId, Map<String, dynamic> studentData, String status) async {
//     final dateStr = _dateController.text;
//     try {
//       final date = DateFormat('yyyy-MM-dd').parse(dateStr);

//       // Check if attendance already exists
//       final existingAttendance = await FirebaseFirestore.instance
//           .collection('attendance')
//           .where('studentId', isEqualTo: studentId)
//           .where('date', isEqualTo: Timestamp.fromDate(date))
//           .get();

//       if (existingAttendance.docs.isNotEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Attendance already recorded for this student on this date.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         return;
//       }

//       final bool? confirm = await showDialog<bool>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Mark Attendance for ${studentData['student_name']}'),
//           content: Text(
//             'Date: $dateStr\n'
//             'Class: ${studentData['class']}\n'
//             'Division: ${studentData['division']}\n'
//             'Roll No: ${studentData['roll_number']}\n'
//             'Status: ${status.capitalize()}',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context, false),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pop(context, true),
//               child: const Text('Confirm'),
//             ),
//           ],
//         ),
//       );

//       if (confirm == true) {
//         try {
//           await FirebaseFirestore.instance.collection('attendance').add({
//             'studentId': studentId,
//             'studentName': studentData['student_name'],
//             'className': studentData['class'],
//             'division': studentData['division'],
//             'rollNo': studentData['roll_number'],
//             'status': status,
//             'date': Timestamp.fromDate(date),
//           });
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Attendance marked as ${status.capitalize()}'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         } catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Error marking attendance: $e'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid date format'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Widget _buildAttendanceTab() {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator(color: Colors.white));
//     }
//     if (_errorMessage != null) {
//       return Center(
//         child: Text(
//           _errorMessage!,
//           style: const TextStyle(color: Colors.redAccent, fontSize: 16),
//         ),
//       );
//     }
//     if (_studentData == null || _studentData!['class'] == null) {
//       return const Center(
//         child: Text(
//           'Unable to load class information.',
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//       );
//     }

//     final String classNumber = _studentData!['class'];

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Date Picker
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _dateController,
//                     decoration: InputDecoration(
//                       labelText: 'Date',
//                       labelStyle: const TextStyle(color: Colors.white),
//                       enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
//                       focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
//                       suffixIcon: IconButton(
//                         icon: const Icon(Icons.calendar_today, color: Colors.white),
//                         onPressed: () {
//                           showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2100),
//                           ).then((selectedDate) {
//                             if (selectedDate != null) {
//                               setState(() {
//                                 _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//                               });
//                             }
//                           });
//                         },
//                       ),
//                     ),
//                     style: const TextStyle(color: Colors.white),
//                     readOnly: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Student Grid
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Text(
//               'Mark Attendance for Class $classNumber on ${_dateController.text}',
//               style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('users')
//                 .where('class', isEqualTo: classNumber)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return const Center(
//                   child: Text('Error loading students', style: TextStyle(color: Colors.white)),
//                 );
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator(color: Colors.white));
//               }
//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const Center(
//                   child: Text(
//                     'No students found for this class.',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 );
//               }

//               final students = snapshot.data!.docs;
//               return GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.85,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                 ),
//                 itemCount: students.length,
//                 itemBuilder: (context, index) {
//                   final data = students[index].data() as Map<String, dynamic>;
//                   final studentId = students[index].id;

//                   return Card(
//                     elevation: 3,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             data['student_name'] ?? 'Unknown',
//                             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                             textAlign: TextAlign.center,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: 6),
//                           Text('Div: ${data['division'] ?? 'N/A'}', style: const TextStyle(fontSize: 12)),
//                           Text('Roll: ${data['roll_number'] ?? 'N/A'}', style: const TextStyle(fontSize: 12)),
//                           const SizedBox(height: 12),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               // Present Button
//                               GestureDetector(
//                                 onTap: () => _markAttendance(studentId, data, 'present'),
//                                 child: Container(
//                                   width: 80,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                     color: Colors.green.shade600,
//                                     borderRadius: BorderRadius.circular(20),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.green.withOpacity(0.3),
//                                         spreadRadius: 1,
//                                         blurRadius: 5,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: const [
//                                       Icon(Icons.check_circle, color: Colors.white, size: 20),
//                                       SizedBox(width: 4),
//                                       Text(
//                                         'Present',
//                                         style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               // Absent Button
//                               GestureDetector(
//                                 onTap: () => _markAttendance(studentId, data, 'absent'),
//                                 child: Container(
//                                   width: 80,
//                                   height: 40,
//                                   decoration: BoxDecoration(
//                                     color: Colors.red.shade600,
//                                     borderRadius: BorderRadius.circular(20),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.red.withOpacity(0.3),
//                                         spreadRadius: 1,
//                                         blurRadius: 5,
//                                         offset: const Offset(0, 2),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: const [
//                                       Icon(Icons.cancel, color: Colors.white, size: 20),
//                                       SizedBox(width: 4),
//                                       Text(
//                                         'Absent',
//                                         style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           // Attendance Records
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//             child: Text(
//               'Attendance Records for Class $classNumber on ${_dateController.text}',
//               style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('attendance')
//                 .where('className', isEqualTo: classNumber)
//                 .where('date', isEqualTo: Timestamp.fromDate(DateFormat('yyyy-MM-dd').parse(_dateController.text)))
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return const Text('Error loading attendance records', style: TextStyle(color: Colors.white));
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator(color: Colors.white));
//               }
//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const Text(
//                   'No attendance records found for this date.',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 );
//               }

//               final attendanceRecords = snapshot.data!.docs;
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: attendanceRecords.length,
//                 itemBuilder: (context, index) {
//                   final attendance = Attendance.fromMap(attendanceRecords[index].data() as Map<String, dynamic>);
//                   return ListTile(
//                     title: Text(
//                       attendance.studentName,
//                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       'Roll No: ${attendance.rollNo} | Division: ${attendance.division}',
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                     trailing: Text(
//                       attendance.status.capitalize(),
//                       style: TextStyle(
//                         color: attendance.status == 'present' ? Colors.green : Colors.red,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color.fromARGB(255, 4, 45, 50), // Darker Teal
//               Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//               Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
//               Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Top Section: Student Information
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0, bottom: 20.0),
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(
//                           child: Text(
//                             _errorMessage!,
//                             style: const TextStyle(color: Colors.redAccent, fontSize: 16),
//                           ),
//                         )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               _studentData?['student_name'] ?? 'N/A',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Class: ${_studentData?['class'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Division: ${_studentData?['division'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Roll No: ${_studentData?['roll_number'] ?? 'N/A'}',
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//             ),

//             // Tab Bar
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(
//                   top: BorderSide(color: Colors.white54, width: 0.5),
//                   bottom: BorderSide(color: Colors.white54, width: 0.5),
//                 ),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 unselectedLabelStyle: const TextStyle(fontSize: 16),
//                 tabs: const [
//                   Tab(text: 'Results'),
//                   Tab(text: 'Progress'),
//                   Tab(text: 'Attendance'),
//                 ],
//               ),
//             ),

//             // Tab Bar View
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _isLoading
//                       ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                       : ResultsTabContent(studentId: widget.studentId),
//                   _isLoading
//                       ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                       : ProgressTabContent(studentId: widget.studentId),
//                   _buildAttendanceTab(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Placeholder Widgets for Tab Content
// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text(
//             'Your Test Results will appear here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddTestPage(studentId: studentId),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF40A4D0),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text(
//             'Your learning progress charts and insights will be displayed here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Extension to capitalize strings
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${substring(1)}";
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart'; // Ensure this file exists with AddTestPage

// class Classespage extends StatefulWidget {
//   final String studentId;

//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;
//   late DateTime currentDate;

//   @override
//   void initState() {
//     super.initState();
//     _tabController =
//         TabController(length: 3, vsync: this); // Results, Progress, Basic Info
//     _fetchStudentData();
//     currentDate = DateTime.now();
//     _dateController = TextEditingController(
//         text: DateFormat('yyyy-MM-dd').format(currentDate));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     try {
//       DocumentSnapshot studentDoc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.studentId)
//           .get();

//       if (studentDoc.exists) {
//         setState(() {
//           _studentData = studentDoc.data() as Map<String, dynamic>?;
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _errorMessage = 'Student data not found.';
//           _isLoading = false;
//         });
//         print('Error: Student document with ID ${widget.studentId} not found.');
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load student data: $e';
//         _isLoading = false;
//       });
//       print('Error fetching student data: $e');
//     }
//   }

//   // Placeholder method to fetch test results (to be implemented with real data)
//   Future<List<Map<String, dynamic>>> _fetchTestResults() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('test_results')
//           .where('studentId', isEqualTo: widget.studentId)
//           .get();
//       return snapshot.docs
//           .map((doc) => doc.data() as Map<String, dynamic>)
//           .toList();
//     } catch (e) {
//       print('Error fetching test results: $e');
//       return [];
//     }
//   }

//   // Placeholder method to fetch attendance stats (to be implemented with real data)
//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('attendance')
//           .where('studentId', isEqualTo: widget.studentId)
//           .get();
//       int totalClasses = snapshot.docs.length;
//       int present =
//           snapshot.docs.where((doc) => doc['status'] == 'present').length;
//       int absent =
//           snapshot.docs.where((doc) => doc['status'] == 'absent').length;
//       int onLeave =
//           snapshot.docs.where((doc) => doc['status'] == 'on_leave').length;
//       return {
//         'totalClasses': totalClasses,
//         'present': present,
//         'absent': absent,
//         'onLeave': onLeave,
//       };
//     } catch (e) {
//       print('Error fetching attendance stats: $e');
//       return {'totalClasses': 0, 'present': 0, 'absent': 0, 'onLeave': 0};
//     }
//   }

//   // Placeholder method to fetch test progress (to be implemented with real data)
//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     try {
//       QuerySnapshot snapshot = await FirebaseFirestore.instance
//           .collection('test_results')
//           .where('studentId', isEqualTo: widget.studentId)
//           .get();
//       int totalTests = snapshot.docs.length;
//       int attended = snapshot.docs.length; // Assume all are attended for now
//       int failed = snapshot.docs
//           .where((doc) => (doc['obtained'] / doc['total']) < 0.5)
//           .length; // 50% threshold
//       int absent = 0; // To be implemented based on attendance data
//       double averagePercentage = snapshot.docs.isNotEmpty
//           ? snapshot.docs
//                   .map((doc) => (doc['obtained'] / doc['total']) * 100)
//                   .reduce((a, b) => a + b) /
//               snapshot.docs.length
//           : 0.0;
//       return {
//         'totalTests': totalTests,
//         'attended': attended,
//         'failed': failed,
//         'absent': absent,
//         'averagePercentage': averagePercentage,
//       };
//     } catch (e) {
//       print('Error fetching test progress: $e');
//       return {
//         'totalTests': 0,
//         'attended': 0,
//         'failed': 0,
//         'absent': 0,
//         'averagePercentage': 0.0
//       };
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color.fromARGB(255, 4, 45, 50),
//               Color.fromARGB(255, 13, 74, 83),
//               Color.fromARGB(255, 13, 65, 71),
//               Color.fromARGB(255, 3, 42, 47),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Student Profile Header
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundImage: NetworkImage(
//                         'https://via.placeholder.com/150'), // Replace with actual image URL
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           _studentData?['student_name'] ?? 'N/A',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Text(
//                           'Roll No: ${_studentData?['roll_number'] ?? 'N/A'}',
//                           style: const TextStyle(
//                               color: Colors.white70, fontSize: 16),
//                         ),
//                         Text(
//                           'Session Year: ${_studentData?['session_year'] ?? 'N/A'}',
//                           style: const TextStyle(
//                               color: Colors.white70, fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Tab Bar
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(
//                   top: BorderSide(color: Colors.white54, width: 0.5),
//                   bottom: BorderSide(color: Colors.white54, width: 0.5),
//                 ),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 unselectedLabelStyle: const TextStyle(fontSize: 16),
//                 tabs: const [
//                   Tab(text: 'Results'),
//                   Tab(text: 'Progress'),
//                   Tab(text: 'Basic Info'),
//                 ],
//               ),
//             ),

//             // Tab Bar View
//             Expanded(
//               child: _isLoading
//                   ? const Center(
//                       child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(
//                           child: Text(
//                             _errorMessage!,
//                             style: const TextStyle(
//                                 color: Colors.redAccent, fontSize: 16),
//                           ),
//                         )
//                       : FutureBuilder<List<Map<String, dynamic>>>(
//                           future: _fetchTestResults(),
//                           builder: (context, testSnapshot) {
//                             return FutureBuilder<Map<String, int>>(
//                               future: _fetchAttendanceStats(),
//                               builder: (context, attendanceSnapshot) {
//                                 return FutureBuilder<Map<String, dynamic>>(
//                                   future: _fetchTestProgress(),
//                                   builder: (context, progressSnapshot) {
//                                     if (testSnapshot.connectionState ==
//                                             ConnectionState.waiting ||
//                                         attendanceSnapshot.connectionState ==
//                                             ConnectionState.waiting ||
//                                         progressSnapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                       return const Center(
//                                           child: CircularProgressIndicator(
//                                               color: Colors.white));
//                                     }
//                                     if (testSnapshot.hasError ||
//                                         attendanceSnapshot.hasError ||
//                                         progressSnapshot.hasError) {
//                                       return const Center(
//                                         child: Text(
//                                           'Error loading data',
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       );
//                                     }

//                                     final testResults = testSnapshot.data ?? [];
//                                     final attendanceStats =
//                                         attendanceSnapshot.data ?? {};
//                                     final testProgress =
//                                         progressSnapshot.data ?? {};

//                                     return TabBarView(
//                                       controller: _tabController,
//                                       children: [
//                                         // Results Tab
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: testResults.map((result) {
//                                               double percentage =
//                                                   (result['obtained'] /
//                                                           result['total']) *
//                                                       100;
//                                               bool isPass = percentage >= 50;
//                                               return Card(
//                                                 margin:
//                                                     const EdgeInsets.all(8.0),
//                                                 color: Colors.white
//                                                     .withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                             'Test Date: ${DateFormat('dd MMM yyyy').format((result['date'] as Timestamp).toDate())}',
//                                                             style:
//                                                                 const TextStyle(
//                                                                     fontSize:
//                                                                         16),
//                                                           ),
//                                                           const Icon(
//                                                               Icons
//                                                                   .airplane_ticket,
//                                                               color:
//                                                                   Colors.blue),
//                                                         ],
//                                                       ),
//                                                       const SizedBox(height: 8),
//                                                       Text(
//                                                         result['test_name'] ??
//                                                             'Unnamed Test',
//                                                         style: const TextStyle(
//                                                           fontSize: 18,
//                                                           fontWeight:
//                                                               FontWeight.bold,
//                                                         ),
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 16),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceEvenly,
//                                                         children: [
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Obtained',
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                               Text(
//                                                                 '${result['obtained']}',
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Total',
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                               Text(
//                                                                 '${result['total']}',
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text('%age',
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                               Text(
//                                                                 '${percentage.toStringAsFixed(0)}%',
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 20,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 16),
//                                                       Center(
//                                                         child: Text(
//                                                           isPass
//                                                               ? 'Pass'
//                                                               : 'Fail',
//                                                           style: TextStyle(
//                                                             color: isPass
//                                                                 ? Colors.green
//                                                                 : Colors.red,
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                         // Progress Tab
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               Card(
//                                                 margin:
//                                                     const EdgeInsets.all(8.0),
//                                                 color: Colors.white
//                                                     .withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           const Text(
//                                                             'Attendance:',
//                                                             style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                           const Icon(
//                                                               Icons
//                                                                   .calendar_today,
//                                                               color:
//                                                                   Colors.blue),
//                                                         ],
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 16),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceEvenly,
//                                                         children: [
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Total Classes',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .blue)),
//                                                               Text(
//                                                                   '${attendanceStats['totalClasses'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Present',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .green)),
//                                                               Text(
//                                                                   '${attendanceStats['present'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Absent',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .red)),
//                                                               Text(
//                                                                   '${attendanceStats['absent'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'On Leave',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .orange)),
//                                                               Text(
//                                                                   '${attendanceStats['onLeave'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Card(
//                                                 margin:
//                                                     const EdgeInsets.all(8.0),
//                                                 color: Colors.white
//                                                     .withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           const Text(
//                                                             'Test Progress:',
//                                                             style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                           const Icon(
//                                                               Icons.bar_chart,
//                                                               color:
//                                                                   Colors.blue),
//                                                         ],
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 16),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceEvenly,
//                                                         children: [
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Total Tests',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .blue)),
//                                                               Text(
//                                                                   '${testProgress['totalTests'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Attended',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .green)),
//                                                               Text(
//                                                                   '${testProgress['attended'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Failed',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .red)),
//                                                               Text(
//                                                                   '${testProgress['failed'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                           Column(
//                                                             children: [
//                                                               const Text(
//                                                                   'Absent',
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .orange)),
//                                                               Text(
//                                                                   '${testProgress['absent'] ?? 0}',
//                                                                   style: const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                             ],
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       const SizedBox(
//                                                           height: 16),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           const Text(
//                                                               'Average %',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .purple)),
//                                                           Text(
//                                                               '${testProgress['averagePercentage'].toStringAsFixed(2) ?? '0.0'}%',
//                                                               style:
//                                                                   const TextStyle(
//                                                                       fontSize:
//                                                                           16)),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         // Basic Info Tab
//                                         const Center(
//                                           child: Text(
//                                             'Basic Info will be displayed here.',
//                                             style: TextStyle(
//                                                 color: Colors.white70,
//                                                 fontSize: 18),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Placeholder Widgets for Tab Content (unchanged but included for completeness)
// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text(
//             'Your Test Results will appear here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddTestPage(studentId: studentId),
//                 ),
//               );
//             },
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test',
//                 style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF40A4D0),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text(
//             'Your learning progress charts and insights will be displayed here.',
//             style: TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Extension to capitalize strings
// extension StringExtension on String {
//   String capitalize() {
//     return "${this[0].toUpperCase()}${substring(1)}";
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId;
//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchStudentData();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() => _isLoading = true);
//     try {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(widget.studentId).get();
//       if (doc.exists) setState(() => _studentData = doc.data() as Map<String, dynamic>?);
//       else setState(() => _errorMessage = 'Student data not found.');
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://via.placeholder.com/150')),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(_studentData?['student_name'] ?? 'N/A', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//                         Text('Roll No: ${_studentData?['roll_number'] ?? 'N/A'}', style: const TextStyle(color: Colors.white70, fontSize: 16)),
//                         Text('Session Year: ${_studentData?['session_year'] ?? 'N/A'}', style: const TextStyle(color: Colors.white70, fontSize: 16)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white54, width: 0.5), bottom: BorderSide(color: Colors.white54, width: 0.5))),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: const [Tab(text: 'Results'), Tab(text: 'Progress')],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : FutureBuilder<List<Map<String, dynamic>>>(
//                           future: _fetchTestResults(),
//                           builder: (context, testSnapshot) => FutureBuilder<Map<String, int>>(
//                             future: _fetchAttendanceStats(),
//                             builder: (context, attendanceSnapshot) => FutureBuilder<Map<String, dynamic>>(
//                               future: _fetchTestProgress(),
//                               builder: (context, progressSnapshot) {
//                                 if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.connectionState == ConnectionState.waiting)) {
//                                   return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                 }
//                                 if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.hasError)) {
//                                   return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                 }
//                                 final testResults = testSnapshot.data ?? [];
//                                 final attendanceStats = attendanceSnapshot.data ?? {};
//                                 final testProgress = progressSnapshot.data ?? {};
//                                 return TabBarView(
//                                   controller: _tabController,
//                                   children: [
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         children: testResults.map((r) {
//                                           final percentage = (r['obtained'] / r['total']) * 100;
//                                           return Card(
//                                             margin: const EdgeInsets.all(8.0),
//                                             color: Colors.white.withOpacity(0.9),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(16.0),
//                                               child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children: [
//                                                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                     Text(DateFormat('dd MMM yyyy').format((r['date'] as Timestamp).toDate()), style: const TextStyle(fontSize: 16)),
//                                                     const Icon(Icons.airplane_ticket, color: Colors.blue),
//                                                   ]),
//                                                   const SizedBox(height: 8),
//                                                   Text(r['test_name'] ?? 'Unnamed Test', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                                                   const SizedBox(height: 16),
//                                                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                     Column(children: [const Text('Obtained', style: TextStyle(fontSize: 16)), Text('${r['obtained']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                     Column(children: [const Text('Total', style: TextStyle(fontSize: 16)), Text('${r['total']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                     Column(children: [const Text('%age', style: TextStyle(fontSize: 16)), Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                   ]),
//                                                   const SizedBox(height: 16),
//                                                   Center(child: Text(percentage >= 50 ? 'Pass' : 'Fail', style: TextStyle(color: percentage >= 50 ? Colors.green : Colors.red, fontSize: 16, fontWeight: FontWeight.bold))),
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         }).toList(),
//                                       ),
//                                     ),
//                                     SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           Card(
//                                             margin: const EdgeInsets.all(8.0),
//                                             color: Colors.white.withOpacity(0.9),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(16.0),
//                                               child: Column(
//                                                 children: [
//                                                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.calendar_today, color: Colors.blue)]),
//                                                   const SizedBox(height: 16),
//                                                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                     Column(children: [const Text('Total Classes', style: TextStyle(color: Colors.blue)), Text('${attendanceStats['totalClasses'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                     Column(children: [const Text('Present', style: TextStyle(color: Colors.green)), Text('${attendanceStats['present'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                     Column(children: [const Text('Absent', style: TextStyle(color: Colors.red)), Text('${attendanceStats['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                     Column(children: [const Text('On Leave', style: TextStyle(color: Colors.orange)), Text('${attendanceStats['onLeave'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                   ]),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                           Card(
//                                             margin: const EdgeInsets.all(8.0),
//                                             color: Colors.white.withOpacity(0.9),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(16.0),
//                                               child: Column(
//                                                 children: [
//                                                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Test Progress:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.bar_chart, color: Colors.blue)]),
//                                                   const SizedBox(height: 16),
//                                                   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                     Column(children: [const Text('Total Tests', style: TextStyle(color: Colors.blue)), Text('${testProgress['totalTests'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                     Column(children: [const Text('Attended', style: TextStyle(color: Colors.green)), Text('${testProgress['attended'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                     Column(children: [const Text('Failed', style: TextStyle(color: Colors.red)), Text('${testProgress['failed'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                     Column(children: [const Text('Absent', style: TextStyle(color: Colors.orange)), Text('${testProgress['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                   ]),
//                                                   const SizedBox(height: 16),
//                                                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                                     const Text('Average %', style: TextStyle(color: Colors.purple)),
//                                                     Text('${testProgress['averagePercentage'].toStringAsFixed(2) ?? '0.0'}%', style: const TextStyle(fontSize: 16)),
//                                                   ]),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text('Your Test Results will appear here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTestPage(studentId: studentId))),
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF40A4D0), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text('Your learning progress charts and insights will be displayed here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
// }




// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId;
//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 14, vsync: this); // 12 class tabs + Results + Progress
//     _fetchStudentData();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() => _isLoading = true);
//     try {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(widget.studentId).get();
//       if (doc.exists) setState(() => _studentData = doc.data() as Map<String, dynamic>?);
//       else setState(() => _errorMessage = 'Student data not found.');
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   Widget _buildStudentList(String classNumber) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('class', isEqualTo: classNumber)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.white));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No students found for this class.', style: TextStyle(color: Colors.white, fontSize: 18)));
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
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 title: Text('Name: ${data['student_name'] ?? 'Unknown'}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text('Class: ${data['class'] ?? 'N/A'}\nDivision: ${data['division'] ?? 'N/A'}\nRoll No: ${data['roll_number'] ?? 'N/A'}'),
//                 leading: const Icon(Icons.person, color: Colors.teal),
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
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 children: [
//                   CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://via.placeholder.com/150')),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(_studentData?['student_name'] ?? 'N/A', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//                         Text('Roll No: ${_studentData?['roll_number'] ?? 'N/A'}', style: const TextStyle(color: Colors.white70, fontSize: 16)),
//                         Text('Session Year: ${_studentData?['session_year'] ?? 'N/A'}', style: const TextStyle(color: Colors.white70, fontSize: 16)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white54, width: 0.5), bottom: BorderSide(color: Colors.white54, width: 0.5))),
//               child: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: [
//                   for (int i = 1; i <= 12; i++) Tab(text: 'Class $i'),
//                   const Tab(text: 'Results'),
//                   const Tab(text: 'Progress'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             for (int i = 1; i <= 12; i++) _buildStudentList(i.toString()),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) => FutureBuilder<Map<String, int>>(
//                                 future: _fetchAttendanceStats(),
//                                 builder: (context, attendanceSnapshot) => FutureBuilder<Map<String, dynamic>>(
//                                   future: _fetchTestProgress(),
//                                   builder: (context, progressSnapshot) {
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.connectionState == ConnectionState.waiting)) {
//                                       return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                     }
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.hasError)) {
//                                       return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                     }
//                                     final testResults = testSnapshot.data ?? [];
//                                     final attendanceStats = attendanceSnapshot.data ?? {};
//                                     final testProgress = progressSnapshot.data ?? {};
//                                     return TabBarView(
//                                       controller: _tabController,
//                                       children: [
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: testResults.map((r) {
//                                               final percentage = (r['obtained'] / r['total']) * 100;
//                                               return Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                         Text(DateFormat('dd MMM yyyy').format((r['date'] as Timestamp).toDate()), style: const TextStyle(fontSize: 16)),
//                                                         const Icon(Icons.airplane_ticket, color: Colors.blue),
//                                                       ]),
//                                                       const SizedBox(height: 8),
//                                                       Text(r['test_name'] ?? 'Unnamed Test', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Obtained', style: TextStyle(fontSize: 16)), Text('${r['obtained']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('Total', style: TextStyle(fontSize: 16)), Text('${r['total']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('%age', style: TextStyle(fontSize: 16)), Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Center(child: Text(percentage >= 50 ? 'Pass' : 'Fail', style: TextStyle(color: percentage >= 50 ? Colors.green : Colors.red, fontSize: 16, fontWeight: FontWeight.bold))),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.calendar_today, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Classes', style: TextStyle(color: Colors.blue)), Text('${attendanceStats['totalClasses'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Present', style: TextStyle(color: Colors.green)), Text('${attendanceStats['present'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.red)), Text('${attendanceStats['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('On Leave', style: TextStyle(color: Colors.orange)), Text('${attendanceStats['onLeave'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Test Progress:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.bar_chart, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Tests', style: TextStyle(color: Colors.blue)), Text('${testProgress['totalTests'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Attended', style: TextStyle(color: Colors.green)), Text('${testProgress['attended'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Failed', style: TextStyle(color: Colors.red)), Text('${testProgress['failed'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.orange)), Text('${testProgress['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                                         const Text('Average %', style: TextStyle(color: Colors.purple)),
//                                                         Text('${testProgress['averagePercentage'].toStringAsFixed(2) ?? '0.0'}%', style: const TextStyle(fontSize: 16)),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text('Your Test Results will appear here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTestPage(studentId: studentId))),
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF40A4D0), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text('Your learning progress charts and insights will be displayed here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId;
//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 14, vsync: this); // 12 class tabs + Results + Progress
//     _fetchStudentData();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() => _isLoading = true);
//     try {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(widget.studentId).get();
//       if (doc.exists) setState(() => _studentData = doc.data() as Map<String, dynamic>?);
//       else setState(() => _errorMessage = 'Student data not found.');
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   Widget _buildStudentList(String classNumber) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('class', isEqualTo: classNumber)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.white));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No students found for this class.', style: TextStyle(color: Colors.white, fontSize: 18)));
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
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 title: Text('Name: ${data['student_name'] ?? 'Unknown'}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text('Class: ${data['class'] ?? 'N/A'}\nDivision: ${data['division'] ?? 'N/A'}\nRoll No: ${data['roll_number'] ?? 'N/A'}'),
//                 leading: const Icon(Icons.person, color: Colors.teal),
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
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Removed the student profile header (name, roll no, session year)
//             Container(
//               decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white54, width: 0.5), bottom: BorderSide(color: Colors.white54, width: 0.5))),
//               child: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: [
//                   for (int i = 1; i <= 12; i++) Tab(text: 'Class $i'),
//                   const Tab(text: 'Results'),
//                   const Tab(text: 'Progress'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             for (int i = 1; i <= 12; i++) _buildStudentList(i.toString()),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) => FutureBuilder<Map<String, int>>(
//                                 future: _fetchAttendanceStats(),
//                                 builder: (context, attendanceSnapshot) => FutureBuilder<Map<String, dynamic>>(
//                                   future: _fetchTestProgress(),
//                                   builder: (context, progressSnapshot) {
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.connectionState == ConnectionState.waiting)) {
//                                       return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                     }
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.hasError)) {
//                                       return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                     }
//                                     final testResults = testSnapshot.data ?? [];
//                                     final attendanceStats = attendanceSnapshot.data ?? {};
//                                     final testProgress = progressSnapshot.data ?? {};
//                                     return TabBarView(
//                                       controller: _tabController,
//                                       children: [
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: testResults.map((r) {
//                                               final percentage = (r['obtained'] / r['total']) * 100;
//                                               return Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                         Text(DateFormat('dd MMM yyyy').format((r['date'] as Timestamp).toDate()), style: const TextStyle(fontSize: 16)),
//                                                         const Icon(Icons.airplane_ticket, color: Colors.blue),
//                                                       ]),
//                                                       const SizedBox(height: 8),
//                                                       Text(r['test_name'] ?? 'Unnamed Test', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Obtained', style: TextStyle(fontSize: 16)), Text('${r['obtained']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('Total', style: TextStyle(fontSize: 16)), Text('${r['total']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('%age', style: TextStyle(fontSize: 16)), Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Center(child: Text(percentage >= 50 ? 'Pass' : 'Fail', style: TextStyle(color: percentage >= 50 ? Colors.green : Colors.red, fontSize: 16, fontWeight: FontWeight.bold))),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.calendar_today, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Classes', style: TextStyle(color: Colors.blue)), Text('${attendanceStats['totalClasses'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Present', style: TextStyle(color: Colors.green)), Text('${attendanceStats['present'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.red)), Text('${attendanceStats['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('On Leave', style: TextStyle(color: Colors.orange)), Text('${attendanceStats['onLeave'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Test Progress:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.bar_chart, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Tests', style: TextStyle(color: Colors.blue)), Text('${testProgress['totalTests'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Attended', style: TextStyle(color: Colors.green)), Text('${testProgress['attended'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Failed', style: TextStyle(color: Colors.red)), Text('${testProgress['failed'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.orange)), Text('${testProgress['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                                         const Text('Average %', style: TextStyle(color: Colors.purple)),
//                                                         Text('${testProgress['averagePercentage'].toStringAsFixed(2) ?? '0.0'}%', style: const TextStyle(fontSize: 16)),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text('Your Test Results will appear here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTestPage(studentId: studentId))),
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF40A4D0), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text('Your learning progress charts and insights will be displayed here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
// }

// 

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId;
//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 14, vsync: this); // 12 class tabs + Results + Progress
//     _fetchStudentData();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() => _isLoading = true);
//     try {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(widget.studentId).get();
//       if (doc.exists) setState(() => _studentData = doc.data() as Map<String, dynamic>?);
//       else setState(() => _errorMessage = 'Student data not found.');
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   Widget _buildStudentList(String classNumber) {
//     return DefaultTabController(
//       length: 3, // Divisions A, B, C
//       child: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5)),
//             ),
//             child: TabBar(
//               indicatorColor: Colors.white,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white70,
//               labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               tabs: const [
//                 Tab(text: 'Division A'),
//                 Tab(text: 'Division B'),
//                 Tab(text: 'Division C'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 _buildDivisionList(classNumber, 'A'),
//                 _buildDivisionList(classNumber, 'B'),
//                 _buildDivisionList(classNumber, 'C'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivisionList(String classNumber, String division) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('class', isEqualTo: classNumber)
//           .where('division', isEqualTo: division)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.white));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No students found for this division.', style: TextStyle(color: Colors.white, fontSize: 18)));
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
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 title: Text('Name: ${data['student_name'] ?? 'Unknown'}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text('Class: ${data['class'] ?? 'N/A'}\nDivision: ${data['division'] ?? 'N/A'}\nRoll No: ${data['roll_number'] ?? 'N/A'}'),
//                 leading: const Icon(Icons.person, color: Colors.teal),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => StudentDetailPage(studentId: docId),
//                     ),
//                   );
//                 },
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
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Removed the student profile header (name, roll no, session year)
//             Container(
//               decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white54, width: 0.5), bottom: BorderSide(color: Colors.white54, width: 0.5))),
//               child: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: [
//                   for (int i = 1; i <= 12; i++) Tab(text: 'Class $i'),
//                   const Tab(text: 'Results'),
//                   const Tab(text: 'Progress'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             for (int i = 1; i <= 12; i++) _buildStudentList(i.toString()),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) => FutureBuilder<Map<String, int>>(
//                                 future: _fetchAttendanceStats(),
//                                 builder: (context, attendanceSnapshot) => FutureBuilder<Map<String, dynamic>>(
//                                   future: _fetchTestProgress(),
//                                   builder: (context, progressSnapshot) {
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.connectionState == ConnectionState.waiting)) {
//                                       return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                     }
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.hasError)) {
//                                       return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                     }
//                                     final testResults = testSnapshot.data ?? [];
//                                     final attendanceStats = attendanceSnapshot.data ?? {};
//                                     final testProgress = progressSnapshot.data ?? {};
//                                     return TabBarView(
//                                       controller: _tabController,
//                                       children: [
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: testResults.map((r) {
//                                               final percentage = (r['obtained'] / r['total']) * 100;
//                                               return Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                         Text(DateFormat('dd MMM yyyy').format((r['date'] as Timestamp).toDate()), style: const TextStyle(fontSize: 16)),
//                                                         const Icon(Icons.airplane_ticket, color: Colors.blue),
//                                                       ]),
//                                                       const SizedBox(height: 8),
//                                                       Text(r['test_name'] ?? 'Unnamed Test', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Obtained', style: TextStyle(fontSize: 16)), Text('${r['obtained']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('Total', style: TextStyle(fontSize: 16)), Text('${r['total']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('%age', style: TextStyle(fontSize: 16)), Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Center(child: Text(percentage >= 50 ? 'Pass' : 'Fail', style: TextStyle(color: percentage >= 50 ? Colors.green : Colors.red, fontSize: 16, fontWeight: FontWeight.bold))),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.calendar_today, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Classes', style: TextStyle(color: Colors.blue)), Text('${attendanceStats['totalClasses'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Present', style: TextStyle(color: Colors.green)), Text('${attendanceStats['present'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.red)), Text('${attendanceStats['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('On Leave', style: TextStyle(color: Colors.orange)), Text('${attendanceStats['onLeave'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Test Progress:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.bar_chart, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Tests', style: TextStyle(color: Colors.blue)), Text('${testProgress['totalTests'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Attended', style: TextStyle(color: Colors.green)), Text('${testProgress['attended'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Failed', style: TextStyle(color: Colors.red)), Text('${testProgress['failed'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.orange)), Text('${testProgress['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                                         const Text('Average %', style: TextStyle(color: Colors.purple)),
//                                                         Text('${testProgress['averagePercentage'].toStringAsFixed(2) ?? '0.0'}%', style: const TextStyle(fontSize: 16)),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StudentDetailPage extends StatefulWidget {
//   final String studentId;
//   const StudentDetailPage({super.key, required this.studentId});

//   @override
//   State<StudentDetailPage> createState() => _StudentDetailPageState();
// }

// class _StudentDetailPageState extends State<StudentDetailPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this); // Progress and Results
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Details'),
//         backgroundColor: const Color(0xFF0D4A53),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5)),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: const [
//                   Tab(text: 'Progress'),
//                   Tab(text: 'Results'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             FutureBuilder<Map<String, int>>(
//                               future: _fetchAttendanceStats(),
//                               builder: (context, attendanceSnapshot) => FutureBuilder<Map<String, dynamic>>(
//                                 future: _fetchTestProgress(),
//                                 builder: (context, progressSnapshot) {
//                                   if (attendanceSnapshot.connectionState == ConnectionState.waiting || progressSnapshot.connectionState == ConnectionState.waiting) {
//                                     return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                   }
//                                   if (attendanceSnapshot.hasError || progressSnapshot.hasError) {
//                                     return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                   }
//                                   final attendanceStats = attendanceSnapshot.data ?? {};
//                                   final testProgress = progressSnapshot.data ?? {};
//                                   return ProgressTabContent(studentId: widget.studentId);
//                                 },
//                               ),
//                             ),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) {
//                                 if (testSnapshot.connectionState == ConnectionState.waiting) {
//                                   return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                 }
//                                 if (testSnapshot.hasError) {
//                                   return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                 }
//                                 final testResults = testSnapshot.data ?? [];
//                                 return ResultsTabContent(studentId: widget.studentId);
//                               },
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text('Your Test Results will appear here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTestPage(studentId: studentId))),
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF40A4D0), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final String studentId;
//   const ProgressTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.trending_up, size: 80, color: Colors.white70),
//           SizedBox(height: 16),
//           Text('Your learning progress charts and insights will be displayed here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId;
//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 14, vsync: this); // 12 class tabs + Results + Progress
//     _fetchStudentData();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() => _isLoading = true);
//     try {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(widget.studentId).get();
//       if (doc.exists) setState(() => _studentData = doc.data() as Map<String, dynamic>?);
//       else setState(() => _errorMessage = 'Student data not found.');
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   Widget _buildStudentList(String classNumber) {
//     return DefaultTabController(
//       length: 3, // Divisions A, B, C
//       child: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5)),
//             ),
//             child: TabBar(
//               indicatorColor: Colors.white,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white70,
//               labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               tabs: const [
//                 Tab(text: 'Division A'),
//                 Tab(text: 'Division B'),
//                 Tab(text: 'Division C'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 _buildDivisionList(classNumber, 'A'),
//                 _buildDivisionList(classNumber, 'B'),
//                 _buildDivisionList(classNumber, 'C'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivisionList(String classNumber, String division) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('class', isEqualTo: classNumber)
//           .where('division', isEqualTo: division)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.white));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No students found for this division.', style: TextStyle(color: Colors.white, fontSize: 18)));
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
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 title: Text('Name: ${data['student_name'] ?? 'Unknown'}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text('Class: ${data['class'] ?? 'N/A'}\nDivision: ${data['division'] ?? 'N/A'}\nRoll No: ${data['roll_number'] ?? 'N/A'}'),
//                 leading: const Icon(Icons.person, color: Colors.teal),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => StudentDetailPage(studentId: docId),
//                     ),
//                   );
//                 },
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
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Removed the student profile header (name, roll no, session year)
//             Container(
//               decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white54, width: 0.5), bottom: BorderSide(color: Colors.white54, width: 0.5))),
//               child: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: [
//                   for (int i = 1; i <= 12; i++) Tab(text: 'Class $i'),
//                   const Tab(text: 'Results'),
//                   const Tab(text: 'Progress'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             for (int i = 1; i <= 12; i++) _buildStudentList(i.toString()),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) => FutureBuilder<Map<String, int>>(
//                                 future: _fetchAttendanceStats(),
//                                 builder: (context, attendanceSnapshot) => FutureBuilder<Map<String, dynamic>>(
//                                   future: _fetchTestProgress(),
//                                   builder: (context, progressSnapshot) {
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.connectionState == ConnectionState.waiting)) {
//                                       return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                     }
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.hasError)) {
//                                       return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                     }
//                                     final testResults = testSnapshot.data ?? [];
//                                     final attendanceStats = attendanceSnapshot.data ?? {};
//                                     final testProgress = progressSnapshot.data ?? {};
//                                     return TabBarView(
//                                       controller: _tabController,
//                                       children: [
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: testResults.map((r) {
//                                               final percentage = (r['obtained'] / r['total']) * 100;
//                                               return Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                         Text(DateFormat('dd MMM yyyy').format((r['date'] as Timestamp).toDate()), style: const TextStyle(fontSize: 16)),
//                                                         const Icon(Icons.airplane_ticket, color: Colors.blue),
//                                                       ]),
//                                                       const SizedBox(height: 8),
//                                                       Text(r['test_name'] ?? 'Unnamed Test', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Obtained', style: TextStyle(fontSize: 16)), Text('${r['obtained']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('Total', style: TextStyle(fontSize: 16)), Text('${r['total']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('%age', style: TextStyle(fontSize: 16)), Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Center(child: Text(percentage >= 50 ? 'Pass' : 'Fail', style: TextStyle(color: percentage >= 50 ? Colors.green : Colors.red, fontSize: 16, fontWeight: FontWeight.bold))),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.calendar_today, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Classes', style: TextStyle(color: Colors.blue)), Text('${attendanceStats['totalClasses'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Present', style: TextStyle(color: Colors.green)), Text('${attendanceStats['present'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.red)), Text('${attendanceStats['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('On Leave', style: TextStyle(color: Colors.orange)), Text('${attendanceStats['onLeave'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Test Progress:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.bar_chart, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Tests', style: TextStyle(color: Colors.blue)), Text('${testProgress['totalTests'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Attended', style: TextStyle(color: Colors.green)), Text('${testProgress['attended'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Failed', style: TextStyle(color: Colors.red)), Text('${testProgress['failed'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.orange)), Text('${testProgress['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                                         const Text('Average %', style: TextStyle(color: Colors.purple)),
//                                                         Text('${testProgress['averagePercentage'].toStringAsFixed(2) ?? '0.0'}%', style: const TextStyle(fontSize: 16)),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StudentDetailPage extends StatefulWidget {
//   final String studentId;
//   const StudentDetailPage({super.key, required this.studentId});

//   @override
//   State<StudentDetailPage> createState() => _StudentDetailPageState();
// }

// class _StudentDetailPageState extends State<StudentDetailPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this); // Progress and Results
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Details'),
//         backgroundColor: const Color(0xFF0D4A53),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5)),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: const [
//                   Tab(text: 'Progress'),
//                   Tab(text: 'Results'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             FutureBuilder<Map<String, int>>(
//                               future: _fetchAttendanceStats(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState == ConnectionState.waiting) {
//                                   return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                 }
//                                 if (snapshot.hasError) {
//                                   return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                 }
//                                 final attendanceStats = snapshot.data ?? {};
//                                 return ProgressTabContent(attendanceStats: attendanceStats);
//                               },
//                             ),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) {
//                                 if (testSnapshot.connectionState == ConnectionState.waiting) {
//                                   return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                 }
//                                 if (testSnapshot.hasError) {
//                                   return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                 }
//                                 final testResults = testSnapshot.data ?? [];
//                                 return ResultsTabContent(studentId: widget.studentId);
//                               },
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text('Your Test Results will appear here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTestPage(studentId: studentId))),
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF40A4D0), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final Map<String, int>? attendanceStats;

//   const ProgressTabContent({super.key, required this.attendanceStats});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Card(
//             margin: const EdgeInsets.all(8.0),
//             color: Colors.white.withOpacity(0.9),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       const Icon(Icons.calendar_today, color: Colors.blue),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           const Text('Total Classes', style: TextStyle(color: Colors.blue)),
//                           Text('${attendanceStats?['totalClasses'] ?? 0}', style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           const Text('Present', style: TextStyle(color: Colors.green)),
//                           Text('${attendanceStats?['present'] ?? 0}', style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           const Text('Absent', style: TextStyle(color: Colors.red)),
//                           Text('${attendanceStats?['absent'] ?? 0}', style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
// }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId;
//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 14, vsync: this); // 12 class tabs + Results + Progress
//     _fetchStudentData();
//     _dateController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() => _isLoading = true);
//     try {
//       final doc = await FirebaseFirestore.instance.collection('users').doc(widget.studentId).get();
//       if (doc.exists) setState(() => _studentData = doc.data() as Map<String, dynamic>?);
//       else setState(() => _errorMessage = 'Student data not found.');
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   Widget _buildStudentList(String classNumber) {
//     return DefaultTabController(
//       length: 3, // Divisions A, B, C
//       child: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5)),
//             ),
//             child: TabBar(
//               indicatorColor: Colors.white,
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white70,
//               labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               tabs: const [
//                 Tab(text: 'Division A'),
//                 Tab(text: 'Division B'),
//                 Tab(text: 'Division C'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 _buildDivisionList(classNumber, 'A'),
//                 _buildDivisionList(classNumber, 'B'),
//                 _buildDivisionList(classNumber, 'C'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivisionList(String classNumber, String division) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('class', isEqualTo: classNumber)
//           .where('division', isEqualTo: division)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)));
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator(color: Colors.white));
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return const Center(child: Text('No students found for this division.', style: TextStyle(color: Colors.white, fontSize: 18)));
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
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               child: ListTile(
//                 title: Text('Name: ${data['student_name'] ?? 'Unknown'}', style: const TextStyle(fontWeight: FontWeight.bold)),
//                 subtitle: Text('Class: ${data['class'] ?? 'N/A'}\nDivision: ${data['division'] ?? 'N/A'}\nRoll No: ${data['roll_number'] ?? 'N/A'}'),
//                 leading: const Icon(Icons.person, color: Colors.teal),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => StudentDetailPage(studentId: docId),
//                     ),
//                   );
//                 },
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
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Removed the student profile header (name, roll no, session year)
//             Container(
//               decoration: const BoxDecoration(border: Border(top: BorderSide(color: Colors.white54, width: 0.5), bottom: BorderSide(color: Colors.white54, width: 0.5))),
//               child: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: [
//                   for (int i = 1; i <= 12; i++) Tab(text: 'Class $i'),
//                   const Tab(text: 'Results'),
//                   const Tab(text: 'Progress'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             for (int i = 1; i <= 12; i++) _buildStudentList(i.toString()),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) => FutureBuilder<Map<String, int>>(
//                                 future: _fetchAttendanceStats(),
//                                 builder: (context, attendanceSnapshot) => FutureBuilder<Map<String, dynamic>>(
//                                   future: _fetchTestProgress(),
//                                   builder: (context, progressSnapshot) {
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.connectionState == ConnectionState.waiting)) {
//                                       return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                     }
//                                     if ([testSnapshot, attendanceSnapshot, progressSnapshot].any((s) => s.hasError)) {
//                                       return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                     }
//                                     final testResults = testSnapshot.data ?? [];
//                                     final attendanceStats = attendanceSnapshot.data ?? {};
//                                     final testProgress = progressSnapshot.data ?? {};
//                                     return TabBarView(
//                                       controller: _tabController,
//                                       children: [
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: testResults.map((r) {
//                                               final percentage = (r['obtained'] / r['total']) * 100;
//                                               return Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                                         Text(DateFormat('dd MMM yyyy').format((r['date'] as Timestamp).toDate()), style: const TextStyle(fontSize: 16)),
//                                                         const Icon(Icons.airplane_ticket, color: Colors.blue),
//                                                       ]),
//                                                       const SizedBox(height: 8),
//                                                       Text(r['test_name'] ?? 'Unnamed Test', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Obtained', style: TextStyle(fontSize: 16)), Text('${r['obtained']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('Total', style: TextStyle(fontSize: 16)), Text('${r['total']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                         Column(children: [const Text('%age', style: TextStyle(fontSize: 16)), Text('${percentage.toStringAsFixed(0)}%', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Center(child: Text(percentage >= 50 ? 'Pass' : 'Fail', style: TextStyle(color: percentage >= 50 ? Colors.green : Colors.red, fontSize: 16, fontWeight: FontWeight.bold))),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               );
//                                             }).toList(),
//                                           ),
//                                         ),
//                                         SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.calendar_today, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Classes', style: TextStyle(color: Colors.blue)), Text('${attendanceStats['totalClasses'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Present', style: TextStyle(color: Colors.green)), Text('${attendanceStats['present'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.red)), Text('${attendanceStats['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('On Leave', style: TextStyle(color: Colors.orange)), Text('${attendanceStats['onLeave'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                               Card(
//                                                 margin: const EdgeInsets.all(8.0),
//                                                 color: Colors.white.withOpacity(0.9),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(16.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Test Progress:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const Icon(Icons.bar_chart, color: Colors.blue)]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//                                                         Column(children: [const Text('Total Tests', style: TextStyle(color: Colors.blue)), Text('${testProgress['totalTests'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Attended', style: TextStyle(color: Colors.green)), Text('${testProgress['attended'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Failed', style: TextStyle(color: Colors.red)), Text('${testProgress['failed'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                         Column(children: [const Text('Absent', style: TextStyle(color: Colors.orange)), Text('${testProgress['absent'] ?? 0}', style: const TextStyle(fontSize: 16))]),
//                                                       ]),
//                                                       const SizedBox(height: 16),
//                                                       Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                                         const Text('Average %', style: TextStyle(color: Colors.purple)),
//                                                         Text('${testProgress['averagePercentage'].toStringAsFixed(2) ?? '0.0'}%', style: const TextStyle(fontSize: 16)),
//                                                       ]),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StudentDetailPage extends StatefulWidget {
//   final String studentId;
//   const StudentDetailPage({super.key, required this.studentId});

//   @override
//   State<StudentDetailPage> createState() => _StudentDetailPageState();
// }

// class _StudentDetailPageState extends State<StudentDetailPage> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this); // Progress and Results
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance.collection('attendance').where('studentId', isEqualTo: widget.studentId).get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance.collection('test_results').where('studentId', isEqualTo: widget.studentId).get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs.where((d) => (d['obtained'] / d['total']) < 0.5).length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs.map((d) => (d['obtained'] / d['total']) * 100).reduce((a, b) => a + b) / totalTests
//         : 0.0;
//     return {'totalTests': totalTests, 'attended': totalTests, 'failed': failed, 'absent': 0, 'averagePercentage': avg};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Details'),
//         backgroundColor: const Color(0xFF0D4A53),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF042D32), Color(0xFF0D4A53), Color(0xFF0D4147), Color(0xFF032A2F)],
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.white54, width: 0.5)),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicatorColor: Colors.white,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 tabs: const [
//                   Tab(text: 'Progress'),
//                   Tab(text: 'Results'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _errorMessage != null
//                       ? Center(child: Text(_errorMessage!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)))
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             FutureBuilder<Map<String, int>>(
//                               future: _fetchAttendanceStats(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.connectionState == ConnectionState.waiting) {
//                                   return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                 }
//                                 if (snapshot.hasError) {
//                                   return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                 }
//                                 final attendanceStats = snapshot.data ?? {};
//                                 return ProgressTabContent(attendanceStats: attendanceStats);
//                               },
//                             ),
//                             FutureBuilder<List<Map<String, dynamic>>>(
//                               future: _fetchTestResults(),
//                               builder: (context, testSnapshot) {
//                                 if (testSnapshot.connectionState == ConnectionState.waiting) {
//                                   return const Center(child: CircularProgressIndicator(color: Colors.white));
//                                 }
//                                 if (testSnapshot.hasError) {
//                                   return const Center(child: Text('Error loading data', style: TextStyle(color: Colors.white)));
//                                 }
//                                 final testResults = testSnapshot.data ?? [];
//                                 return ResultsTabContent(studentId: widget.studentId);
//                               },
//                             ),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ResultsTabContent extends StatelessWidget {
//   final String studentId;
//   const ResultsTabContent({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.leaderboard, size: 80, color: Colors.white70),
//           const SizedBox(height: 16),
//           const Text('Your Test Results will appear here.', style: TextStyle(color: Colors.white70, fontSize: 18), textAlign: TextAlign.center),
//           const SizedBox(height: 20),
//           ElevatedButton.icon(
//             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTestPage(studentId: studentId))),
//             icon: const Icon(Icons.add, color: Colors.white),
//             label: const Text('Add New Test', style: TextStyle(color: Colors.white)),
//             style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF40A4D0), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ProgressTabContent extends StatelessWidget {
//   final Map<String, int>? attendanceStats;

//    ProgressTabContent({super.key, required this.attendanceStats});
   
//      get chart => null;

//   @override
//   Widget build(BuildContext context) {
//     final totalClasses = attendanceStats?['totalClasses'] ?? 0;
//     final present = attendanceStats?['present'] ?? 0;
//     final absent = attendanceStats?['absent'] ?? 0;
//     final onLeave = attendanceStats?['onLeave'] ?? 0;

//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Card(
//             margin: const EdgeInsets.all(8.0),
//             color: Colors.white.withOpacity(0.9),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text('Attendance:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       const Icon(Icons.calendar_today, color: Colors.blue),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Column(
//                         children: [
//                           const Text('Total Classes', style: TextStyle(color: Colors.blue)),
//                           Text('$totalClasses', style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           const Text('Present', style: TextStyle(color: Colors.green)),
//                           Text('$present', style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           const Text('Absent', style: TextStyle(color: Colors.red)),
//                           Text('$absent', style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           const Text('On Leave', style: TextStyle(color: Colors.orange)),
//                           Text('$onLeave', style: const TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Card(
//             margin: const EdgeInsets.all(8.0),
//             color: Colors.white.withOpacity(0.9),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 children: [
//                   const Text('Attendance Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   // Bar chart for attendance
//                   Container(
//                     height: 200,
//                     child: chart,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

  
// }

// extension StringExtension on String {
//   String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:learnlog/testspage.dart';

// class Classespage extends StatefulWidget {
//   final String studentId;
//   const Classespage({super.key, required this.studentId});

//   @override
//   State<Classespage> createState() => _ClassespageState();
// }

// class _ClassespageState extends State<Classespage> 
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   Map<String, dynamic>? _studentData;
//   bool _isLoading = true;
//   String? _errorMessage;
//   late TextEditingController _dateController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 14, vsync: this);
//     _fetchStudentData();
//     _dateController = TextEditingController(
//         text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _dateController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchStudentData() async {
//     setState(() => _isLoading = true);
//     try {
//       final doc = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.studentId)
//           .get();
//       if (doc.exists) {
//         setState(() => _studentData = doc.data() as Map<String, dynamic>?);
//       } else {
//         setState(() => _errorMessage = 'Student data not found.');
//       }
//     } catch (e) {
//       setState(() => _errorMessage = 'Failed to load: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
//       (await FirebaseFirestore.instance
//               .collection('test_results')
//               .where('studentId', isEqualTo: widget.studentId)
//               .get())
//           .docs
//           .map((d) => d.data() as Map<String, dynamic>)
//           .toList();

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('attendance')
//         .where('studentId', isEqualTo: widget.studentId)
//         .get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   Future<Map<String, dynamic>> _fetchTestProgress() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('test_results')
//         .where('studentId', isEqualTo: widget.studentId)
//         .get();
//     final totalTests = snapshot.docs.length;
//     final failed = snapshot.docs
//         .where((d) => (d['obtained'] / d['total']) < 0.5)
//         .length;
//     final avg = snapshot.docs.isNotEmpty
//         ? snapshot.docs
//                 .map((d) => (d['obtained'] / d['total']) * 100)
//                 .reduce((a, b) => a + b) /
//             totalTests
//         : 0.0;
//     return {
//       'totalTests': totalTests,
//       'attended': totalTests,
//       'failed': failed,
//       'absent': 0,
//       'averagePercentage': avg
//     };
//   }

//   Widget _buildModernStudentList(String classNumber) {
//     return DefaultTabController(
//       length: 3,
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(25),
//               border: Border.all(color: Colors.white.withOpacity(0.2)),
//             ),
//             child: TabBar(
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(25),
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                 ),
//               ),
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.white70,
//               labelStyle: const TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.w600,
//               ),
//               tabs: const [
//                 Tab(text: 'Division A'),
//                 Tab(text: 'Division B'),
//                 Tab(text: 'Division C'),
//               ],
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               children: [
//                 _buildModernDivisionList(classNumber, 'A'),
//                 _buildModernDivisionList(classNumber, 'B'),
//                 _buildModernDivisionList(classNumber, 'C'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildModernDivisionList(String classNumber, String division) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('users')
//           .where('class', isEqualTo: classNumber)
//           .where('division', isEqualTo: division)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return _buildErrorWidget('Error: ${snapshot.error}');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return _buildLoadingWidget();
//         }
//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return _buildEmptyWidget('No students found for this division.');
//         }

//         final docs = snapshot.data!.docs;
//         return ListView.builder(
//           padding: const EdgeInsets.all(16.0),
//           itemCount: docs.length,
//           itemBuilder: (context, index) {
//             final data = docs[index].data() as Map<String, dynamic>;
//             final docId = docs[index].id;
//             return _buildModernStudentCard(data, docId, index);
//           },
//         );
//       },
//     );
//   }

//   Widget _buildModernStudentCard(Map<String, dynamic> data, String docId, int index) {
//     final colors = [
//       [const Color(0xFF667eea), const Color(0xFF764ba2)],
//       [const Color(0xFFf093fb), const Color(0xFFf5576c)],
//       [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
//       [const Color(0xFF43e97b), const Color(0xFF38f9d7)],
//       [const Color(0xFFfa709a), const Color(0xFFfee140)],
//     ];
//     final colorIndex = index % colors.length;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Material(
//         elevation: 8,
//         borderRadius: BorderRadius.circular(20),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: colors[colorIndex],
//             ),
//           ),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(20),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ModernStudentDetailPage(studentId: docId),
//                 ),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 60,
//                     height: 60,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: const Icon(
//                       Icons.person,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           data['student_name'] ?? 'Unknown',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Class ${data['class'] ?? 'N/A'} - Division ${data['division'] ?? 'N/A'}',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.9),
//                             fontSize: 14,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           'Roll No: ${data['roll_number'] ?? 'N/A'}',
//                           style: TextStyle(
//                             color: Colors.white.withOpacity(0.8),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward_ios,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadingWidget() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircularProgressIndicator(
//             color: Colors.white,
//             strokeWidth: 3,
//           ),
//           SizedBox(height: 16),
//           Text(
//             'Loading...',
//             style: TextStyle(color: Colors.white70, fontSize: 16),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorWidget(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.error_outline,
//             color: Colors.redAccent,
//             size: 60,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: const TextStyle(color: Colors.redAccent, fontSize: 16),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyWidget(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(
//             Icons.people_outline,
//             color: Colors.white54,
//             size: 80,
//           ),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: const TextStyle(color: Colors.white70, fontSize: 18),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildModernStatsCard({
//     required String title,
//     required IconData icon,
//     required List<Map<String, dynamic>> stats,
//     required List<Color> gradientColors,
//   }) {
//     return Container(
//       margin: const EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: gradientColors,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: gradientColors.first.withOpacity(0.3),
//             spreadRadius: 0,
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(icon, color: Colors.white, size: 24),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: stats.map((stat) {
//                 return Column(
//                   children: [
//                     Text(
//                       stat['label'],
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.9),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       stat['value'].toString(),
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF2C3E50),
//               Color(0xFF3498DB),
//               Color(0xFF9B59B6),
//               Color(0xFF1ABC9C),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.fromLTRB(16, 50, 16, 16),
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(30),
//                 border: Border.all(color: Colors.white.withOpacity(0.2)),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 isScrollable: true,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.white.withOpacity(0.2),
//                 ),
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white60,
//                 labelStyle: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 tabs: [
//                   for (int i = 1; i <= 12; i++) Tab(text: 'Class $i'),
//                   const Tab(text: 'Results'),
//                   const Tab(text: 'Progress'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? _buildLoadingWidget()
//                   : _errorMessage != null
//                       ? _buildErrorWidget(_errorMessage!)
//                       : TabBarView(
//                           controller: _tabController,
//                           children: [
//                             for (int i = 1; i <= 12; i++)
//                               _buildModernStudentList(i.toString()),
//                             _buildResultsTab(),
//                             _buildProgressTab(),
//                           ],
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildResultsTab() {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _fetchTestResults(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return _buildLoadingWidget();
//         }
//         if (snapshot.hasError) {
//           return _buildErrorWidget('Error loading test results');
//         }

//         final testResults = snapshot.data ?? [];
//         if (testResults.isEmpty) {
//           return _buildEmptyWidget('No test results found');
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: testResults.length,
//           itemBuilder: (context, index) {
//             final result = testResults[index];
//             final percentage = (result['obtained'] / result['total']) * 100;
//             final isPassed = percentage >= 50;

//             return Container(
//               margin: const EdgeInsets.only(bottom: 16),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: LinearGradient(
//                   colors: isPassed
//                       ? [const Color(0xFF56ab2f), const Color(0xFFa8e6cf)]
//                       : [const Color(0xFFff512f), const Color(0xFFf09819)],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (isPassed ? Colors.green : Colors.red).withOpacity(0.3),
//                     spreadRadius: 0,
//                     blurRadius: 15,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           DateFormat('dd MMM yyyy').format(
//                               (result['date'] as Timestamp).toDate()),
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Text(
//                             isPassed ? 'PASS' : 'FAIL',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       result['test_name'] ?? 'Unnamed Test',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildScoreColumn('Obtained', '${result['obtained']}'),
//                         _buildScoreColumn('Total', '${result['total']}'),
//                         _buildScoreColumn('Percentage', '${percentage.toStringAsFixed(1)}%'),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   Widget _buildScoreColumn(String label, String value) {
//     return Column(
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.9),
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildProgressTab() {
//     return FutureBuilder<Map<String, int>>(
//       future: _fetchAttendanceStats(),
//       builder: (context, attendanceSnapshot) {
//         return FutureBuilder<Map<String, dynamic>>(
//           future: _fetchTestProgress(),
//           builder: (context, testSnapshot) {
//             if (attendanceSnapshot.connectionState == ConnectionState.waiting ||
//                 testSnapshot.connectionState == ConnectionState.waiting) {
//               return _buildLoadingWidget();
//             }

//             final attendanceStats = attendanceSnapshot.data ?? {};
//             final testProgress = testSnapshot.data ?? {};

//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   _buildModernStatsCard(
//                     title: 'Attendance',
//                     icon: Icons.calendar_today,
//                     gradientColors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
//                     stats: [
//                       {'label': 'Total', 'value': attendanceStats['totalClasses'] ?? 0},
//                       {'label': 'Present', 'value': attendanceStats['present'] ?? 0},
//                       {'label': 'Absent', 'value': attendanceStats['absent'] ?? 0},
//                       {'label': 'Leave', 'value': attendanceStats['onLeave'] ?? 0},
//                     ],
//                   ),
//                   _buildModernStatsCard(
//                     title: 'Test Progress',
//                     icon: Icons.bar_chart,
//                     gradientColors: [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
//                     stats: [
//                       {'label': 'Total', 'value': testProgress['totalTests'] ?? 0},
//                       {'label': 'Attended', 'value': testProgress['attended'] ?? 0},
//                       {'label': 'Failed', 'value': testProgress['failed'] ?? 0},
//                       {'label': 'Avg %', 'value': '${(testProgress['averagePercentage'] ?? 0.0).toStringAsFixed(1)}%'},
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class ModernStudentDetailPage extends StatefulWidget {
//   final String studentId;
//   const ModernStudentDetailPage({super.key, required this.studentId});

//   @override
//   State<ModernStudentDetailPage> createState() => _ModernStudentDetailPageState();
// }

// class _ModernStudentDetailPageState extends State<ModernStudentDetailPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Details'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF2C3E50),
//               Color(0xFF3498DB),
//               Color(0xFF9B59B6),
//               Color(0xFF1ABC9C),
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: Colors.white.withOpacity(0.2)),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(25),
//                   color: Colors.white.withOpacity(0.2),
//                 ),
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.white70,
//                 labelStyle: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//                 tabs: const [
//                   Tab(text: 'Progress'),
//                   Tab(text: 'Results'),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   ModernProgressTab(studentId: widget.studentId),
//                   ModernResultsTab(studentId: widget.studentId),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ModernResultsTab extends StatelessWidget {
//   final String studentId;
//   const ModernResultsTab({super.key, required this.studentId});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             width: 120,
//             height: 120,
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//               ),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: const Icon(
//               Icons.leaderboard,
//               size: 60,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 24),
//           const Text(
//             'Your Test Results',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Test results will appear here once you take some tests.',
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.8),
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 32),
//           Container(
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
//               ),
//               borderRadius: BorderRadius.circular(25),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF4facfe).withOpacity(0.3),
//                   spreadRadius: 0,
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: ElevatedButton.icon(
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => AddTestPage(studentId: studentId),
//                 ),
//               ),
//               icon: const Icon(Icons.add, color: Colors.white),
//               label: const Text(
//                 'Add New Test',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.transparent,
//                 shadowColor: Colors.transparent,
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ModernProgressTab extends StatelessWidget {
//   final String studentId;
//   const ModernProgressTab({super.key, required this.studentId});

//   Future<Map<String, int>> _fetchAttendanceStats() async {
//     final snapshot = await FirebaseFirestore.instance
//         .collection('attendance')
//         .where('studentId', isEqualTo: studentId)
//         .get();
//     return {
//       'totalClasses': snapshot.docs.length,
//       'present': snapshot.docs.where((d) => d['status'] == 'present').length,
//       'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
//       'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<Map<String, int>>(
//       future: _fetchAttendanceStats(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(color: Colors.white),
//           );
//         }

//         final stats = snapshot.data ?? {};
//         final totalClasses = stats['totalClasses'] ?? 0;
//         final present = stats['present'] ?? 0;
//         final attendancePercentage = totalClasses > 0 ? (present / totalClasses) * 100 : 0.0;

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF56ab2f), Color(0xFFa8e6cf)],
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF56ab2f).withOpacity(0.3),
//                       spreadRadius: 0,
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Attendance Overview',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.calendar_today,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                       // Circular Progress Indicator for Attendance
//                       Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           SizedBox(
//                             width: 120,
//                             height: 120,
//                             child: CircularProgressIndicator(
//                               value: attendancePercentage / 100,
//                               strokeWidth: 8,
//                               backgroundColor: Colors.white.withOpacity(0.3),
//                               valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 '${attendancePercentage.toStringAsFixed(1)}%',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 'Attendance',
//                                 style: TextStyle(
//                                   color: Colors.white.withOpacity(0.9),
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 24),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildAttendanceColumn('Total', '${stats['totalClasses'] ?? 0}', Icons.school),
//                           _buildAttendanceColumn('Present', '${stats['present'] ?? 0}', Icons.check_circle),
//                           _buildAttendanceColumn('Absent', '${stats['absent'] ?? 0}', Icons.cancel),
//                           _buildAttendanceColumn('Leave', '${stats['onLeave'] ?? 0}', Icons.event_busy),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF667eea), Color(0xFF764ba2)],
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF667eea).withOpacity(0.3),
//                       spreadRadius: 0,
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             'Quick Stats',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: const Icon(
//                               Icons.bar_chart,
//                               color: Colors.white,
//                               size: 24,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 20),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildStatCard(
//                               'Days Present',
//                               '${stats['present'] ?? 0}',
//                               Icons.today,
//                               const Color(0xFF4CAF50),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: _buildStatCard(
//                               'Days Missed',
//                               '${stats['absent'] ?? 0}',
//                               Icons.event_busy,
//                               const Color(0xFFFF5722),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildStatCard(
//                               'Leave Days',
//                               '${stats['onLeave'] ?? 0}',
//                               Icons.beach_access,
//                               const Color(0xFFFF9800),
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           Expanded(
//                             child: _buildStatCard(
//                               'Total Classes',
//                               '${stats['totalClasses'] ?? 0}',
//                               Icons.class_,
//                               const Color(0xFF2196F3),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAttendanceColumn(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: Colors.white, size: 20),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.9),
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildStatCard(String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(color: Colors.white.withOpacity(0.2)),
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Icon(icon, color: color, size: 24),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.8),
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
// }



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learnlog/testspage.dart';

class Classespage extends StatefulWidget {
  final String studentId;
  const Classespage({super.key, required this.studentId});

  @override
  State<Classespage> createState() => _ClassespageState();
}

class _ClassespageState extends State<Classespage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, dynamic>? _studentData;
  bool _isLoading = true;
  String? _errorMessage;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 14, vsync: this);
    _fetchStudentData();
    _dateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _fetchStudentData() async {
    setState(() => _isLoading = true);
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.studentId)
          .get();
      if (doc.exists) {
        setState(() => _studentData = doc.data() as Map<String, dynamic>?);
      } else {
        setState(() => _errorMessage = 'Student data not found.');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Failed to load: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<List<Map<String, dynamic>>> _fetchTestResults() async =>
      (await FirebaseFirestore.instance
              .collection('test_results')
              .where('studentId', isEqualTo: widget.studentId)
              .get())
          .docs
          .map((d) => d.data() as Map<String, dynamic>)
          .toList();

  Future<Map<String, int>> _fetchAttendanceStats() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('studentId', isEqualTo: widget.studentId)
        .get();
    return {
      'totalClasses': snapshot.docs.length,
      'present': snapshot.docs.where((d) => d['status'] == 'present').length,
      'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
      'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
    };
  }

  Future<Map<String, dynamic>> _fetchTestProgress() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('test_results')
        .where('studentId', isEqualTo: widget.studentId)
        .get();
    final totalTests = snapshot.docs.length;
    final failed = snapshot.docs
        .where((d) => (d['obtained'] / d['total']) < 0.5)
        .length;
    final avg = snapshot.docs.isNotEmpty
        ? snapshot.docs
                .map((d) => (d['obtained'] / d['total']) * 100)
                .reduce((a, b) => a + b) /
            totalTests
        : 0.0;
    return {
      'totalTests': totalTests,
      'attended': totalTests,
      'failed': failed,
      'absent': 0,
      'averagePercentage': avg
    };
  }

  Widget _buildModernStudentList(String classNumber) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [ Color.fromARGB(255, 4, 45, 50), 
              Color.fromARGB(255, 13, 74, 83), 
              Color.fromARGB(255, 13, 65, 71), ],
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Division A'),
                Tab(text: 'Division B'),
                Tab(text: 'Division C'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildModernDivisionList(classNumber, 'A'),
                _buildModernDivisionList(classNumber, 'B'),
                _buildModernDivisionList(classNumber, 'C'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernDivisionList(String classNumber, String division) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('class', isEqualTo: classNumber)
          .where('division', isEqualTo: division)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget();
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyWidget('No students found for this division.');
        }

        final docs = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data() as Map<String, dynamic>;
            final docId = docs[index].id;
            return _buildModernStudentCard(data, docId, index);
          },
        );
      },
    );
  }

  Widget _buildModernStudentCard(Map<String, dynamic> data, String docId, int index) {
    final colors = [
      [ Color.fromARGB(255, 4, 45, 50), Color.fromARGB(255, 13, 74, 83), ],
       [ Color.fromARGB(255, 4, 45, 50), Color.fromARGB(255, 13, 74, 83), ],
        [ Color.fromARGB(255, 4, 45, 50), Color.fromARGB(255, 13, 74, 83), ],
         [ Color.fromARGB(255, 4, 45, 50), Color.fromARGB(255, 13, 74, 83), ],
      ];
    final colorIndex = index % colors.length;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors[colorIndex],
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ModernStudentDetailPage(studentId: docId),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['student_name'] ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Class ${data['class'] ?? 'N/A'} - Division ${data['division'] ?? 'N/A'}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Roll No: ${data['roll_number'] ?? 'N/A'}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
          SizedBox(height: 16),
          Text(
            'Loading...',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.redAccent, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.people_outline,
            color: Colors.white54,
            size: 80,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(color: Colors.white70, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildModernStatsCard({
    required String title,
    required IconData icon,
    required List<Map<String, dynamic>> stats,
    required List<Color> gradientColors,
  }) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: stats.map((stat) {
                return Column(
                  children: [
                    Text(
                      stat['label'],
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stat['value'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(16, 50, 16, 16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withOpacity(0.2),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                tabs: [
                  for (int i = 1; i <= 12; i++) Tab(text: 'Class $i'),
                  const Tab(text: 'Results'),
                  const Tab(text: 'Progress'),
                ],
              ),
            ),
            Expanded(
              child: _isLoading
                  ? _buildLoadingWidget()
                  : _errorMessage != null
                      ? _buildErrorWidget(_errorMessage!)
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            for (int i = 1; i <= 12; i++)
                              _buildModernStudentList(i.toString()),
                            _buildResultsTab(),
                            _buildProgressTab(),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsTab() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _fetchTestResults(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingWidget();
        }
        if (snapshot.hasError) {
          return _buildErrorWidget('Error loading test results');
        }

        final testResults = snapshot.data ?? [];
        if (testResults.isEmpty) {
          return _buildEmptyWidget('No test results found');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: testResults.length,
          itemBuilder: (context, index) {
            final result = testResults[index];
            final percentage = (result['obtained'] / result['total']) * 100;
            final isPassed = percentage >= 50;

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: isPassed
                      ? [const Color(0xFF56ab2f), const Color(0xFFa8e6cf)]
                      : [const Color(0xFFff512f), const Color(0xFFf09819)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isPassed ? Colors.green : Colors.red).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateFormat('dd MMM yyyy').format(
                              (result['date'] as Timestamp).toDate()),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            isPassed ? 'PASS' : 'FAIL',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      result['test_name'] ?? 'Unnamed Test',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildScoreColumn('Obtained', '${result['obtained']}'),
                        _buildScoreColumn('Total', '${result['total']}'),
                        _buildScoreColumn('Percentage', '${percentage.toStringAsFixed(1)}%'),
                      ],
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

  Widget _buildScoreColumn(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressTab() {
    return FutureBuilder<Map<String, int>>(
      future: _fetchAttendanceStats(),
      builder: (context, attendanceSnapshot) {
        return FutureBuilder<Map<String, dynamic>>(
          future: _fetchTestProgress(),
          builder: (context, testSnapshot) {
            if (attendanceSnapshot.connectionState == ConnectionState.waiting ||
                testSnapshot.connectionState == ConnectionState.waiting) {
              return _buildLoadingWidget();
            }

            final attendanceStats = attendanceSnapshot.data ?? {};
            final testProgress = testSnapshot.data ?? {};

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildModernStatsCard(
                    title: 'Attendance',
                    icon: Icons.calendar_today,
                    gradientColors: [const Color(0xFF667eea), const Color(0xFF764ba2)],
                    stats: [
                      {'label': 'Total', 'value': attendanceStats['totalClasses'] ?? 0},
                      {'label': 'Present', 'value': attendanceStats['present'] ?? 0},
                      {'label': 'Absent', 'value': attendanceStats['absent'] ?? 0},
                      {'label': 'Leave', 'value': attendanceStats['onLeave'] ?? 0},
                    ],
                  ),
                  _buildModernStatsCard(
                    title: 'Test Progress',
                    icon: Icons.bar_chart,
                    gradientColors: [ Color.fromARGB(255, 4, 45, 50), 
              Color.fromARGB(255, 13, 74, 83), 
              Color.fromARGB(255, 13, 65, 71), ],
                    stats: [
                      {'label': 'Total', 'value': testProgress['totalTests'] ?? 0},
                      {'label': 'Attended', 'value': testProgress['attended'] ?? 0},
                      {'label': 'Failed', 'value': testProgress['failed'] ?? 0},
                      {'label': 'Avg %', 'value': '${(testProgress['averagePercentage'] ?? 0.0).toStringAsFixed(1)}%'},
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ModernStudentDetailPage extends StatefulWidget {
  final String studentId;
  const ModernStudentDetailPage({super.key, required this.studentId});

  @override
  State<ModernStudentDetailPage> createState() => _ModernStudentDetailPageState();
}

class _ModernStudentDetailPageState extends State<ModernStudentDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(0, 211, 195, 195),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:  [ Color.fromARGB(255, 4, 45, 50), Color.fromARGB(255, 13, 74, 83), ],
            ),
          ),
        ),
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
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white.withOpacity(0.2),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white70,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Progress'),
                  Tab(text: 'Results'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ModernProgressTab(studentId: widget.studentId),
                  ModernResultsTab(studentId: widget.studentId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModernResultsTab extends StatelessWidget {
  final String studentId;
  const ModernResultsTab({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [ Color.fromARGB(255, 4, 45, 50), 
              Color.fromARGB(255, 13, 74, 83), 
              Color.fromARGB(255, 13, 65, 71), ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(
              Icons.leaderboard,
              size: 60,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Test Results',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Test results will appear here once you take some tests.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors:  [ Color.fromARGB(255, 4, 45, 50), Color.fromARGB(255, 13, 74, 83), ],
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4facfe).withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTestPage(studentId: studentId),
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Add New Test',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                shadowColor:Color.fromARGB(255, 33, 120, 133), 
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModernProgressTab extends StatelessWidget {
  final String studentId;
  const ModernProgressTab({super.key, required this.studentId});

  Future<Map<String, int>> _fetchAttendanceStats() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('attendance')
        .where('studentId', isEqualTo: studentId)
        .get();
    return {
      'totalClasses': snapshot.docs.length,
      'present': snapshot.docs.where((d) => d['status'] == 'present').length,
      'absent': snapshot.docs.where((d) => d['status'] == 'absent').length,
      'onLeave': snapshot.docs.where((d) => d['status'] == 'on_leave').length,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: _fetchAttendanceStats(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        final stats = snapshot.data ?? {};
        final totalClasses = stats['totalClasses'] ?? 0;
        final present = stats['present'] ?? 0;
        final attendancePercentage = totalClasses > 0 ? (present / totalClasses) * 100 : 0.0;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [ Color.fromARGB(255, 4, 45, 50), 
              Color.fromARGB(255, 13, 74, 83), 
              Color.fromARGB(255, 13, 65, 71), ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 33, 120, 133), 
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Attendance Overview',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Circular Progress Indicator for Attendance
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: attendancePercentage / 100,
                              strokeWidth: 8,
                              backgroundColor: Colors.white.withOpacity(0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${attendancePercentage.toStringAsFixed(1)}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Attendance',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildAttendanceColumn('Total', '${stats['totalClasses'] ?? 0}', Icons.school),
                          _buildAttendanceColumn('Present', '${stats['present'] ?? 0}', Icons.check_circle),
                          _buildAttendanceColumn('Absent', '${stats['absent'] ?? 0}', Icons.cancel),
                          _buildAttendanceColumn('Leave', '${stats['onLeave'] ?? 0}', Icons.event_busy),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors:  [ Color.fromARGB(255, 4, 45, 50), Color.fromARGB(255, 13, 74, 83), ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 33, 120, 133), 
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Quick Stats',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.bar_chart,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Days Present',
                              '${stats['present'] ?? 0}',
                              Icons.today,
                              const Color(0xFF4CAF50),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Days Missed',
                              '${stats['absent'] ?? 0}',
                              Icons.event_busy,
                              const Color(0xFFFF5722),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              'Leave Days',
                              '${stats['onLeave'] ?? 0}',
                              Icons.beach_access,
                              const Color(0xFFFF9800),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              'Total Classes',
                              '${stats['totalClasses'] ?? 0}',
                              Icons.class_,
                              const Color(0xFF2196F3),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttendanceColumn(String label, String value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${substring(1)}";
}


