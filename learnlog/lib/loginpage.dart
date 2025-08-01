// import 'package:flutter/material.dart';
// import 'package:learnlog/homepage.dart';
// import 'package:learnlog/registerscreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// enum UserType { student } // Define an enum for user types, removed teacher

// class Loginpage extends StatefulWidget {
//   const Loginpage({super.key});

//   @override
//   State<Loginpage> createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? _usernameError;
//   String? _passwordError;

//   UserType _selectedUserType = UserType.student; // Default to student

//   String? _validateUsername(String username) {
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
//     }
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%)]').hasMatch(username)) {
//       return 'Username must not contain special characters';
//     }
//     return null;
//   }

//   String? _validatePassword(String password) {
//     if (password.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     if (!RegExp(r'[A-Z]').hasMatch(password)) {
//       return 'Password must contain at least one uppercase letter';
//     }
//     if (!RegExp(r'[0-9]').hasMatch(password)) {
//       return 'Password must contain at least one number';
//     }
//     if (password.isEmpty) {
//       return 'Password cannot be empty';
//     }
//     return null;
//   }

//   bool _obscureText = true;

//   Future<void> _loginUser() async {
//     setState(() {
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//     });

//     // Debugging print statements
//     print('Attempting login...');
//     print('User Type: ${_selectedUserType.name}');
//     print('Username: ${_usernameController.text}');
//     print('Password: ${_passwordController.text}');
//     print('Username Error: $_usernameError');
//     print('Password Error: $_passwordError');

//     if (_usernameError == null && _passwordError == null) {
//       try {
//         // Query the 'users' collection for student login
//         final QuerySnapshot result = await FirebaseFirestore.instance
//             .collection('users')
//             .where('username', isEqualTo: _usernameController.text)
//             .where('password', isEqualTo: _passwordController.text) // !!! Highly INSECURE !!!
//             .get();

//         if (result.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Login successful!')),
//           );
//           // Navigate to StudentPortalPage
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => const StudentPortalPage(studentId: '',)),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Invalid username or password.')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred during login: $e')),
//         );
//         print('Firestore query error: $e'); // Print detailed error to console
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix validation errors.')),
//       );
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
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.lock_open_rounded,
//                   size: 100,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Welcome Back!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 const Text(
//                   'Sign in to continue',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _usernameController,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                         labelText: 'Username',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _usernameError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _usernameError = _validateUsername(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _passwordController,
//                       obscureText: _obscureText,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                         labelText: 'Password',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _passwordError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureText
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureText = !_obscureText;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _passwordError = _validatePassword(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E88E5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       elevation: 5,
//                     ),
//                     onPressed: _loginUser,
//                     child: const Text(
//                       'LOGIN',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Don\'t have an account?',
//                       style: TextStyle(color: Colors.white70, fontSize: 15),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => const Register()),
//                         );
//                       },
//                       child: const Text(
//                         'Create Account',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:learnlog/homepage.dart'; // Assuming StudentPortalPage is in homepage.dart
// import 'package:learnlog/registerscreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// enum UserType { student } // Define an enum for user types

// class Loginpage extends StatefulWidget {
//   const Loginpage({super.key});

//   @override
//   State<Loginpage> createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? _usernameError;
//   String? _passwordError;

//   // UserType _selectedUserType = UserType.student; // No longer needed if only student login

//   String? _validateUsername(String username) {
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
//     }
//     // Updated regex for more common username characters, still disallowing many specials
//     if (RegExp(r'[!@#%^&*()_+=<>?/|,;:{}\[\]`~]').hasMatch(username)) {
//       return 'Username must not contain special characters';
//     }
//     return null;
//   }

//   String? _validatePassword(String password) {
//     if (password.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     if (!RegExp(r'[A-Z]').hasMatch(password)) {
//       return 'Password must contain at least one uppercase letter';
//     }
//     if (!RegExp(r'[0-9]').hasMatch(password)) {
//       return 'Password must contain at least one number';
//     }
//     if (password.isEmpty) {
//       return 'Password cannot be empty';
//     }
//     return null;
//   }

//   bool _obscureText = true;

//   Future<void> _loginUser() async {
//     setState(() {
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//     });

//     if (_usernameError == null && _passwordError == null) {
//       try {
//         final QuerySnapshot result = await FirebaseFirestore.instance
//             .collection('users')
//             .where('username', isEqualTo: _usernameController.text)
//             .where('password', isEqualTo: _passwordController.text) // !!! Still Highly INSECURE for production !!!
//             .get();

//         if (result.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Login successful!')),
//           );
//           // Pass the studentId from the logged-in user's document
//           final String studentId = result.docs.first.id; // Assuming the document ID is the student ID
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => StudentPortalPage(studentId: studentId)),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Invalid username or password.')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred during login: $e')),
//         );
//         print('Firestore query error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix validation errors.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false, // Prevent resize when keyboard appears
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter, // Changed to topCenter for a vertical flow
//             end: Alignment.bottomCenter, // Changed to bottomCenter
//             colors: [
//               Color.fromARGB(255, 4, 45, 50), // Darker Teal
//               Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//               Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
//               Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0), // Increased padding
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.school, // Changed icon to something more related to learning
//                   size: 120, // Slightly larger icon
//                   color: Colors.white,
//                 ),
//                 const SizedBox(height: 30), // Increased spacing
//                 const Text(
//                   'Welcome Back!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 38, // Larger font size
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const Text(
//                   'Sign in to your Lernlog account', // More specific text
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 50), // Increased spacing

//                 // Username TextField
//                 TextField(
//                   controller: _usernameController,
//                   style: const TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF6B8BCF)), // Icon color from gradient
//                     labelText: 'Username',
//                     labelStyle: TextStyle(color: Colors.grey[600]), // Darker grey for label
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.9), // Slightly transparent white
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none, // No border by default
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.transparent), // Subtle border
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF6B8BCF), width: 2), // Highlighted border
//                     ),
//                     errorText: _usernameError,
//                     errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 13),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _usernameError = _validateUsername(value);
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Password TextField
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscureText,
//                   style: const TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF6B8BCF)), // Icon color
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.grey[600]), // Darker grey for label
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.9), // Slightly transparent white
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none, // No border by default
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.transparent), // Subtle border
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF6B8BCF), width: 2), // Highlighted border
//                     ),
//                     errorText: _passwordError,
//                     errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 13),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureText ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.grey[600],
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _passwordError = _validatePassword(value);
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 40),

//                 // Login Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF6B8BCF), // Button color matching gradient
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 18), // Increased padding
//                       elevation: 8, // More pronounced shadow
//                       shadowColor: Colors.black.withOpacity(0.4),
//                     ),
//                     onPressed: _loginUser,
//                     child: const Text(
//                       'LOG IN',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22, // Larger text
//                         letterSpacing: 2, // Increased letter spacing
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Register Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Don\'t have an account?',
//                       style: TextStyle(color: Colors.white70, fontSize: 16),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => const Register()),
//                         );
//                       },
//                       child: const Text(
//                         'Sign Up', // Changed text to "Sign Up" for clarity
//                         style: TextStyle(
//                           color: Colors.white, // White for prominence
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17,
//                           decoration: TextDecoration.underline, // Add underline
//                           decorationColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:learnlog/homepage.dart'; // Assuming StudentPortalPage is in homepage.dart
// import 'package:learnlog/registerscreen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lottie/lottie.dart';

// enum UserType { student } // Define an enum for user types

// class Loginpage extends StatefulWidget {
//   const Loginpage({super.key});

//   @override
//   State<Loginpage> createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   String? _usernameError;
//   String? _passwordError;

//   String? _validateUsername(String username) {
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
//     }
//     if (RegExp(r'[!@#%^&*()_+=<>?/|,;:{}\[\]`~]').hasMatch(username)) {
//       return 'Username must not contain special characters';
//     }
//     return null;
//   }

//   String? _validatePassword(String password) {
//     if (password.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     if (!RegExp(r'[A-Z]').hasMatch(password)) {
//       return 'Password must contain at least one uppercase letter';
//     }
//     if (!RegExp(r'[0-9]').hasMatch(password)) {
//       return 'Password must contain at least one number';
//     }
//     if (password.isEmpty) {
//       return 'Password cannot be empty';
//     }
//     return null;
//   }

//   bool _obscureText = true;

//   Future<void> _loginUser() async {
//     setState(() {
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//     });

//     if (_usernameError == null && _passwordError == null) {
//       try {
//         final QuerySnapshot result = await FirebaseFirestore.instance
//             .collection('users')
//             .where('username', isEqualTo: _usernameController.text)
//             .where('password', isEqualTo: _passwordController.text) // !!! Still Highly INSECURE for production !!!
//             .get();

//         if (result.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Login successful!')),
//           );
//           final String studentId = result.docs.first.id;
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (context) => StudentPortalPage(studentId: studentId)),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Invalid username or password.')),
//           );
//         }
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred during login: $e')),
//         );
//         print('Firestore query error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix validation errors.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color.fromARGB(255, 4, 45, 50), // Darker Teal
//               Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//               Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
//               Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // --- Replaced Icon with Image.asset ---
//                 Lottie.asset(
//                   'assets/Infinite.json', // <-- REPLACE with your actual image path
//                   height: 250, // Keep the height similar to the icon size
//                   width: 250, // Give it a width too
//                   fit: BoxFit.contain, // Adjust fit as needed (e.g., BoxFit.cover, BoxFit.fill)
//                   // You can also add a color filter if you want to tint it
//                   // color: Colors.white, // Example: to make a monochrome image white
//                 ),
//                 // ------------------------------------
//                 const SizedBox(height: 5),
//                 const Text(
//                   'Welcome Back!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 38,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.5,
//                   ),
//                 ),
//                 const Text(
//                   'Sign in to your Lernlog account',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 18,
//                   ),
//                 ),
//                 const SizedBox(height: 50),

//                 // Username TextField
//                 TextField(
//                   controller: _usernameController,
//                   style: const TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF6B8BCF)),
//                     labelText: 'Username',
//                     labelStyle: TextStyle(color: const Color.fromARGB(255, 5, 23, 19)),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.9),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: const BorderSide(color: Colors.transparent),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF6B8BCF), width: 2),
//                     ),
//                     errorText: _usernameError,
//                     errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 13),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _usernameError = _validateUsername(value);
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 20),

//                 // Password TextField
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: _obscureText,
//                   style: const TextStyle(color: Colors.black87),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF6B8BCF)),
//                     labelText: 'Password',
//                     labelStyle: TextStyle(color: Colors.grey[600]),
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.9),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Colors.transparent),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(color: Color(0xFF6B8BCF), width: 2),
//                     ),
//                     errorText: _passwordError,
//                     errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 13),
//                     contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscureText ? Icons.visibility_off : Icons.visibility,
//                         color: Colors.grey[600],
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                     ),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       _passwordError = _validatePassword(value);
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 40),

//                 // Login Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 18),
//                       elevation: 8,
//                       shadowColor: Colors.black.withOpacity(0.4),
//                     ),
//                     onPressed: _loginUser,
//                     child: const Text(
//                       'LOG IN',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Register Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Frst register the account',
//                       style: TextStyle(color: Colors.white70, fontSize: 16),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => const Register()),
//                         );
//                       },
//                       child: const Text(
//                         'Register',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 17,
//                           decoration: TextDecoration.underline,
//                           decorationColor: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:learnlog/homepage.dart';
import 'package:learnlog/registerscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lottie/lottie.dart';

enum UserType { student }

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  String? _usernameError;
  String? _passwordError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _slideController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  String? _validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    if (RegExp(r'[!@#%^&*()_+=<>?/|,;:{}\[\]`~]').hasMatch(username)) {
      return 'Username must not contain special characters';
    }
    return null;
  }

  String? _validatePassword(String password) {
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  bool _obscureText = true;

  Future<void> _loginUser() async {
    setState(() {
      _usernameError = _validateUsername(_usernameController.text);
      _passwordError = _validatePassword(_passwordController.text);
      _isLoading = true;
    });

    if (_usernameError == null && _passwordError == null) {
      try {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: _usernameController.text)
            .where('password', isEqualTo: _passwordController.text)
            .get();

        if (result.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Login successful!'),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
          final String studentId = result.docs.first.id;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => StudentPortalPage(studentId: studentId)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Invalid username or password.'),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred during login: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        print('Firestore query error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fix validation errors.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
    
    setState(() {
      _isLoading = false;
    });
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
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo with circular background
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 4, 45, 50), // Darker Teal
              Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
                                ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF667eea).withOpacity(0.3),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Lottie.asset(
                            'assets/Infinite.json',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Welcome text
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to continue your learning journey',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),

                        // Username field
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _usernameController,
                            style: const TextStyle(
                              color: Color(0xFF2D3748),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                margin: const EdgeInsets.all(12),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 4, 45, 50), // Darker Teal
              Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
                                     ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.grey[200]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFF667eea),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorText: _usernameError,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 16,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _usernameError = _validateUsername(value);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password field
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            style: const TextStyle(
                              color: Color(0xFF2D3748),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              prefixIcon: Container(
                                margin: const EdgeInsets.all(12),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                       Color.fromARGB(255, 4, 45, 50), // Darker Teal
              Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
                                      ],
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16,
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.grey[200]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFF667eea),
                                  width: 2,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorText: _passwordError,
                              errorStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 16,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText ? Icons.visibility_off : Icons.visibility,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _passwordError = _validatePassword(value);
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Login button
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 4, 45, 50), // Darker Teal
              Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
                                ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF667eea).withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 1,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _isLoading ? null : _loginUser,
                            child: _isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Register section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => const Register(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 4, 45, 50), // Darker Teal
              Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
                                    ],
                                ).createShader(bounds),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}