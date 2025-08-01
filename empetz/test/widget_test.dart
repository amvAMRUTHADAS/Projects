// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:empetz/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }








import 'dart:convert';

import 'package:empetz/aboutpage.dart';
import 'package:empetz/accountpage.dart';
import 'package:empetz/addpet.dart';
import 'package:empetz/contact.dart';
import 'package:empetz/favoritepage.dart';
import 'package:empetz/notificationsecond.dart';
import 'package:empetz/pets1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   final TextEditingController imagePathController = TextEditingController();

  final List<String> items = List.generate(20, (index) => "Item $index");
  List<dynamic> categories = []; // Changed 'user' to 'categories' for clarity
  String? _token;
  
  
  

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchData();
  }

  Future<void> _loadTokenAndFetchData() async {
    await _loadToken();
    if (_token != null && _token!.isNotEmpty) {
      await fetchdata();
    } else {
      print('Token not found. Please authenticate.');
      // Optionally navigate to the login screen
    }
  }

  Future<void> _loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token'); // Replace 'authToken' with your key
    });
  }

  Future<void> fetchdata() async {
    if (_token == null || _token!.isEmpty) {
      print('Cannot fetch data: Token is missing.');
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.28/Empetz/api/v1/category'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          categories = json.decode(response.body);
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}'); // Log the response body for debugging
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
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
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Secondpage()),
                  );
                  
                },
                icon: Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ),
              ),
            ],
            bottom: TabBar(tabs: [
              Text(
                'BUYER',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'SELLER',
                style: TextStyle(color: Colors.white),
              ),
            ]),
            title: Text(
              'Home',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
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
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('image/profille.jpg'),
                      ),
                      Text(
                        'Aswathy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      )
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                  title: Text(
                    'account',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Accountpage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  title: Text(
                    'favorite',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Favoritepage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.question_mark_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    'about',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Aboutpage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.contacts,
                    color: Colors.black,
                  ),
                  title: Text(
                    'contact us',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactPagState()));
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(children: [
           GestureDetector(
             child:GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemCount: categories.length,
  itemBuilder: (context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Pets( categoryId: categories[index]['id'],categoryName:categories[index]['name']),
          ),
        );
      },
      child: Card(
        child: Image.network(
          categories[index]['imagePath'],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported);
          },
        ),
      ),
    );
  },
),


           ),
            Container(
              color: Colors.white,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 500.0, left: 270),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Addpetdetails()));
                    },
                    backgroundColor: const Color.fromARGB(255, 5, 36, 62),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
