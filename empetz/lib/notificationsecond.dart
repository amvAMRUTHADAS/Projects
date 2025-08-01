import 'package:flutter/material.dart';

class Secondpage extends StatefulWidget {
  const Secondpage({super.key});

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
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
        title: Text('NOTIFICATIONS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
        Card(
           color: Color.fromARGB(210, 148, 28, 28),
            child: ListTile(
              leading:
              CircleAvatar( radius: 20,
              backgroundImage: AssetImage('image/notification.jpg'),
              ),
               
              title: Text('Adhi',style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text('Hi',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
              trailing: Text('9:00pm',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
            ),
            
          ),
          Card(
            color: Color.fromARGB(210, 148, 28, 28),
             child: ListTile(
                leading:
                CircleAvatar( radius: 20,
                backgroundImage: AssetImage('image/notification.jpg'),
                ),
                 
                title: Text('Aarav',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Hi',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                trailing: Text('9:15pm',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
              ),
           ),
            Card(
               color: Color.fromARGB(210, 148, 28, 28),
              child: ListTile(
                leading:
                CircleAvatar( radius: 20,
                backgroundImage: AssetImage('image/notification.jpg'),
                ),
                 
                title: Text('Neethu',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Hi',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                trailing: Text('9:34pm',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
              ),
            ),
             Card(
              color: Color.fromARGB(210, 148, 28, 28),
               child: ListTile(
                leading:
                CircleAvatar( radius: 20,
                backgroundImage: AssetImage('image/notification.jpg'),
                ),
                 
                title: Text('shiv',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Hi',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                trailing: Text('9:40pm',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                           ),
             ),
             Card(
                color: Color.fromARGB(210, 148, 28, 28),
               child: ListTile(
                leading:
                CircleAvatar( radius: 20,
                backgroundImage: AssetImage('image/notification.jpg')
                ),
                 
                title: Text('Neel',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Hi',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                trailing: Text('10:00pm',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                           ),
             ),
             Card(
               color: Color.fromARGB(210, 148, 28, 28),
               child: ListTile(
                leading:
                CircleAvatar( radius: 20,
                backgroundImage: AssetImage('image/notification.jpg'),
                ),
                 
                title: Text('ithal',style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Hi',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                trailing: Text('10:30pm',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.black),),
                           ),
             ),
        ],
        
      ),
      
      
    );
  }
}
