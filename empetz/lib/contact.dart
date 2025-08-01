import 'package:flutter/material.dart';

class ContactPagState extends StatefulWidget {
  const ContactPagState({super.key});

  @override
  State<ContactPagState> createState() => _ContactPagStateState();
}

class _ContactPagStateState extends State<ContactPagState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 2, 24, 57),
        title: Text("contact us",style: TextStyle(color: Colors.white),),
      ),
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
          ],
        ),
      ),
      child: Column(
        
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 150,),
           Padding(
             padding: const EdgeInsets.only(left: 15,right: 15),
             child: Text("If you have any inquiries get in touch with us. we'll be happy to help you .",
             style: TextStyle(color: Colors.white,
             fontSize: 20
             ),
             ),
           ),
           SizedBox(height: 50,),
            Card(
              child: ListTile(
                
                
                title: Text("+19 8281798428",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 50,),
               Card(
              child: ListTile(
                
                
                title: Text("pkamruthadas@gmail.com",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              ),
            ),
               
             
SizedBox(height: 50,),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [

   IconButton(onPressed: (){}, icon: Icon(Icons.chat,color: Colors.white,size: 45,)),
   IconButton(onPressed: (){}, icon: Icon(Icons.padding,color: Colors.white,size: 45)),
   IconButton(onPressed: (){}, icon: Icon(Icons.dangerous,color: Colors.white,size: 45)),
  ],
)

                ],
              ),
            
          ),
      );
  
  }
}
