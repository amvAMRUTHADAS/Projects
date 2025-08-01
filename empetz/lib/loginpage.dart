// import 'package:empetz/Registerscreen.dart';
// import 'package:empetz/homepage.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class Loginpage extends StatefulWidget {
//   const Loginpage({super.key});

//   @override
//   State<Loginpage> createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {
//   final TextEditingController UsernameController = TextEditingController();
//   final TextEditingController PasswordController = TextEditingController();
//   Future<void> savedata() async {
//     final Url = Uri.parse(
//       "http://192.168.1.35/Empetz/api/v1/user/login",
//     );
//     final response = await http.post(
//       Url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         "userName": UsernameController.text.trim(),
//         "password": PasswordController.text.trim(),
//       }),
//     );
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final token = jsonDecode(response.body)['token'];
//       await SharedPreferences.getInstance().then((prefs) => prefs.setString(
//           'auth_token',
//           token)); // executes the function after the instance is ready,store the token as string.
//       //token saved shsredprefreence
//       print('token show ${token}');

//       print("datapost successfully");
//       print(response.body);
//       ScaffoldMessenger.of(
//         context,
        
//       ).showSnackBar(SnackBar(content: Text('Login successfully')));
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => Homepage()),
//       );
//     } else {
//       print(response.statusCode);
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Failed to Login")));
//     }
//   }

//   String? UsernameError;
//   String? PasswordError;
//   String? validateUsername(String Username) {
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(Username)) {
//       return 'Username must not contain special characters or numbers';
//     }

//     if (Username.isEmpty) {
//       return 'username cannot be empty';
//     }
//     return null;
//   }

//   String? validatePassword(String Password) {
//     if (Password.length < 6) {
//       return 'password must be at least 6 characters long';
//     }

//     if (!RegExp(r'[A-Z]').hasMatch(Password)) {
//       return 'password must be at least one upercase letter';
//     }
//     if (!RegExp(r'[0-9]').hasMatch(Password)) {
//       return 'password must be at least one number';
//     }
//     if (Password.isEmpty) {
//       return 'username cannot be empty';
//     }
//     return null;
//   }

//   bool _obscureText = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 const Color.fromARGB(255, 15, 29, 51),
//                 const Color.fromARGB(255, 127, 0, 0),
//                 const Color.fromARGB(255, 15, 29, 51),
//                 const Color.fromARGB(255, 127, 0, 0),
//               ]),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 style: TextStyle(color: Colors.white),
//                 controller: UsernameController,
//                 decoration: InputDecoration(
//                   labelStyle: TextStyle(color: Colors.white),
//                   labelText: 'Username',
//                   errorText: UsernameError,
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     UsernameError = validateUsername(value);
//                   });
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 style: TextStyle(color: Colors.white),
//                 controller: PasswordController,
//                 obscureText: _obscureText,
//                 decoration: InputDecoration(
//                     labelStyle: TextStyle(color: Colors.white),
//                     labelText: 'Password',
//                     errorText: PasswordError,
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                           color: Colors.white,
//                           _obscureText
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                       onPressed: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                     )),
//                 onChanged: (value) {
//                   setState(() {
//                     PasswordError = validatePassword(value);
//                   });
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 148, 61, 61),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     PasswordError = validatePassword(PasswordController.text);
//                   });
//                   setState(() {
//                     UsernameError = validateUsername(UsernameController.text);
//                   });
//                   if (PasswordError == null && UsernameError == null) {
//                     savedata();
//                   }
//                 },
//                 child: Text(
//                   'Login',
//                   style: TextStyle(
//                       color: const Color.fromARGB(255, 220, 205, 205),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 19),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Donot have an account',
//                   style: TextStyle(color: Colors.amber[100]),
//                 ),
//                 TextButton(
//                     onPressed: () {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(builder: (context) => Register()),
//                       );
//                     },
//                     child: Text(
//                       'Create Account',
//                       style: TextStyle(
//                           color: const Color.fromARGB(255, 231, 228, 228)),
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:empetz/Registerscreen.dart';
import 'package:empetz/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();

  Future<void> savedata() async {
    final Url = Uri.parse(
      "http://192.168.1.35/Empetz/api/v1/user/login",
    );
    final response = await http.post(
      Url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "userName": UsernameController.text.trim(),
        "password": PasswordController.text.trim(),
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      final token = responseBody['token'];
      final userName = UsernameController.text.trim(); // Get the username from the controller

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('username', userName); // Save the username

      print('Token show: $token');
      print('Username saved: $userName');
      print("Data posted successfully");
      print(response.body);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successfully')));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Homepage()),
      );
    } else {
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to Login")));
    }
  }

  String? UsernameError;
  String? PasswordError;

  String? validateUsername(String Username) {
    if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(Username)) {
      return 'Username must not contain special characters or numbers';
    }
    if (Username.isEmpty) {
      return 'username cannot be empty';
    }
    return null;
  }

  String? validatePassword(String Password) {
    if (Password.length < 6) {
      return 'password must be at least 6 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(Password)) {
      return 'password must be at least one uppercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(Password)) {
      return 'password must be at least one number';
    }
    if (Password.isEmpty) {
      return 'password cannot be empty';
    }
    return null;
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                const Color.fromARGB(255, 15, 29, 51),
                const Color.fromARGB(255, 127, 0, 0),
                const Color.fromARGB(255, 15, 29, 51),
                const Color.fromARGB(255, 127, 0, 0),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: UsernameController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: 'Username',
                  errorText: UsernameError,
                ),
                onChanged: (value) {
                  setState(() {
                    UsernameError = validateUsername(value);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: PasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Password',
                    errorText: PasswordError,
                    suffixIcon: IconButton(
                      icon: Icon(
                          color: Colors.white,
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )),
                onChanged: (value) {
                  setState(() {
                    PasswordError = validatePassword(value);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 148, 61, 61),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                onPressed: () {
                  setState(() {
                    PasswordError = validatePassword(PasswordController.text);
                  });
                  setState(() {
                    UsernameError = validateUsername(UsernameController.text);
                  });
                  if (PasswordError == null && UsernameError == null) {
                    savedata();
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 220, 205, 205),
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Donot have an account',
                  style: TextStyle(color: Colors.amber[100]),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 231, 228, 228)),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}