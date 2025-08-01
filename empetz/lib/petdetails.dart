import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Petdisply extends StatefulWidget {
  final Map<String, dynamic> pet;

  const Petdisply({super.key, required this.pet});

  @override
  State<Petdisply> createState() => _PetdisplyState();
}

class _PetdisplyState extends State<Petdisply> with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _userDetails;
  bool _isLoading = false;
  String? _errorMessage;
  late SharedPreferences sp;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _initializeSharedPreferences();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    await _fetchUserDetails();
    _animationController.forward();
  }

  Future<void> _fetchUserDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      String? token = sp.getString('auth_token');
      if (token == null) {
        _setErrorMessage('Token not found. Please log in.');
        return;
      }

      final url = Uri.parse('http://192.168.1.35/Empetz/user/${widget.pet['userId']}');
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _userDetails = jsonDecode(response.body);
          _isLoading = false;
        });
        if (_userDetails?['phone'] != null && _userDetails?['phone'].isNotEmpty) {
          _saveContact();
        }
      } else {
        _setErrorMessage('Failed to fetch user details: ${response.statusCode}');
      }
    } catch (e) {
      _setErrorMessage('An error occurred: $e');
    }
  }

  void _setErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
      _isLoading = false;
    });
  }

  Future<void> _saveContact() async {
    List<String> contacts = sp.getStringList('myData') ?? [];
    String newContact = '${_userDetails?['firstName'] ?? 'Unknown'}:${_userDetails?['phone'] ?? ''}';
    if (!contacts.contains(newContact)) {
      contacts.add(newContact);
      await sp.setStringList('myData', contacts);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneLaunchUri = Uri(scheme: 'tel', path: phone);
    if (!await launchUrl(phoneLaunchUri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $phoneLaunchUri')),
        );
      }
    }
  }

  Widget _buildDetailRow(IconData icon, String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey.shade600)),
                Text(value?.toString() ?? 'N/A', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pet = widget.pet;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'pet-${pet['id'] ?? 'unknown'}',
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                      child: pet['imagePath'] != null && pet['imagePath'].isNotEmpty
                          ? Image.network(pet['imagePath'], fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Center(child: Icon(Icons.broken_image, size: 80, color: Colors.grey.shade400)))
                          : Center(child: Icon(Icons.pets, size: 100, color: Colors.grey.shade400)),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(pet['name'] ?? 'Pet Name', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 8),
                      Text(pet['discription'] ?? 'No description available', style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.5)),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Pet Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                            const SizedBox(height: 16),
                            _buildDetailRow(Icons.pets, "Breed", pet['breedName']),
                            _buildDetailRow(Icons.cake, "Age", pet['age']),
                            _buildDetailRow(Icons.male, "Gender", pet['gender']),
                            _buildDetailRow(Icons.scale, "Weight", pet['weight']),
                            _buildDetailRow(Icons.height, "Height", pet['height']),
                            _buildDetailRow(Icons.attach_money, "Price", "₹${pet['price']}"),
                            _buildDetailRow(Icons.place, "Location", pet['locationName']),
                            _buildDetailRow(Icons.home, "Address", pet['address']),
                          ].expand((widget) => [widget, const Divider(color: Colors.grey, thickness: 0.2)]).toList()..removeLast(),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Contact Seller", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
                            const SizedBox(height: 16),
                            if (_isLoading)
                              const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.blue))))
                            else if (_errorMessage != null)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.red.shade200)),
                                child: Row(
                                  children: [
                                    Icon(Icons.error_outline, color: Colors.red.shade400, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text(_errorMessage!, style: TextStyle(color: Colors.red.shade700))),
                                  ],
                                ),
                              )
                            else if (_userDetails != null) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.person, color: Colors.grey.shade700, size: 20),
                                            const SizedBox(width: 10),
                                            Text(
                                              _userDetails!['firstName'] ?? 'Unknown Seller',
                                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.email, color: Colors.grey.shade700, size: 20),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                _userDetails!['email'] ?? 'No Email Provided',
                                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.call, color: Colors.blue, size: 28),
                                    onPressed: (_userDetails!['phone'] != null && _userDetails!['phone'].isNotEmpty)
                                        ? () => _launchPhone(_userDetails!['phone']!)
                                        : null,
                                    tooltip: 'Call Seller',
                                  ),
                                ],
                              ),
                            ] else
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey.shade200)),
                                child: Row(
                                  children: [
                                    Icon(Icons.info_outline, color: Colors.grey.shade600, size: 20),
                                    const SizedBox(width: 12),
                                    Expanded(child: Text('Seller details not available.', style: TextStyle(color: Colors.grey.shade700))),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
