// import 'package:flutter/material.dart';
// import 'package:learnlog/loginpage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart'; // Keep Firestore

// class Register extends StatefulWidget {
//   const Register({super.key}); // Added const for better performance

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();

//   String? _nameError;
//   String? _usernameError;
//   String? _phoneNumberError;
//   String? _passwordError;

//   String? _validateName(String name) { // Renamed for consistency
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(name)) {
//       return 'Name must not contain special characters or numbers';
//     }
//     if (name.isEmpty) {
//       return 'Name cannot be empty';
//     }
//     return null;
//   }

//   String? _validateUsername(String username) { // Renamed for consistency
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(username)) {
//       return 'Username must not contain special characters or numbers';
//     }
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
//     }
//     return null;
//   }

//   String? _validatePassword(String password) { // Renamed for consistency
//     if (password.length < 6) {
//       return 'Password must be at least 6 characters long';
//     }
//     if (!RegExp(r'[A-Z]').hasMatch(password)) {
//       return 'Password must contain at least one uppercase letter';
//     }
//     if (!RegExp(r'[0-9]').hasMatch(password)) {
//       return 'Password must contain at least one number';
//     }
//     if (password.isEmpty) { // Added empty check
//       return 'Password cannot be empty';
//     }
//     return null;
//   }

//   String? _validatePhoneNumber(String phoneNumber) { // Renamed for consistency
//     if (phoneNumber.isEmpty) { // Added empty check
//       return 'Phone number cannot be empty';
//     }
//     if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
//       return 'Phone number must be exactly 10 digits';
//     }
//     return null;
//   }

//   bool _obscureText = true; // For password visibility
//   bool _isChecked2 = false; // Renamed for consistency

//   Future<void> _registerUser() async {
//     setState(() {
//       _nameError = _validateName(_nameController.text);
//       _usernameError = _validateUsername(_usernameController.text);
//       _phoneNumberError = _validatePhoneNumber(_phoneNumberController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//     });

//     if (_nameError == null &&
//         _usernameError == null &&
//         _phoneNumberError == null &&
//         _passwordError == null) {
//       try {
//         // --- WARNING: Storing plain text password in Firestore is INSECURE ---
//         // This is for demonstration ONLY.
//         // In a real app, you MUST hash and salt passwords on a secure backend.
//         await FirebaseFirestore.instance.collection('users').add({
//           'name': _nameController.text,
//           'username': _usernameController.text,
//           'phoneNumber': _phoneNumberController.text,
//           'password': _passwordController.text, // !!! Highly INSECURE !!!
//           'createdAt': Timestamp.now(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration successful!')),
//         );
//         Navigator.pop(context); // Go back to login page
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred during registration: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft, // Consistent with Loginpage
//             end: Alignment.bottomRight, // Consistent with Loginpage
//             colors: [
//               Color(0xFF42A5F5), // Light Blue
//               Color(0xFF1976D2), // Darker Blue
//               Color(0xFF0D47A1), // Even Darker Blue
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0), // Added vertical padding
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // --- App Title / Logo ---
//                 const Icon(
//                   Icons.person_add_alt_1_rounded, // Changed icon for register
//                   size: 100,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Create Account',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 const Text(
//                   'Join us to get started!',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // --- Name Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _nameController, // Corrected controller name
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.badge, color: Colors.grey),
//                         labelText: 'Full Name',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _nameError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _nameError = _validateName(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // --- Username Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _usernameController, // Corrected controller name
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

//                 // --- Phone Number Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _phoneNumberController, // Corrected controller name
//                       keyboardType: TextInputType.number,
//                       maxLength: 10,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.phone, color: Colors.grey),
//                         labelText: 'Phone Number',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _phoneNumberError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         counterText: "", // Hide the default maxLength counter
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _phoneNumberError = _validatePhoneNumber(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // --- Password Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _passwordController, // Corrected controller name
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
//                 const SizedBox(height: 20),

//                 // --- Keep me signed in Checkbox ---
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start, // Align to start
//                     children: [
//                       Checkbox(
//                         value: _isChecked2, // Corrected variable name
//                         onChanged: (bool? value) {
//                           setState(() {
//                             _isChecked2 = value ?? false;
//                           });
//                         },
//                         activeColor: Color(0xFF1E88E5), // Blue checkbox
//                         checkColor: Colors.white,
//                       ),
//                       const Text(
//                         'Keep me signed in ',
//                         style: TextStyle(color: Colors.white70, fontSize: 15),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // --- Register Button ---
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF1E88E5), // Medium Blue for button
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       elevation: 5,
//                     ),
//                     onPressed: _registerUser, // Call the register function
//                     child: const Text(
//                       'REGISTER',
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

//                 // --- "Already have an account?" Row ---
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Already have an account?',
//                       style: TextStyle(color: Colors.white70, fontSize: 15),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => const Loginpage()),
//                         );
//                       },
//                       child: const Text(
//                         'LOGIN',
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
// import 'package:learnlog/loginpage.dart'; // Still navigating to login after registration
// import 'package:cloud_firestore/cloud_firestore.dart'; // Keep Firestore

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _classController = TextEditingController(); // Changed from username
//   final TextEditingController _rollNumberController = TextEditingController(); // Changed from phoneNumber
//   final TextEditingController _subjectsController = TextEditingController(); // New field for subjects

//   String? _nameError;
//   String? _classError; // Changed from usernameError
//   String? _rollNumberError; // Changed from phoneNumberError
//   String? _subjectsError; // New error for subjects

//   // Validation for Name
//   String? _validateName(String name) {
//     if (name.isEmpty) {
//       return 'Name cannot be empty';
//     }
//     // Allow spaces and some special characters for names, but disallow numbers
//     if (RegExp(r'[0-9!@#\$%^&*()_+={}\[\]|\\:;"<>,.?/~`]').hasMatch(name)) {
//       return 'Name must not contain numbers or most special characters';
//     }
//     return null;
//   }

//   // Validation for Class (e.g., "10A", "12th Grade", "5")
//   String? _validateClass(String className) {
//     if (className.isEmpty) {
//       return 'Class cannot be empty';
//     }
//     // You might want to refine this regex based on your specific class format
//     // This example allows alphanumeric characters and spaces
//     if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(className)) {
//       return 'Class can only contain letters, numbers, and spaces';
//     }
//     return null;
//   }

//   // Validation for Roll Number (numeric only)
//   String? _validateRollNumber(String rollNumber) {
//     if (rollNumber.isEmpty) {
//       return 'Roll Number cannot be empty';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(rollNumber)) {
//       return 'Roll Number must contain only digits';
//     }
//     return null;
//   }

//   // Validation for Number of Subjects (numeric only)
//   String? _validateSubjects(String subjects) {
//     if (subjects.isEmpty) {
//       return 'Number of subjects cannot be empty';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(subjects)) {
//       return 'Number of subjects must be a digit';
//     }
//     // Optional: Add a range check, e.g., if (int.parse(subjects) > 10) return 'Max 10 subjects';
//     return null;
//   }

//   // Removed _obscureText as password field is removed
//   // Removed _isChecked2 as "Keep me signed in" is removed

//   Future<void> _registerStudent() async { // Renamed function for clarity
//     setState(() {
//       _nameError = _validateName(_nameController.text);
//       _classError = _validateClass(_classController.text);
//       _rollNumberError = _validateRollNumber(_rollNumberController.text);
//       _subjectsError = _validateSubjects(_subjectsController.text);
//     });

//     if (_nameError == null &&
//         _classError == null &&
//         _rollNumberError == null &&
//         _subjectsError == null) {
//       try {
//         await FirebaseFirestore.instance.collection('students').add({ // Changed collection name to 'students'
//           'name': _nameController.text,
//           'class': _classController.text,
//           'rollNumber': _rollNumberController.text,
//           'subjectsCount': int.parse(_subjectsController.text), // Store as integer
//           'registeredAt': Timestamp.now(), // Changed from createdAt
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Student registered successfully!')),
//         );
//         Navigator.pop(context); // Go back to login page
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred during registration: $e')),
//         );
//       }
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
//               Color(0xFF42A5F5), // Light Blue
//               Color(0xFF1976D2), // Darker Blue
//               Color(0xFF0D47A1), // Even Darker Blue
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // --- App Title / Logo ---
//                 const Icon(
//                   Icons.school, // Changed icon to represent education/student
//                   size: 100,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Student Registration', // Updated title
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 const Text(
//                   'Enter student details below', // Updated subtitle
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // --- Name Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _nameController,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                         labelText: 'Full Name',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _nameError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _nameError = _validateName(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // --- Class Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _classController, // Changed controller
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.class_, color: Colors.grey), // Changed icon
//                         labelText: 'Class', // Changed label
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _classError, // Changed error variable
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _classError = _validateClass(value); // Changed validation
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // --- Roll Number Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _rollNumberController, // Changed controller
//                       keyboardType: TextInputType.number, // Keep numeric keyboard
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.format_list_numbered, color: Colors.grey), // Changed icon
//                         labelText: 'Roll Number', // Changed label
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _rollNumberError, // Changed error variable
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         counterText: "", // Hide the default maxLength counter
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _rollNumberError = _validateRollNumber(value); // Changed validation
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // --- Number of Subjects Input Field (replaces Password) ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _subjectsController, // New controller
//                       keyboardType: TextInputType.number, // Numeric input
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.book, color: Colors.grey), // New icon
//                         labelText: 'Number of Subjects', // New label
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _subjectsError, // New error variable
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _subjectsError = _validateSubjects(value); // New validation
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30), // Adjusted spacing

//                 // --- Register Button ---
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
//                     onPressed: _registerStudent, // Call the updated register function
//                     child: const Text(
//                       'REGISTER STUDENT', // Updated button text
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

//                 // --- "Already have an account?" Row ---
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Already have an account?',
//                       style: TextStyle(color: Colors.white70, fontSize: 15),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => const Loginpage()),
//                         );
//                       },
//                       child: const Text(
//                         'LOGIN',
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
// import 'package:learnlog/loginpage.dart'; // Still navigating to login after registration
// import 'package:cloud_firestore/cloud_firestore.dart'; // Keep Firestore

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _classController = TextEditingController();
//   final TextEditingController _rollNumberController = TextEditingController();

//   // List to hold controllers for each subject name
//   final List<TextEditingController> _subjectControllers = [];
//   // List to hold error messages for each subject name
//   final List<String?> _subjectErrors = [];

//   String? _nameError;
//   String? _classError;
//   String? _rollNumberError;

//   @override
//   void initState() {
//     super.initState();
//     _addSubjectField(); // Add one subject field by default when the screen loads
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _classController.dispose();
//     _rollNumberController.dispose();
//     // Dispose all subject controllers to prevent memory leaks
//     for (var controller in _subjectControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   // Helper to add a new subject input field
//   void _addSubjectField() {
//     setState(() {
//       _subjectControllers.add(TextEditingController());
//       _subjectErrors.add(null);
//     });
//   }

//   // Helper to remove a subject input field
//   void _removeSubjectField(int index) {
//     setState(() {
//       _subjectControllers[index].dispose(); // Dispose the controller
//       _subjectControllers.removeAt(index);
//       _subjectErrors.removeAt(index);
//     });
//   }

//   // Validation for Name
//   String? _validateName(String name) {
//     if (name.isEmpty) {
//       return 'Name cannot be empty';
//     }
//     if (RegExp(r'[0-9!@#\$%^&*()_+={}\[\]|\\:;"<>,.?/~`]').hasMatch(name)) {
//       return 'Name must not contain numbers or most special characters';
//     }
//     return null;
//   }

//   // Validation for Class (e.g., "10A", "12th Grade", "5")
//   String? _validateClass(String className) {
//     if (className.isEmpty) {
//       return 'Class cannot be empty';
//     }
//     if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(className)) {
//       return 'Class can only contain letters, numbers, and spaces';
//     }
//     return null;
//   }

//   // Validation for Roll Number (numeric only)
//   String? _validateRollNumber(String rollNumber) {
//     if (rollNumber.isEmpty) {
//       return 'Roll Number cannot be empty';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(rollNumber)) {
//       return 'Roll Number must contain only digits';
//     }
//     return null;
//   }

//   // Validation for individual Subject Name
//   String? _validateSubjectName(String subjectName) {
//     if (subjectName.isEmpty) {
//       return 'Subject name cannot be empty';
//     }
//     // You can refine this regex if you have specific naming conventions for subjects
//     if (!RegExp(r'^[a-zA-Z0-9\s.\-]+$').hasMatch(subjectName)) {
//       return 'Subject name contains invalid characters';
//     }
//     return null;
//   }

//   Future<void> _registerStudent() async {
//     setState(() {
//       _nameError = _validateName(_nameController.text);
//       _classError = _validateClass(_classController.text);
//       _rollNumberError = _validateRollNumber(_rollNumberController.text);

//       // Validate all subject fields
//       for (int i = 0; i < _subjectControllers.length; i++) {
//         _subjectErrors[i] = _validateSubjectName(_subjectControllers[i].text);
//       }
//     });

//     // Check if any error exists
//     if (_nameError == null &&
//         _classError == null &&
//         _rollNumberError == null &&
//         _subjectErrors.every((error) => error == null)) {
//       try {
//         // Collect all subject names
//         List<String> subjects = _subjectControllers
//             .map((controller) => controller.text.trim())
//             .where((text) => text.isNotEmpty) // Ensure no empty subject names are saved
//             .toList();

//         await FirebaseFirestore.instance.collection('students').add({
//           'name': _nameController.text,
//           'class': _classController.text,
//           'rollNumber': _rollNumberController.text,
//           'subjects': subjects, // Store the list of subject names
//           'registeredAt': Timestamp.now(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Student registered successfully!')),
//         );
//         Navigator.pop(context); // Go back to login page
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred during registration: $e')),
//         );
//       }
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
//               Color(0xFF42A5F5), // Light Blue
//               Color(0xFF1976D2), // Darker Blue
//               Color(0xFF0D47A1), // Even Darker Blue
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // --- App Title / Logo ---
//                 const Icon(
//                   Icons.school,
//                   size: 100,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Student Registration',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//                 const Text(
//                   'Enter student details below',
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 40),

//                 // --- Name Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _nameController,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.person, color: Colors.grey),
//                         labelText: 'Full Name',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _nameError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _nameError = _validateName(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // --- Class Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _classController,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.class_, color: Colors.grey),
//                         labelText: 'Class',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _classError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _classError = _validateClass(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // --- Roll Number Input Field ---
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _rollNumberController,
//                       keyboardType: TextInputType.number,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.format_list_numbered, color: Colors.grey),
//                         labelText: 'Roll Number',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _rollNumberError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         counterText: "",
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _rollNumberError = _validateRollNumber(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // --- Dynamic Subject Name Input Fields ---
//                 // Build a list of subject input fields dynamically
//                 ...List.generate(_subjectControllers.length, (index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 5.0),
//                     child: Card(
//                       elevation: 8,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.subject, color: Colors.grey),
//                             const SizedBox(width: 12),
//                             Expanded(
//                               child: TextField(
//                                 controller: _subjectControllers[index],
//                                 style: const TextStyle(color: Colors.black87),
//                                 decoration: InputDecoration(
//                                   labelText: 'Subject ${index + 1} Name',
//                                   labelStyle: const TextStyle(color: Colors.grey),
//                                   border: InputBorder.none,
//                                   errorText: _subjectErrors[index],
//                                   errorStyle: const TextStyle(color: Colors.redAccent),
//                                 ),
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _subjectErrors[index] = _validateSubjectName(value);
//                                   });
//                                 },
//                               ),
//                             ),
//                             // Button to remove subject field (optional, but good for UX)
//                             if (_subjectControllers.length > 1) // Don't allow removing the last one
//                               IconButton(
//                                 icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent),
//                                 onPressed: () => _removeSubjectField(index),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//                 const SizedBox(height: 10),

//                 // --- Add Subject Button ---
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton.icon(
//                     onPressed: _addSubjectField,
//                     icon: const Icon(Icons.add_circle, color: Colors.white),
//                     label: const Text(
//                       'Add Another Subject',
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),

//                 // --- Register Button ---
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
//                     onPressed: _registerStudent,
//                     child: const Text(
//                       'REGISTER STUDENT',
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

//                 // --- "Already have an account?" Row ---
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Already have an account?',
//                       style: TextStyle(color: Colors.white70, fontSize: 15),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) => const Loginpage()),
//                         );
//                       },
//                       child: const Text(
//                         'LOGIN',
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
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   String? _usernameError;
//   String? _passwordError;
//   String? _confirmPasswordError;

//   bool _obscureTextPassword = true;
//   bool _obscureTextConfirmPassword = true;

//   String? _validateUsername(String username) {
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(username)) {
//       return 'Username must not contain special characters or numbers';
//     }
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
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

//   String? _validateConfirmPassword(String confirmPassword, String password) {
//     if (confirmPassword.isEmpty) {
//       return 'Confirm password cannot be empty';
//     }
//     if (confirmPassword != password) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   Future<void> _registerUser() async {
//     setState(() {
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//       _confirmPasswordError = _validateConfirmPassword(
//           _confirmPasswordController.text, _passwordController.text);
//     });

//     if (_usernameError == null &&
//         _passwordError == null &&
//         _confirmPasswordError == null) {
//       try {
//         // Check if username already exists
//         final QuerySnapshot existingUsers = await FirebaseFirestore.instance
//             .collection('users')
//             .where('username', isEqualTo: _usernameController.text)
//             .get();

//         if (existingUsers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Username already exists. Please choose another.')),
//           );
//           return; // Stop registration if username exists
//         }

//         // Add user to Firestore (WARNING: Storing plain password is INSECURE)
//         await FirebaseFirestore.instance.collection('users').add({
//           'username': _usernameController.text,
//           'password': _passwordController.text, // !!! Highly INSECURE !!!
//           'created_at': Timestamp.now(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration successful!')),
//         );
//         Navigator.of(context).pop(); // Go back to login page
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error registering user: $e')),
//         );
//         print('Registration error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix the errors in the form.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register Account', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF1976D2), // Darker Blue from login gradient
//         iconTheme: const IconThemeData(color: Colors.white), // For back arrow
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF42A5F5), // Light Blue
//               Color(0xFF1976D2), // Darker Blue
//               Color(0xFF0D47A1), // Even Darker Blue
//             ],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Create New Account',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),

//                 // Username Input
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

//                 // Password Input
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
//                       obscureText: _obscureTextPassword,
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
//                             _obscureTextPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextPassword = !_obscureTextPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _passwordError = _validatePassword(value);
//                           _confirmPasswordError = _validateConfirmPassword(
//                               _confirmPasswordController.text, value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Confirm Password Input
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _confirmPasswordController,
//                       obscureText: _obscureTextConfirmPassword,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                         labelText: 'Confirm Password',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _confirmPasswordError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureTextConfirmPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _confirmPasswordError = _validateConfirmPassword(
//                               value, _passwordController.text);
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Register Button
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
//                     onPressed: _registerUser,
//                     child: const Text(
//                       'REGISTER',
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

//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Go back to Login page
//                   },
//                   child: const Text(
//                     'Already have an account? Login',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
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
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   String? _usernameError;
//   String? _passwordError;
//   String? _confirmPasswordError;

//   bool _obscureTextPassword = true;
//   bool _obscureTextConfirmPassword = true;

//   String? _validateUsername(String username) {
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%)]').hasMatch(username)) { // Removed 0-9 from regex
//       return 'Username must not contain special characters';
//     }
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
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

//   String? _validateConfirmPassword(String confirmPassword, String password) {
//     if (confirmPassword.isEmpty) {
//       return 'Confirm password cannot be empty';
//     }
//     if (confirmPassword != password) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   Future<void> _registerUser() async {
//     setState(() {
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//       _confirmPasswordError = _validateConfirmPassword(
//           _confirmPasswordController.text, _passwordController.text);
//     });

//     if (_usernameError == null &&
//         _passwordError == null &&
//         _confirmPasswordError == null) {
//       try {
//         // Check if username already exists in the 'users' collection
//         final QuerySnapshot existingUsers = await FirebaseFirestore.instance
//             .collection('users') // Assumes students register here
//             .where('username', isEqualTo: _usernameController.text)
//             .get();

//         if (existingUsers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Username already exists. Please choose another.')),
//           );
//           return; // Stop registration if username exists
//         }

//         // Add user to Firestore (WARNING: Storing plain password is INSECURE)
//         await FirebaseFirestore.instance.collection('users').add({ // Registering into 'users' collection
//           'username': _usernameController.text,
//           'password': _passwordController.text, // !!! Highly INSECURE !!!
//           'created_at': Timestamp.now(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration successful!')),
//         );
//         Navigator.of(context).pop(); // Go back to login page
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error registering user: $e')),
//         );
//         print('Registration error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix the errors in the form.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Register Account', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF1976D2),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
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
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Create New Account',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                   textAlign: TextAlign.center,
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
//                       obscureText: _obscureTextPassword,
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
//                             _obscureTextPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextPassword = !_obscureTextPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _passwordError = _validatePassword(value);
//                           _confirmPasswordError = _validateConfirmPassword(
//                               _confirmPasswordController.text, value);
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
//                       controller: _confirmPasswordController,
//                       obscureText: _obscureTextConfirmPassword,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                         labelText: 'Confirm Password',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _confirmPasswordError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureTextConfirmPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _confirmPasswordError = _validateConfirmPassword(
//                               value, _passwordController.text);
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
//                     onPressed: _registerUser,
//                     child: const Text(
//                       'REGISTER',
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

//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     'Already have an account? Login',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
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
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _studentNameController = TextEditingController();
//   final TextEditingController _rollNumberController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   String? _studentNameError;
//   String? _rollNumberError;
//   String? _usernameError;
//   String? _passwordError;
//   String? _confirmPasswordError;
//   String? _divisionError;

//   String? _selectedDivision;
//   final List<String> _divisions = ['A', 'B', 'C'];

//   bool _obscureTextPassword = true;
//   bool _obscureTextConfirmPassword = true;

//   String? _validateStudentName(String name) {
//     if (name.isEmpty) {
//       return 'Student name cannot be empty';
//     }
//     if (name.length < 2) {
//       return 'Student name must be at least 2 characters long';
//     }
//     return null;
//   }

//   String? _validateRollNumber(String rollNumber) {
//     if (rollNumber.isEmpty) {
//       return 'Roll number cannot be empty';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(rollNumber)) {
//       return 'Roll number must contain only numbers';
//     }
//     return null;
//   }

//   String? _validateDivision() {
//     if (_selectedDivision == null || _selectedDivision!.isEmpty) {
//       return 'Please select a division';
//     }
//     return null;
//   }

//   String? _validateUsername(String username) {
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%)]').hasMatch(username)) {
//       return 'Username must not contain special characters';
//     }
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
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

//   String? _validateConfirmPassword(String confirmPassword, String password) {
//     if (confirmPassword.isEmpty) {
//       return 'Confirm password cannot be empty';
//     }
//     if (confirmPassword != password) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   Future<void> _registerUser() async {
//     setState(() {
//       _studentNameError = _validateStudentName(_studentNameController.text);
//       _rollNumberError = _validateRollNumber(_rollNumberController.text);
//       _divisionError = _validateDivision();
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//       _confirmPasswordError = _validateConfirmPassword(
//           _confirmPasswordController.text, _passwordController.text);
//     });

//     if (_studentNameError == null &&
//         _rollNumberError == null &&
//         _divisionError == null &&
//         _usernameError == null &&
//         _passwordError == null &&
//         _confirmPasswordError == null) {
//       try {
//         // Check if username already exists
//         final QuerySnapshot existingUsers = await FirebaseFirestore.instance
//             .collection('users')
//             .where('username', isEqualTo: _usernameController.text)
//             .get();

//         if (existingUsers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Username already exists. Please choose another.')),
//           );
//           return;
//         }

//         // Check if roll number already exists in the same division
//         final QuerySnapshot existingRollNumbers = await FirebaseFirestore.instance
//             .collection('users')
//             .where('roll_number', isEqualTo: _rollNumberController.text)
//             .where('division', isEqualTo: _selectedDivision)
//             .get();

//         if (existingRollNumbers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Roll number already exists in this division.')),
//           );
//           return;
//         }

//         // Add user to Firestore (WARNING: Storing plain password is INSECURE)
//         await FirebaseFirestore.instance.collection('users').add({
//           'student_name': _studentNameController.text,
//           'roll_number': _rollNumberController.text,
//           'division': _selectedDivision,
//           'username': _usernameController.text,
//           'password': _passwordController.text, // !!! Highly INSECURE !!!
//           'created_at': Timestamp.now(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration successful!')),
//         );
//         Navigator.of(context).pop();
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error registering user: $e')),
//         );
//         print('Registration error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix the errors in the form.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Registration', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF1976D2),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
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
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Student Registration',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),

//                 // Student Name Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _studentNameController,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
//                         labelText: 'Student Name',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _studentNameError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _studentNameError = _validateStudentName(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Roll Number Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _rollNumberController,
//                       keyboardType: TextInputType.number,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.numbers, color: Colors.grey),
//                         labelText: 'Roll Number',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _rollNumberError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _rollNumberError = _validateRollNumber(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Division Dropdown
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: DropdownButtonFormField<String>(
//                       value: _selectedDivision,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.class_, color: Colors.grey),
//                         labelText: 'Division',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _divisionError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       items: _divisions.map((String division) {
//                         return DropdownMenuItem<String>(
//                           value: division,
//                           child: Text(
//                             'Division $division',
//                             style: const TextStyle(color: Colors.black87),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedDivision = newValue;
//                           _divisionError = _validateDivision();
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Username Field
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

//                 // Password Field
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
//                       obscureText: _obscureTextPassword,
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
//                             _obscureTextPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextPassword = !_obscureTextPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _passwordError = _validatePassword(value);
//                           _confirmPasswordError = _validateConfirmPassword(
//                               _confirmPasswordController.text, value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Confirm Password Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _confirmPasswordController,
//                       obscureText: _obscureTextConfirmPassword,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                         labelText: 'Confirm Password',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _confirmPasswordError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureTextConfirmPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _confirmPasswordError = _validateConfirmPassword(
//                               value, _passwordController.text);
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Register Button
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
//                     onPressed: _registerUser,
//                     child: const Text(
//                       'REGISTER',
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

//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     'Already have an account? Login',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
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
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _studentNameController = TextEditingController();
//   final TextEditingController _rollNumberController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   String? _studentNameError;
//   String? _rollNumberError;
//   String? _usernameError;
//   String? _passwordError;
//   String? _confirmPasswordError;
//   String? _classError;

//   String? _selectedClass;
//   final List<String> _classes = List.generate(12, (index) => (index + 1).toString());

//   bool _obscureTextPassword = true;
//   bool _obscureTextConfirmPassword = true;

//   String? _validateStudentName(String name) {
//     if (name.isEmpty) {
//       return 'Student name cannot be empty';
//     }
//     if (name.length < 2) {
//       return 'Student name must be at least 2 characters long';
//     }
//     return null;
//   }

//   String? _validateRollNumber(String rollNumber) {
//     if (rollNumber.isEmpty) {
//       return 'Roll number cannot be empty';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(rollNumber)) {
//       return 'Roll number must contain only numbers';
//     }
//     return null;
//   }

//   String? _validateClass() {
//     if (_selectedClass == null || _selectedClass!.isEmpty) {
//       return 'Please select a class';
//     }
//     return null;
//   }

//   String? _validateUsername(String username) {
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%)]').hasMatch(username)) {
//       return 'Username must not contain special characters';
//     }
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
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

//   String? _validateConfirmPassword(String confirmPassword, String password) {
//     if (confirmPassword.isEmpty) {
//       return 'Confirm password cannot be empty';
//     }
//     if (confirmPassword != password) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   Future<void> _registerUser() async {
//     setState(() {
//       _studentNameError = _validateStudentName(_studentNameController.text);
//       _rollNumberError = _validateRollNumber(_rollNumberController.text);
//       _classError = _validateClass();
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//       _confirmPasswordError = _validateConfirmPassword(
//           _confirmPasswordController.text, _passwordController.text);
//     });

//     if (_studentNameError == null &&
//         _rollNumberError == null &&
//         _classError == null &&
//         _usernameError == null &&
//         _passwordError == null &&
//         _confirmPasswordError == null) {
//       try {
//         // Check if username already exists
//         final QuerySnapshot existingUsers = await FirebaseFirestore.instance
//             .collection('users')
//             .where('username', isEqualTo: _usernameController.text)
//             .get();

//         if (existingUsers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Username already exists. Please choose another.')),
//           );
//           return;
//         }

//         // Check if roll number already exists in the same class
//         final QuerySnapshot existingRollNumbers = await FirebaseFirestore.instance
//             .collection('users')
//             .where('roll_number', isEqualTo: _rollNumberController.text)
//             .where('class', isEqualTo: _selectedClass)
//             .get();

//         if (existingRollNumbers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Roll number already exists in this class.')),
//           );
//           return;
//         }

//         // Add user to Firestore (WARNING: Storing plain password is INSECURE)
//         await FirebaseFirestore.instance.collection('users').add({
//           'student_name': _studentNameController.text,
//           'roll_number': _rollNumberController.text,
//           'class': _selectedClass, // Save class instead of division
//           'username': _usernameController.text,
//           'password': _passwordController.text, // !!! Highly INSECURE !!!
//           'created_at': Timestamp.now(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration successful!')),
//         );
//         Navigator.of(context).pop();
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error registering user: $e')),
//         );
//         print('Registration error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix the errors in the form.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Registration', style: TextStyle(color: Colors.white)),
//         backgroundColor: const Color(0xFF1976D2),
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
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Student Registration',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),

//                 // Student Name Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _studentNameController,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
//                         labelText: 'Student Name',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _studentNameError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _studentNameError = _validateStudentName(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Roll Number Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _rollNumberController,
//                       keyboardType: TextInputType.number,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.numbers, color: Colors.grey),
//                         labelText: 'Roll Number',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _rollNumberError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _rollNumberError = _validateRollNumber(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Class Dropdown
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: DropdownButtonFormField<String>(
//                       value: _selectedClass,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.class_, color: Colors.grey),
//                         labelText: 'Class',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _classError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       items: _classes.map((String classNum) {
//                         return DropdownMenuItem<String>(
//                           value: classNum,
//                           child: Text(
//                             'Class $classNum',
//                             style: const TextStyle(color: Colors.black87),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedClass = newValue;
//                           _classError = _validateClass();
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Username Field
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

//                 // Password Field
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
//                       obscureText: _obscureTextPassword,
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
//                             _obscureTextPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextPassword = !_obscureTextPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _passwordError = _validatePassword(value);
//                           _confirmPasswordError = _validateConfirmPassword(
//                               _confirmPasswordController.text, value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Confirm Password Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _confirmPasswordController,
//                       obscureText: _obscureTextConfirmPassword,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                         labelText: 'Confirm Password',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _confirmPasswordError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureTextConfirmPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _confirmPasswordError = _validateConfirmPassword(
//                               value, _passwordController.text);
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Register Button
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
//                     onPressed: _registerUser,
//                     child: const Text(
//                       'REGISTER',
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

//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     'Already have an account? Login',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
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
// import 'package:cloud_firestore/cloud_firestore.dart';

// class Register extends StatefulWidget {
//   const Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final TextEditingController _studentNameController = TextEditingController();
//   final TextEditingController _rollNumberController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();

//   String? _studentNameError;
//   String? _rollNumberError;
//   String? _usernameError;
//   String? _passwordError;
//   String? _confirmPasswordError;
//   String? _classError;
//   String? _divisionError;

//   String? _selectedClass;
//   String? _selectedDivision;
//   final List<String> _classes = List.generate(12, (index) => (index + 1).toString());
//   final List<String> _divisions = ['A', 'B', 'C'];

//   bool _obscureTextPassword = true;
//   bool _obscureTextConfirmPassword = true;

//   String? _validateStudentName(String name) {
//     if (name.isEmpty) {
//       return 'Student name cannot be empty';
//     }
//     if (name.length < 2) {
//       return 'Student name must be at least 2 characters long';
//     }
//     return null;
//   }

//   String? _validateRollNumber(String rollNumber) {
//     if (rollNumber.isEmpty) {
//       return 'Roll number cannot be empty';
//     }
//     if (!RegExp(r'^[0-9]+$').hasMatch(rollNumber)) {
//       return 'Roll number must contain only numbers';
//     }
//     return null;
//   }

//   String? _validateClass() {
//     if (_selectedClass == null || _selectedClass!.isEmpty) {
//       return 'Please select a class';
//     }
//     return null;
//   }

//   String? _validateDivision() {
//     if (_selectedDivision == null || _selectedDivision!.isEmpty) {
//       return 'Please select a division';
//     }
//     return null;
//   }

//   String? _validateUsername(String username) {
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%)]').hasMatch(username)) {
//       return 'Username must not contain special characters';
//     }
//     if (username.isEmpty) {
//       return 'Username cannot be empty';
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

//   String? _validateConfirmPassword(String confirmPassword, String password) {
//     if (confirmPassword.isEmpty) {
//       return 'Confirm password cannot be empty';
//     }
//     if (confirmPassword != password) {
//       return 'Passwords do not match';
//     }
//     return null;
//   }

//   Future<void> _registerUser() async {
//     setState(() {
//       _studentNameError = _validateStudentName(_studentNameController.text);
//       _rollNumberError = _validateRollNumber(_rollNumberController.text);
//       _classError = _validateClass();
//       _divisionError = _validateDivision();
//       _usernameError = _validateUsername(_usernameController.text);
//       _passwordError = _validatePassword(_passwordController.text);
//       _confirmPasswordError = _validateConfirmPassword(
//           _confirmPasswordController.text, _passwordController.text);
//     });

//     if (_studentNameError == null &&
//         _rollNumberError == null &&
//         _classError == null &&
//         _divisionError == null &&
//         _usernameError == null &&
//         _passwordError == null &&
//         _confirmPasswordError == null) {
//       try {
//         // Check if username already exists
//         final QuerySnapshot existingUsers = await FirebaseFirestore.instance
//             .collection('users')
//             .where('username', isEqualTo: _usernameController.text)
//             .get();

//         if (existingUsers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Username already exists. Please choose another.')),
//           );
//           return;
//         }

//         // Check if roll number already exists in the same class and division
//         final QuerySnapshot existingRollNumbers = await FirebaseFirestore.instance
//             .collection('users')
//             .where('roll_number', isEqualTo: _rollNumberController.text)
//             .where('class', isEqualTo: _selectedClass)
//             .where('division', isEqualTo: _selectedDivision)
//             .get();

//         if (existingRollNumbers.docs.isNotEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Roll number already exists in this class and division.')),
//           );
//           return;
//         }

//         // Add user to Firestore (WARNING: Storing plain password is INSECURE)
//         await FirebaseFirestore.instance.collection('users').add({
//           'student_name': _studentNameController.text,
//           'roll_number': _rollNumberController.text,
//           'class': _selectedClass,
//           'division': _selectedDivision,
//           'username': _usernameController.text,
//           'password': _passwordController.text, // !!! Highly INSECURE !!!
//           'created_at': Timestamp.now(),
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration successful!')),
//         );
//         Navigator.of(context).pop();
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error registering user: $e')),
//         );
//         print('Registration error: $e');
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fix the errors in the form.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Registration', style: TextStyle(color: Colors.white)),
//         backgroundColor:Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
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
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Student Registration',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 1.2,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 40),

//                 // Student Name Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _studentNameController,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
//                         labelText: 'Student Name',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _studentNameError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _studentNameError = _validateStudentName(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Roll Number Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _rollNumberController,
//                       keyboardType: TextInputType.number,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.numbers, color: Colors.grey),
//                         labelText: 'Roll Number',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _rollNumberError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _rollNumberError = _validateRollNumber(value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Class Dropdown
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: DropdownButtonFormField<String>(
//                       value: _selectedClass,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.class_, color: Colors.grey),
//                         labelText: 'Class',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _classError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       items: _classes.map((String classNum) {
//                         return DropdownMenuItem<String>(
//                           value: classNum,
//                           child: Text(
//                             'Class $classNum',
//                             style: const TextStyle(color: Colors.black87),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedClass = newValue;
//                           _classError = _validateClass();
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Division Dropdown
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: DropdownButtonFormField<String>(
//                       value: _selectedDivision,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.group, color: Colors.grey),
//                         labelText: 'Division',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _divisionError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                       ),
//                       items: _divisions.map((String division) {
//                         return DropdownMenuItem<String>(
//                           value: division,
//                           child: Text(
//                             'Division $division',
//                             style: const TextStyle(color: Colors.black87),
//                           ),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           _selectedDivision = newValue;
//                           _divisionError = _validateDivision();
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Username Field
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

//                 // Password Field
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
//                       obscureText: _obscureTextPassword,
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
//                             _obscureTextPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextPassword = !_obscureTextPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _passwordError = _validatePassword(value);
//                           _confirmPasswordError = _validateConfirmPassword(
//                               _confirmPasswordController.text, value);
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 // Confirm Password Field
//                 Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   margin: const EdgeInsets.symmetric(vertical: 10),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                     child: TextField(
//                       controller: _confirmPasswordController,
//                       obscureText: _obscureTextConfirmPassword,
//                       style: const TextStyle(color: Colors.black87),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(Icons.lock, color: Colors.grey),
//                         labelText: 'Confirm Password',
//                         labelStyle: const TextStyle(color: Colors.grey),
//                         border: InputBorder.none,
//                         errorText: _confirmPasswordError,
//                         errorStyle: const TextStyle(color: Colors.redAccent),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             _obscureTextConfirmPassword
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: Colors.grey,
//                           ),
//                           onPressed: () {
//                             setState(() {
//                               _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
//                             });
//                           },
//                         ),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _confirmPasswordError = _validateConfirmPassword(
//                               value, _passwordController.text);
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Register Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                       elevation: 5,
//                     ),
//                     onPressed: _registerUser,
//                     child: const Text(
//                       'REGISTER',
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

//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text(
//                     'Registration succeful! Loging in.....',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                   ),
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
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _rollNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late AnimationController _formAnimationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _formAnimation;
  late Animation<double> _buttonAnimation;

  String? _studentNameError;
  String? _rollNumberError;
  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _classError;
  String? _divisionError;

  String? _selectedClass;
  String? _selectedDivision;
  final List<String> _classes = List.generate(12, (index) => (index + 1).toString());
  final List<String> _divisions = ['A', 'B', 'C'];

  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _formAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _formAnimationController,
      curve: Curves.easeOutBack,
    ));
    
    _buttonAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeInOut,
    ));

    _formAnimationController.forward();
  }

  @override
  void dispose() {
    _formAnimationController.dispose();
    _buttonAnimationController.dispose();
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

  String? _validateConfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return 'Confirm password cannot be empty';
    }
    if (confirmPassword != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _registerUser() async {
    setState(() {
      _isLoading = true;
      _studentNameError = _validateStudentName(_studentNameController.text);
      _rollNumberError = _validateRollNumber(_rollNumberController.text);
      _classError = _validateClass();
      _divisionError = _validateDivision();
      _usernameError = _validateUsername(_usernameController.text);
      _passwordError = _validatePassword(_passwordController.text);
      _confirmPasswordError = _validateConfirmPassword(
          _confirmPasswordController.text, _passwordController.text);
    });

    _buttonAnimationController.forward().then((_) {
      _buttonAnimationController.reverse();
    });

    if (_studentNameError == null &&
        _rollNumberError == null &&
        _classError == null &&
        _divisionError == null &&
        _usernameError == null &&
        _passwordError == null &&
        _confirmPasswordError == null) {
      try {
        // Check if username already exists
        final QuerySnapshot existingUsers = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: _usernameController.text)
            .get();

        if (existingUsers.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Username already exists. Please choose another.'),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
          setState(() => _isLoading = false);
          return;
        }

        // Check if roll number already exists in the same class and division
        final QuerySnapshot existingRollNumbers = await FirebaseFirestore.instance
            .collection('users')
            .where('roll_number', isEqualTo: _rollNumberController.text)
            .where('class', isEqualTo: _selectedClass)
            .where('division', isEqualTo: _selectedDivision)
            .get();

        if (existingRollNumbers.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Roll number already exists in this class and division.'),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
          setState(() => _isLoading = false);
          return;
        }

        // Add user to Firestore
        await FirebaseFirestore.instance.collection('users').add({
          'student_name': _studentNameController.text,
          'roll_number': _rollNumberController.text,
          'class': _selectedClass,
          'division': _selectedDivision,
          'username': _usernameController.text,
          'password': _passwordController.text,
          'created_at': Timestamp.now(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Registration successful!'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        
        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error registering user: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        print('Registration error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fix the errors in the form.'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
    
    setState(() => _isLoading = false);
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? errorText,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    bool showVisibilityToggle = false,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
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
                  Color.fromARGB(255, 4, 45, 50), 
                  Color.fromARGB(255, 13, 74, 83), 
              ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          hintText: 'Enter your $label',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
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
            borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          suffixIcon: showVisibilityToggle
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey[600],
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required IconData icon,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    String? errorText,
    required String Function(String) itemBuilder,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color.fromARGB(255, 4, 45, 50), 
                  Color.fromARGB(255, 13, 74, 83), ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          hintText: 'Select $label',
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
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
            borderSide: const BorderSide(color: Color(0xFF667eea), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorText: errorText,
          errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        ),
        dropdownColor: Colors.white,
        style: const TextStyle(color: Color(0xFF2D3748), fontSize: 16),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(itemBuilder(item)),
          );
        }).toList(),
        onChanged: onChanged,
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
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 40), // Balance the back button
                  ],
                ),
              ),
              
              // Form Container
              Expanded(
                child: AnimatedBuilder(
                  animation: _formAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - _formAnimation.value)),
                      child: Opacity(
                        opacity: _formAnimation.value,
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(24),
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
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                const Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Join LearnLog',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2D3748),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Create your student account to get started',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Form Fields
                                _buildTextField(
                                  controller: _studentNameController,
                                  label: 'student name',
                                  icon: Icons.person_outline,
                                  errorText: _studentNameError,
                                  onChanged: (value) {
                                    setState(() {
                                      _studentNameError = _validateStudentName(value);
                                    });
                                  },
                                ),

                                _buildTextField(
                                  controller: _rollNumberController,
                                  label: 'roll number',
                                  icon: Icons.numbers,
                                  errorText: _rollNumberError,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    setState(() {
                                      _rollNumberError = _validateRollNumber(value);
                                    });
                                  },
                                ),

                                _buildDropdown(
                                  label: 'class',
                                  icon: Icons.school,
                                  value: _selectedClass,
                                  items: _classes,
                                  errorText: _classError,
                                  itemBuilder: (classNum) => 'Class $classNum',
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedClass = newValue;
                                      _classError = _validateClass();
                                    });
                                  },
                                ),

                                _buildDropdown(
                                  label: 'division',
                                  icon: Icons.group,
                                  value: _selectedDivision,
                                  items: _divisions,
                                  errorText: _divisionError,
                                  itemBuilder: (division) => 'Division $division',
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedDivision = newValue;
                                      _divisionError = _validateDivision();
                                    });
                                  },
                                ),

                                _buildTextField(
                                  controller: _usernameController,
                                  label: 'username',
                                  icon: Icons.alternate_email,
                                  errorText: _usernameError,
                                  onChanged: (value) {
                                    setState(() {
                                      _usernameError = _validateUsername(value);
                                    });
                                  },
                                ),

                                _buildTextField(
                                  controller: _passwordController,
                                  label: 'password',
                                  icon: Icons.lock_outline,
                                  errorText: _passwordError,
                                  obscureText: _obscureTextPassword,
                                  showVisibilityToggle: true,
                                  onToggleVisibility: () {
                                    setState(() {
                                      _obscureTextPassword = !_obscureTextPassword;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _passwordError = _validatePassword(value);
                                      _confirmPasswordError = _validateConfirmPassword(
                                          _confirmPasswordController.text, value);
                                    });
                                  },
                                ),

                                _buildTextField(
                                  controller: _confirmPasswordController,
                                  label: 'confirm password',
                                  icon: Icons.lock_outline,
                                  errorText: _confirmPasswordError,
                                  obscureText: _obscureTextConfirmPassword,
                                  showVisibilityToggle: true,
                                  onToggleVisibility: () {
                                    setState(() {
                                      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _confirmPasswordError = _validateConfirmPassword(
                                          value, _passwordController.text);
                                    });
                                  },
                                ),

                                const SizedBox(height: 16),

                                // Register Button
                                AnimatedBuilder(
                                  animation: _buttonAnimation,
                                  builder: (context, child) {
                                    return Transform.scale(
                                      scale: _buttonAnimation.value,
                                      child: Container(
                                        width: double.infinity,
                                        height: 56,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [Color.fromARGB(255, 4, 45, 50), 
                  Color.fromARGB(255, 13, 74, 83), ],
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
                                          onPressed: _isLoading ? null : _registerUser,
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
                                                  'Create Account',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Back to Login
                                Center(
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Already have an account? ",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 16,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Sign In',
                                            style: TextStyle(
                                              color: const Color(0xFF667eea),
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                              decorationColor: const Color(0xFF667eea),
                                            ),
                                          ),
                                        ],
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
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}