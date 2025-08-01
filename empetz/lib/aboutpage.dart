import 'package:flutter/material.dart';

class Aboutpage extends StatefulWidget {
  const Aboutpage({super.key});

  @override
  State<Aboutpage> createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
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
        ),
        title: Text('About',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        ),
    );
  }
}