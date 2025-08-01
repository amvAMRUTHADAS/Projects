import 'package:empetz/loginpage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> senddata() async {
    final Url = Uri.parse(
      "http://192.168.1.35/Empetz/api/v1/user/registration",
    );
    final response = await http.post(
      Url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "firstName": nameController.text.trim(),
        "userName": usernameController.text.trim(),
        "phone": phoneNumberController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("datapost successfully");
      print(response.body);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('data send successfully')));
    } else {
      print(response.statusCode);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to send data")));
    }
  }

  String? nameError;
  String? usernameError;
  String? phoneNumberError;
  String? emailError;
  String? passwordError;
  String? validatedname(String name) {
    if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(name)) {
      return 'Username must not contain special characters or numbers';
    }
    if (name.isEmpty) {
      return 'name cannot be empty';
    }
    return null;
  }

  String? validateusername(String username) {
    if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(username)) {
      return 'Username must not contain special characters or numbers';
    }
    if (username.isEmpty) {
      return 'username cannot be empty';
    }
    return null;
  }

  String? validatepassword(String password) {
    if (password.length < 6) {
      return 'password must be at least 6 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'password must be at least one upercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'password must be at least one number';
    }
    return null;
  }

  String? validatePhoneNumber(String phoneNumber) {
    if (!RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
      return 'phone number must be exactly 10 digits';
    }
    return null;
  }

  String? validateEmail(String email) {
    if (email.length < 6) {
      return 'email must be at least 6 characters long';
    }

    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      return 'email must be at least one upercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(email)) {
      return 'email must be at least one number';
    }
    return null;
  }

  bool isChecked2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 900,
          width: 700,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: nameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Name',
                    errorText: nameError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      nameError = validatedname(value);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Username',
                    errorText: usernameError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      usernameError = validateusername(value);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: phoneNumberController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Phone Number',
                    errorText: phoneNumberError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      phoneNumberError = validatePhoneNumber(value);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: 'Email',
                    errorText: emailError,
                  ),
                  onChanged: (value) {
                    setState(() {
                      emailError = validateEmail(value);
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Password',
                      errorText: passwordError),
                  onChanged: (value) {
                    setState(() {
                      passwordError = validatepassword(value);
                    });
                  },
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked2,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked2 = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    'Keep me signed in ',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
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
                      passwordError = validatepassword(passwordController.text);
                    });
                    setState(() {
                      usernameError = validateusername(usernameController.text);
                    });
                    setState(() {
                      phoneNumberError =
                          validatePhoneNumber(phoneNumberController.text);
                    });
                    setState(() {
                      emailError = validateEmail(emailController.text);
                    });
                    setState(() {
                      nameError = validatedname(nameController.text);
                    });

                    if (passwordError == null &&
                        usernameError == null &&
                        phoneNumberError == null &&
                        emailError == null &&
                        nameError == null) {
                      senddata();



                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Register successsfully")));
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Register',
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
                    'alredy have an account',
                    style: TextStyle(color: Colors.amber[100]),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Loginpage()),
                        );
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                            color: Color.fromARGB(255, 215, 216, 233),
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
