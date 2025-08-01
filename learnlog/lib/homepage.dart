// import 'package:flutter/material.dart';

// class StudentPortalPage extends StatelessWidget {
//   const StudentPortalPage({super.key});

//   // A custom widget for each action item (like Attendance, Students, etc.)
//   Widget _buildActionItem(
//       String imagePath, String label, VoidCallback onTap) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 100, // Adjust size as needed
//           height: 100, // Adjust size as needed
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white, // White background for the circular image area
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3), // changes position of shadow
//               ),
//             ],
//           ),
//           child: Material( // Use Material to enable InkWell splash effect
//             color: Colors.transparent, // Make Material transparent
//             shape: const CircleBorder(),
//             clipBehavior: Clip.antiAlias, // Clip children to the circle
//             child: InkWell(
//               onTap: onTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0), // Padding for the image/icon inside the circle
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.contain, // Adjust fit as necessary for your images
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
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
//               Color(0xFF008080), // Teal (top-left)
//               Color(0xFF20B2AA), // LightSeaGreen (middle)
//               Color(0xFF40E0D0), // Turquoise (bottom-right)
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             // --- Top Section: Student Portal Title ---
//             Padding(
//               padding: const EdgeInsets.only(top: 60.0, bottom: 30.0),
//               child: Text(
//                 'Student Portal',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.2,
//                 ),
//               ),
//             ),

//             // --- Middle Section: Grid of Action Buttons ---
//             Expanded(
//               flex: 3, // Takes more vertical space
//               child: GridView.count(
//                 crossAxisCount: 2, // 2 columns
//                 childAspectRatio: 0.9, // Adjust aspect ratio for item sizing
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 mainAxisSpacing: 25.0, // Vertical spacing between items
//                 crossAxisSpacing: 25.0, // Horizontal spacing between items
//                 children: [
//                   _buildActionItem(
//                     'image/OIP.jpeg', // Your attendance icon asset path
//                     'Attendance',
//                     () {
//                       // TODO: Navigate to Attendance page
//                       print('Attendance tapped');
//                     },
//                   ),
//                   _buildActionItem(
//                     'image/2995620.png', // Your students icon asset path
//                     'Students',
//                     () {
//                       // TODO: Navigate to Students page
//                       print('Students tapped');
//                     },
//                   ),
//                   _buildActionItem(
//                     'image/2997555.png', // Your classes icon asset path
//                     'Classes',
//                     () {
//                       // TODO: Navigate to Classes page
//                       print('Classes tapped');
//                     },
//                   ),
//                   _buildActionItem(
//                     'image/4838856.png', // Your tests icon asset path
//                     'Tests',
//                     () {
//                       // TODO: Navigate to Tests page
//                       print('Tests tapped');
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // --- Bottom Section: Decorative Image ---
//             Expanded(
//               flex: 2, // Takes less vertical space but fills remaining
//               child: Align( // Align the image to the bottom
//                 alignment: Alignment.bottomCenter,
//                 child: Image.asset(
//                   'image/bookshelf_PNG107094.png', // Your books image asset path
//                   fit: BoxFit.cover, // Cover the available space
//                   width: double.infinity, // Take full width
//                   // You might need to adjust height based on your image aspect ratio
//                   // or use a specific height if 'fit: BoxFit.cover' distorts it too much
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class StudentPortalPage extends StatefulWidget {
//   final String studentId; // Pass studentId from Loginpage

//   const StudentPortalPage({super.key, required this.studentId});

//   @override
//   State<StudentPortalPage> createState() => _StudentPortalPageState();
// }

// class _StudentPortalPageState extends State<StudentPortalPage> {
//   // Store counts or data fetched from Firestore
//   int _attendanceCount = 0;
//   int _studentsCount = 0;
//   int _classesCount = 0;
//   int _testsCount = 0;
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchFirestoreData();
//   }

//   // Fetch counts from Firestore for action items
//   Future<void> _fetchFirestoreData() async {
//     try {
//       // Get Firestore instance
//       final firestore = FirebaseFirestore.instance;

//       // Fetch attendance count for the student
//       final attendanceQuery = await firestore
//           .collection('attendance')
//           .where('studentId', isEqualTo: widget.studentId)
//           .get();
//       final studentsQuery = await firestore.collection('students').get();
//       final classesQuery = await firestore
//           .collection('classes')
//           .where('students', arrayContains: widget.studentId)
//           .get();
//       final testsQuery = await firestore
//           .collection('tests')
//           .where('studentId', isEqualTo: widget.studentId)
//           .get();

//       setState(() {
//         _attendanceCount = attendanceQuery.docs.length;
//         _studentsCount = studentsQuery.docs.length;
//         _classesCount = classesQuery.docs.length;
//         _testsCount = testsQuery.docs.length;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print('Error fetching Firestore data: $e');
//       setState(() {
//         _isLoading = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading data: $e')),
//       );
//     }
//   }

//   // A custom widget for each action item
//   Widget _buildActionItem(
//     String imagePath,
//     String label,
//     int count,
//     VoidCallback onTap,
//   ) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 100,
//           height: 100,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 7,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//           ),
//           child: Material(
//             color: Colors.transparent,
//             shape: const CircleBorder(),
//             clipBehavior: Clip.antiAlias,
//             child: InkWell(
//               onTap: onTap,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     Image.asset(
//                       imagePath,
//                       fit: BoxFit.contain,
//                     ),
//                     if (count > 0)
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.redAccent,
//                           ),
//                           child: Text(
//                             '$count',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           label,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
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
//               Color(0xFF008080), // Teal
//               Color(0xFF20B2AA), // LightSeaGreen
//               Color(0xFF40E0D0), // Turquoise
//             ],
//           ),
//         ),
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator(color: Colors.white))
//             : Column(
//                 children: [
//                   // Top Section: Student Portal Title
//                   const Padding(
//                     padding: EdgeInsets.only(top: 60.0, bottom: 30.0),
//                     child: Text(
//                       'Student Portal',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),

//                   // Middle Section: Grid of Action Buttons
//                   Expanded(
//                     flex: 3,
//                     child: GridView.count(
//                       crossAxisCount: 2,
//                       childAspectRatio: 0.9,
//                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                       mainAxisSpacing: 25.0,
//                       crossAxisSpacing: 25.0,
//                       children: [
//                         _buildActionItem(
//                           'image/OIP.jpeg',
//                           'Attendance',
//                           _attendanceCount,
//                           () {
//                             // TODO: Navigate to Attendance page with Firestore data
//                             print('Attendance tapped');
//                           },
//                         ),
//                         _buildActionItem(
//                           'image/2995620.png',
//                           'Students',
//                           _studentsCount,
//                           () {
//                             // TODO: Navigate to Students page with Firestore data
//                             print('Students tapped');
//                           },
//                         ),
//                         _buildActionItem(
//                           'image/2997555.png',
//                           'Classes',
//                           _classesCount,
//                           () {
//                             // TODO: Navigate to Classes page with Firestore data
//                             print('Classes tapped');
//                           },
//                         ),
//                         _buildActionItem(
//                           'image/4838856.png',
//                           'Tests',
//                           _testsCount,
//                           () {
//                             // TODO: Navigate to Tests page with Firestore data
//                             print('Tests tapped');
//                           },
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Bottom Section: Decorative Image
//                   Expanded(
//                     flex: 2,
//                     child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Image.asset(
//                         'image/bookshelf_PNG107094.png',
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnlog/attendance.dart';
import 'package:learnlog/classespage.dart';
import 'package:learnlog/studentspage.dart';
import 'package:learnlog/testspage.dart';

// --- StudentPortalPage (Updated with Navigation) ---
class StudentPortalPage extends StatefulWidget {
  final String studentId;

  const StudentPortalPage({super.key, required this.studentId});

  @override
  State<StudentPortalPage> createState() => _StudentPortalPageState();
}

class _StudentPortalPageState extends State<StudentPortalPage> {
  int _attendanceCount = 0;
  int _studentsCount = 0;
  int _classesCount = 0;
  int _testsCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFirestoreData();
  }

  Future<void> _fetchFirestoreData() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final attendanceQuery = await firestore
          .collection('attendance')
          .where('studentId', isEqualTo: widget.studentId)
          .get();
      final studentsQuery = await firestore.collection('students').get();
      final classesQuery = await firestore
          .collection('classes')
          .where('students', arrayContains: widget.studentId)
          .get();
      final testsQuery = await firestore
          .collection('tests')
          .where('studentId', isEqualTo: widget.studentId)
          .get();

      setState(() {
        _attendanceCount = attendanceQuery.docs.length;
        _studentsCount = studentsQuery.docs.length;
        _classesCount = classesQuery.docs.length;
        _testsCount = testsQuery.docs.length;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching Firestore data: $e');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  Widget _buildActionItem(
    String imagePath,
    String label,
    int count,
    VoidCallback onTap,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                    if (count > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 60.0, bottom: 30.0),
                    child: Text(
                      'Student Portal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      mainAxisSpacing: 25.0,
                      crossAxisSpacing: 25.0,
                      children: [
                        _buildActionItem(
                          'image/OIP.jpeg',
                          'Attendance',
                          _attendanceCount,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AttendancePage(studentId: widget.studentId),
                              ),
                            );
                          },
                        ),
                        _buildActionItem(
                          'image/2995620.png',
                          'Students',
                          _studentsCount,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentsPage(studentId: widget.studentId),
                              ),
                            );
                          },
                        ),
                        _buildActionItem(
                          'image/2997555.png',
                          'Classes',
                          _classesCount,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Classespage(studentId: widget.studentId),
                              ),
                            );
                          },
                        ),
                        _buildActionItem(
                          'image/4838856.png',
                          'Tests',
                          _testsCount,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTestPage(studentId: widget.studentId),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'image/bookshelf_PNG107094.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

