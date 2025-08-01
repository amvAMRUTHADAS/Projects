import 'dart:convert';
import 'package:empetz/petdetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pets extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  Pets({super.key, required this.categoryId, required this.categoryName});

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  List<dynamic> pets = [];
  String? _token;
  bool _isLoading = true;
  String _errorMessage = '';

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
      setState(() {
        _errorMessage = 'Token not found. Please authenticate.';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('auth_token');
    });
  }

  // This is the combined and refined function for fetching pet data.
  Future<void> fetchdata() async {
    if (_token == null || _token!.isEmpty) {
      setState(() {
        _errorMessage = 'Cannot fetch data: Token is missing.';
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Clear any previous error messages
    });

    try {
      final url = Uri.parse(
          'http://192.168.1.35/Empetz/api/v1/pet/catagory?categoryid=${widget.categoryId}&PageNumber=1&PageSize=1000');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          pets = data;
          _isLoading = false;
        });
      } else {
        // Handle non-200/201 status codes
        setState(() {
          _errorMessage = 'Failed to fetch pets: ${response.statusCode}';
          _isLoading = false;
        });
        // Optionally, show a SnackBar for specific error feedback
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to fetch pets: ${response.statusCode}')),
          );
        }
      }
    } catch (e) {
      // Handle network errors or other exceptions
      setState(() {
        _errorMessage = 'Error fetching data: $e';
        _isLoading = false;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ]),
          ),
        ),
        title: Text(widget.categoryName, // Use widget.categoryName here
            style:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : pets.isEmpty
                  ? const Center(child: Text('No pets found'))
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 8, // Horizontal space between items
                          mainAxisSpacing: 8, // Vertical space between items
                          childAspectRatio: 0.75, // Width/height ratio
                        ),
                        itemCount: pets.length,
                        itemBuilder: (context, index) {
                          final pet = pets[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Pet Image
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      // Pass the entire 'pet' object to Petdisply
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Petdisply(pet: pet),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: pet['imagePath'] != null
                                          ? Image.network(
                                              pet['imagePath'],
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const Center(
                                                      child: Icon(Icons.pets,
                                                          size: 50)),
                                            )
                                          : const Center(
                                              child: Icon(Icons.pets, size: 50)),
                                    ),
                                  ),
                                ),
                                // Pet Info
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Pet Name
                                      Text(
                                        pet['name'] ?? 'Unnamed Pet',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      // Age and Price Row
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Price
                                          Text(
                                            '\$${pet['price']?.toString() ?? '0.00'}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}