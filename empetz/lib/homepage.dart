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
  List<dynamic> categories = [];
  List<dynamic> petDetails = [];
  String? _token;
  String? _username; // Added to store the username

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserDataAndFetchData(); // Renamed to reflect username loading
  }

  Future<void> _loadUserDataAndFetchData() async {
    setState(() {
      _isLoading = true;
    });
    await _loadTokenAndUsername(); // Load both token and username
    if (_token != null && _token!.isNotEmpty) {
      await fetchdata();
      await PetDetails();
    } else {
      print('Token not found. Please authenticate.');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token missing. Please log in.')),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadTokenAndUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token');
      _username = prefs.getString('username'); // Retrieve the username
    });
  }

  Future<void> fetchdata() async {
    if (_token == null || _token!.isEmpty) {
      print('Cannot fetch data: Token is missing.');
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.35/Empetz/api/v1/category'),
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
        print('Response body: ${response.body}');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load categories: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching categories: $e')),
        );
      }
    }
  }

  Future<void> PetDetails() async {
    if (_token == null || _token!.isEmpty) {
      print('Cannot fetch data: Token is missing.');
      return;
    }
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.35/Empetz/api/v1/user-posted-history'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          petDetails = json.decode(response.body);
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load pet details: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching pet details: $e')),
        );
      }
    }
  }

  Future<void> _deletePet(String petId) async {
    if (_token == null || _token!.isEmpty) {
      print('Cannot delete pet: Token is missing.');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Authentication token missing. Cannot delete pet.')),
        );
      }
      return;
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deleting pet...')),
      );
    }
    try {
      final response = await http.delete(
        Uri.parse('http://192.168.1.35/Empetz/api/v1/pet/$petId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Pet deleted successfully!');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pet deleted successfully!')),
          );
        }
        setState(() {
          petDetails.removeWhere((pet) => pet['id'].toString() == petId);
        });
      } else {
        print('Failed to delete pet: ${response.statusCode}');
        print('Response body: ${response.body}');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete pet: ${response.body}')),
          );
        }
      }
    } catch (e) {
      print('Error deleting pet: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting pet: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 15, 29, 51),
                  Color.fromARGB(255, 127, 0, 0),
                  Color.fromARGB(255, 15, 29, 51),
                  Color.fromARGB(255, 127, 0, 0),
                ],
              ),
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
              icon: const Icon(
                Icons.notification_add,
                color: Colors.white,
              ),
            ),
          ],
          bottom: const TabBar(tabs: [
            Text(
              'BUYER',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'SELLER',
              style: TextStyle(color: Colors.white),
            ),
          ]),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 15, 29, 51),
                      Color.fromARGB(255, 127, 0, 0),
                      Color.fromARGB(255, 15, 29, 51),
                      Color.fromARGB(255, 127, 0, 0),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('image/th.jpg'),
                    ),
                    Text(
                      _username ?? 'Guest', // Display the username or 'Guest' if null
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
                title: const Text(
                  'account',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Accountpage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
                title: const Text(
                  'favorite',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favoritepage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.question_mark_outlined,
                  color: Colors.black,
                ),
                title: const Text(
                  'about',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Aboutpage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.contacts,
                  color: Colors.black,
                ),
                title: const Text(
                  'contact us',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactPagState()),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // BUYER TAB
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : categories.isNotEmpty
                    ? GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Pets(
                                    categoryId: categories[index]['id'].toString(),
                                    categoryName: categories[index]['name'],
                                  ),
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
                      )
                    : const Center(
                        child: Text(
                          'No categories available.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
            // SELLER TAB - Modified to show pet details and allow deletion
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        // Pet Details List
                        petDetails.isNotEmpty
                            ? ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: petDetails.length,
                                itemBuilder: (context, index) {
                                  final pet = petDetails[index];
                                  return Card(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        children: [
                                          // Circular Avatar for Pet Image
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage: pet['image'] != null
                                                ? MemoryImage(base64Decode(pet['image']))
                                                : null,
                                            child: pet['image'] == null
                                                ? const Icon(Icons.pets, color: Colors.white)
                                                : null,
                                            backgroundColor: pet['image'] == null ? Colors.grey[400] : null,
                                          ),
                                          const SizedBox(width: 16),
                                          // Pet Details
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                // Pet Name
                                                Text(
                                                  pet['name'] ?? 'Pet Name',
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                // Pet Price
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(255, 127, 0, 0),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Text(
                                                    '₹${pet['price'] ?? '0'}',
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                // Additional pet info if available (e.g., breed)
                                                if (pet['breed'] != null)
                                                  Text(
                                                    'Breed: ${pet['breed']}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          // Delete Icon Button
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              if (pet['id'] != null) {
                                                _deletePet(pet['id'].toString());
                                              } else {
                                                print('Pet ID is missing, cannot delete.');
                                                if (mounted) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('Cannot delete: Pet ID is missing.')),
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.pets,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No pets added yet',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        // Floating Action Button
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: FloatingActionButton(
                            onPressed: () async {
                              final bool? result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Addpetdetails(),
                                ),
                              );
                              if (result == true) {
                                await PetDetails();
                              }
                            },
                            backgroundColor: const Color.fromARGB(255, 127, 0, 0),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}