// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// // You might need to define your Addpetapi class or replace baseUrl directly.
// // For this example, I'm assuming Addpetapi.baseUrl is defined elsewhere.
// class Addpetapi {
//   static const String baseUrl = 'http://192.168.1.33/Empetz/api/v1/pet'; // Replace with your actual base URL
// }


// class Addpetdetails extends StatefulWidget {
//   Addpetdetails({super.key});

//   @override
//   State<Addpetdetails> createState() => _AddpetdetailsState();
// }

// class _AddpetdetailsState extends State<Addpetdetails> {
//   String? selectedCategoryId; // Stores the ID of the selected category
//   List<dynamic> petsname = []; // Stores categories (e.g., Dog, Cat)
//   List<dynamic> breedsForSelectedCategory =
//       []; // Stores breeds for the selected category
//   List<dynamic> locations = []; // Stores locations fetched from the backend

//   File? _image;
//   final picker = ImagePicker();

//   // Loading states
//   bool _isLoadingBreeds = false;
//   bool _isLoadingLocations = false; // Loading state for locations

//   // Text controllers
//   final TextEditingController NicknameController = TextEditingController();
//   final TextEditingController WeightController = TextEditingController();
//   final TextEditingController vaccinatedController = TextEditingController(); // This field seems unused for a boolean 'Vaccinated'
//   final TextEditingController AdressController = TextEditingController();
//   final TextEditingController DescriptionController = TextEditingController();
//   final TextEditingController PriceController = TextEditingController();
//   final TextEditingController ageController = TextEditingController();
//   final TextEditingController heightController = TextEditingController();

//   String? NicknameError;
//   String? heightError;
//   String? WeightError;
//   String? ageError;
//   String? vaccinatedError; // This error seems unused for a boolean 'Vaccinated'
//   String? AdressError;
//   String? DescriptionError;
//   String? PriceError;
//   String? _token;

//   String? _selectedBreedName;
//   String? _selectedgender;
//   String? _selectedLocationName; // Stores the name of the selected location

//   // Add these for storing IDs from dropdowns
//   String? _selectedBreedId;
//   String? _selectedLocationId;

//   List<String> _genderOptions = [
//     'Male',
//     'Female',
//     'Other'
//   ]; // Renamed for clarity from _locations1

//   @override
//   void initState() {
//     super.initState();
//     _loadTokenAndFetchData();
//   }

//   // --- Image Picker Function ---
//   Future<void> getImageGallery() async {
//     final pickedFile =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print("No image Picked");
//       }
//     });
//   }

//   // --- SnackBar Function (from the first snippet) ---
//   void showSnack(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   // --- Fetch Category Function (renamed and adjusted for existing petsname list) ---
//   Future<void> fetchCategory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     if (token == null) {
//       showSnack('Token not found! Please login again.');
//       return;
//     }

//     final url = Uri.parse('${Addpetapi.baseUrl}/category');
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() => petsname = data); // Use petsname instead of categoryList
//       } else {
//         print('Failed to load categories: ${response.statusCode}');
//         showSnack('Failed to load categories!');
//       }
//     } catch (e) {
//       print('Error fetching categories: $e');
//       showSnack('Something went wrong while fetching categories!');
//     }
//   }

//   // --- Fetch Breeds By Category ID Function (adjusted for existing breedsForSelectedCategory list) ---
//   Future<void> fetchBreedsByCategoryId(String categoryId) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     if (token == null) {
//       showSnack('Token not found! Please login again.');
//       return;
//     }

//     setState(() {
//       _isLoadingBreeds = true;
//       breedsForSelectedCategory = []; // Clear previous breeds
//       _selectedBreedName = null; // Reset selected breed
//       _selectedBreedId = null; // Reset selected breed ID
//     });

//     final url = Uri.parse('${Addpetapi.baseUrl}/breed/category/$categoryId');
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           breedsForSelectedCategory = data;
//           _isLoadingBreeds = false;
//         });
//       } else {
//         print('Failed to load breeds: ${response.statusCode}');
//         showSnack('Failed to load breeds!');
//         setState(() {
//           _isLoadingBreeds = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching breeds: $e');
//       showSnack('Something went wrong while fetching breeds!');
//       setState(() {
//         _isLoadingBreeds = false;
//       });
//     }
//   }

//   // --- Fetch Locations Function (adjusted for existing locations list) ---
//   Future<void> fetchLocations() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     if (token == null) {
//       showSnack('Token not found! Please login again.');
//       return;
//     }

//     setState(() {
//       _isLoadingLocations = true;
//     });

//     final url = Uri.parse('${Addpetapi.baseUrl}/location');
//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         setState(() {
//           locations = data;
//           _isLoadingLocations = false;
//         });
//       } else {
//         print('Failed to load locations: ${response.statusCode}');
//         showSnack('Failed to load locations!');
//         setState(() {
//           _isLoadingLocations = false;
//         });
//       }
//     } catch (e) {
//       print('Error fetching locations: $e');
//       showSnack('Something went wrong while fetching locations!');
//       setState(() {
//         _isLoadingLocations = false;
//       });
//     }
//   }

//   // --- Send Pet Data Function (MultipartRequest for image upload) ---
// Future<void> sendPetData() async {
//   // --- Input Validation ---
//   if (_image == null) {
//     showSnack('Please pick an image for the pet.');
//     return;
//   }

//   final fields = [
//     NicknameController.text, ageController.text, DescriptionController.text,
//     AdressController.text, PriceController.text, heightController.text,
//     WeightController.text
//   ];
//   final dropdowns = [
//     _selectedgender, selectedCategoryId, _selectedBreedId, _selectedLocationId
//   ];

//   if (fields.any((field) => field.trim().isEmpty) || dropdowns.any((dropdown) => dropdown == null)) {
//     showSnack('Please fill all required fields and make selections.');
//     return;
//   }

//   // --- Authentication ---
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('auth_token');
//   if (token == null) {
//     showSnack('Token not found! Please login again.');
//     return;
//   }

//   // --- API Request Setup ---
//   final url = Uri.parse('${Addpetapi.baseUrl}/pet');
//   final request = http.MultipartRequest('POST', url)
//     ..headers['Authorization'] = 'Bearer $token'
//     ..fields['Gender'] = _selectedgender!
//     ..fields['Vaccinated'] = 'false' // Or from a checkbox
//     ..fields['height'] = heightController.text.trim()
//     ..fields['Price'] = PriceController.text.trim()
//     ..fields['Name'] = NicknameController.text.trim()
//     ..fields['BreedId'] = _selectedBreedId!
//     ..fields['weight'] = WeightController.text.trim()
//     ..fields['CategoryId'] = selectedCategoryId!
//     ..fields['Age'] = ageController.text.trim()
//     ..fields['LocationId'] = _selectedLocationId!
//     ..fields['Address'] = AdressController.text.trim()
//     ..fields['Discription'] = DescriptionController.text.trim()
//     ..fields['Certified'] = 'false'; // Or from a checkbox

//   request.files.add(await http.MultipartFile.fromPath('ImageFile', _image!.path));

//   // --- Send Request and Handle Response ---
//   try {
//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       showSnack('Pet data submitted successfully!');
//       _clearFormFields(); // Call a dedicated method to clear fields
//     } else {
//       print('Failed with status: ${response.statusCode}\nResponse: ${response.body}');
//       showSnack('Failed to submit data! Status: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//     showSnack('Something went wrong during submission!');
//   }
// }

// // Consider extracting field clearing into a separate method
// void _clearFormFields() {
//   NicknameController.clear();
//   WeightController.clear();
//   // vaccinatedController.clear(); // Only if it's a TextEditingController
//   AdressController.clear();
//   DescriptionController.clear();
//   PriceController.clear();
//   ageController.clear();
//   heightController.clear();
//   setState(() {
//     _image = null;
//     selectedCategoryId = null;
//     _selectedBreedName = null;
//     _selectedBreedId = null;
//     _selectedgender = null;
//     _selectedLocationName = null;
//     _selectedLocationId = null;
//     breedsForSelectedCategory = [];
//   });
// }


//   Future<void> _loadTokenAndFetchData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     _token = prefs.getString('auth_token');

//     if (_token != null && _token!.isNotEmpty) {
//       await fetchCategory(); // Fetch categories
//       await fetchLocations(); // Fetch locations
//     } else {
//       print('Auth token not found or is empty.');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Authentication token missing. Please log in.')),
//       );
//     }
//   }

//   // Validation functions (keep these as they are)
//   String? validatedNickname(String nickname) {
//     if (nickname.isEmpty) {
//       return 'Nickname cannot be empty';
//     }
//     if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(nickname)) {
//       return 'Nickname must not contain special characters or numbers';
//     }
//     return null;
//   }

//   String? validatedAge(String age) {
//     if (age.isEmpty) {
//       return 'Age cannot be empty';
//     }
//     if (!RegExp(r'^\d+$').hasMatch(age)) {
//       return 'Age must be a number';
//     }
//     return null;
//   }

//   String? validatedHeight(String height) {
//     if (height.isEmpty) {
//       return 'Height cannot be empty';
//     }
//     if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(height)) {
//       return 'Height must be a valid number';
//     }
//     return null;
//   }

//   String? validatedWeight(String weight) {
//     if (weight.isEmpty) {
//       return 'Weight cannot be empty';
//     }
//     if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(weight)) {
//       return 'Weight must be a valid number';
//     }
//     return null;
//   }

//   String? validatedVaccinated(String vaccinated) {
//     if (vaccinated.isEmpty) {
//       return 'Vaccinated date cannot be empty';
//     }
//     return null;
//   }

//   String? validatedAddress(String address) {
//     if (address.isEmpty) {
//       return 'Address cannot be empty';
//     }
//     return null;
//   }

//   String? validatedDescription(String description) {
//     if (description.isEmpty) {
//       return 'Description cannot be empty';
//     }
//     return null;
//   }

//   String? validatedPrice(String price) {
//     if (price.isEmpty) {
//       return 'Price cannot be empty';
//     }
//     if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(price)) {
//       return 'Price must be a valid number';
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         backgroundColor: const Color.fromARGB(255, 127, 0, 0),
//         centerTitle: true,
//         title: const Text(
//           'Add Pet Details',
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           // --- Image Picker ---
//           InkWell(
//             onTap: () {
//               getImageGallery();
//             },
//             child: Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(12.0),
//                 color: Colors.grey[100],
//               ),
//               child: _image != null
//                   ? ClipRRect(
//                       borderRadius: BorderRadius.circular(12.0),
//                       child: Image.file(
//                         _image!.absolute,
//                         fit: BoxFit.cover,
//                       ),
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.add_photo_alternate_outlined,
//                           size: 40,
//                           color: Colors.grey[600],
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Tap to add pet photo',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//           const SizedBox(height: 24),

//           // --- Nickname Text Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: TextField(
//                 controller: NicknameController,
//                 decoration: InputDecoration(
//                   labelText: 'Nick Name',
//                   errorText: NicknameError,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     NicknameError = validatedNickname(value);
//                   });
//                 },
//               ),
//             ),
//           ),

//           // --- Category Dropdown ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 hint: const Text('Select Category'),
//                 value: selectedCategoryId != null
//                     ? petsname.firstWhere(
//                         (category) => category['id'] == selectedCategoryId,
//                         orElse: () => {'name': null})['name']
//                     : null,
//                 onChanged: (newValue) {
//                   setState(() {
//                     final selectedCategoryObject = petsname.firstWhere(
//                         (category) => category['name'] == newValue,
//                         orElse: () => null);

//                     if (selectedCategoryObject != null) {
//                       selectedCategoryId = selectedCategoryObject['id'];
//                       fetchBreedsByCategoryId(
//                           selectedCategoryId!); // Fetch breeds when category changes
//                     } else {
//                       selectedCategoryId = null;
//                       breedsForSelectedCategory =
//                           []; // Clear breeds if no category selected
//                       _selectedBreedName = null; // Clear selected breed
//                       _selectedBreedId = null; // Clear selected breed ID
//                     }
//                   });
//                 },
//                 items: petsname.map<DropdownMenuItem<String>>((category) {
//                   return DropdownMenuItem<String>(
//                     value: category['name'], // Use name for display in dropdown
//                     child: Row(
//                       children: [
//                         // Display image if available
//                         if (category['imagePath'] != null && category['imagePath'].isNotEmpty)
//                           Image.network(
//                             category['imagePath'],
//                             width: 30,
//                             height: 30,
//                             errorBuilder: (context, error, stackTrace) =>
//                                 const Icon(Icons.image_not_supported, size: 30),
//                           ),
//                         const SizedBox(width: 10),
//                         Text(category['name']),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),

//           // --- Breed Dropdown ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: _isLoadingBreeds
//                   ? const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(child: CircularProgressIndicator()),
//                     )
//                   : DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide.none,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                       ),
//                       hint: const Text('Select Breed'),
//                       value: _selectedBreedName, // Use the selected breed name
//                       onChanged: (newValue) {
//                         setState(() {
//                           _selectedBreedName = newValue;
//                           // Find the corresponding ID for the selected breed
//                           final selectedBreedObject = breedsForSelectedCategory.firstWhere(
//                                   (breed) => breed['name'] == newValue,
//                                   orElse: () => null);
//                           if (selectedBreedObject != null) {
//                             _selectedBreedId = selectedBreedObject['id'];
//                           } else {
//                             _selectedBreedId = null;
//                           }
//                         });
//                       },
//                       items: breedsForSelectedCategory
//                           .map<DropdownMenuItem<String>>((breed) {
//                         return DropdownMenuItem<String>(
//                           value: breed[
//                               'name'], // Assuming breed object has a 'name' field
//                           child: Text(breed['name']),
//                         );
//                       }).toList(),
//                     ),
//             ),
//           ),

//           // --- Location Dropdown ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: _isLoadingLocations
//                   ? const Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Center(child: CircularProgressIndicator()),
//                     )
//                   : DropdownButtonFormField<String>(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12.0),
//                           borderSide: BorderSide.none,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 12),
//                       ),
//                       hint: const Text('Select Location'),
//                       value: _selectedLocationName,
//                       onChanged: (newValue) {
//                         setState(() {
//                           _selectedLocationName = newValue;
//                           // Find the corresponding ID for the selected location
//                           final selectedLocationObject = locations.firstWhere(
//                                   (location) => location['name'] == newValue,
//                                   orElse: () => null);
//                           if (selectedLocationObject != null) {
//                             _selectedLocationId = selectedLocationObject['id'];
//                           } else {
//                             _selectedLocationId = null;
//                           }
//                         });
//                       },
//                       items: locations.map<DropdownMenuItem<String>>((location) {
//                         return DropdownMenuItem<String>(
//                           value: location['name'],
//                           child: Text(location['name']),
//                         );
//                       }).toList(),
//                     ),
//             ),
//           ),

//           // --- Age Text Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: TextField(
//                 keyboardType: TextInputType.number,
//                 controller: ageController,
//                 decoration: InputDecoration(
//                   labelText: 'Age',
//                   errorText: ageError,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 onChanged: (value) =>
//                     setState(() => ageError = validatedAge(value)),
//               ),
//             ),
//           ),

//           // --- Height Text Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: TextField(
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 controller: heightController,
//                 decoration: InputDecoration(
//                   labelText: 'Height',
//                   errorText: heightError,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 onChanged: (value) =>
//                     setState(() => heightError = validatedHeight(value)),
//               ),
//             ),
//           ),

//           // --- Weight Text Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: TextField(
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 controller: WeightController,
//                 decoration: InputDecoration(
//                   labelText: 'Weight',
//                   errorText: WeightError,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 onChanged: (value) =>
//                     setState(() => WeightError = validatedWeight(value)),
//               ),
//             ),
//           ),

//           // --- Description Text Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: TextField(
//                 controller: DescriptionController,
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   labelText: 'Description',
//                   errorText: DescriptionError,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 onChanged: (value) =>
//                     setState(() => DescriptionError = validatedDescription(value)),
//               ),
//             ),
//           ),

//           // --- Address Text Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: TextField(
//                 controller: AdressController,
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   labelText: 'Address',
//                   errorText: AdressError,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 onChanged: (value) =>
//                     setState(() => AdressError = validatedAddress(value)),
//               ),
//             ),
//           ),

//           // --- Price Text Field ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: TextField(
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 controller: PriceController,
//                 decoration: InputDecoration(
//                   labelText: 'Price',
//                   errorText: PriceError,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 onChanged: (value) =>
//                     setState(() => PriceError = validatedPrice(value)),
//               ),
//             ),
//           ),

//           // --- Gender Dropdown ---
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Material(
//               elevation: 2.0,
//               borderRadius: BorderRadius.circular(12.0),
//               child: DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                     borderSide: BorderSide.none,
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 ),
//                 hint: const Text('Select Gender'),
//                 value: _selectedgender,
//                 onChanged: (newValue) =>
//                     setState(() => _selectedgender = newValue),
//                 items: _genderOptions.map((gender) {
//                   return DropdownMenuItem<String>(
//                       value: gender, child: Text(gender));
//                 }).toList(),
//               ),
//             ),
//           ),

//           const SizedBox(height: 24),

//           // --- Submit Button ---
//           ElevatedButton(
//             onPressed: sendPetData, // Call the new sendPetData function
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color.fromARGB(255, 127, 0, 0),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//             ),
//             child: const Text(
//               'Add Pet',
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// You might need to define your Addpetapi class or replace baseUrl directly.
// For this example, I'm assuming Addpetapi.baseUrl is defined elsewhere.
class Addpetapi {
  static const String baseUrl = 'http://192.168.1.35/Empetz/api/v1'; // Corrected base URL to be more general
}


class Addpetdetails extends StatefulWidget {
  Addpetdetails({super.key});

  @override
  State<Addpetdetails> createState() => _AddpetdetailsState();
}

class _AddpetdetailsState extends State<Addpetdetails> {
  // Now these store the NAME of the selected item for display
  String? _selectedCategoryName;
  String? _selectedBreedName;
  String? _selectedLocationName;

  // These store the ID of the selected item for API submission
  String? _selectedCategoryId;
  String? _selectedBreedId;
  String? _selectedLocationId;

  List<dynamic> categories = []; // Renamed from petsname for clarity
  List<dynamic> breedsForSelectedCategory = [];
  List<dynamic> locations = [];

  File? _image;
  final picker = ImagePicker();

  // Loading states
  bool _isLoadingBreeds = false;
  bool _isLoadingLocations = false;

  // Text controllers
  final TextEditingController NicknameController = TextEditingController();
  final TextEditingController WeightController = TextEditingController();
  final TextEditingController vaccinatedController = TextEditingController();
  final TextEditingController AdressController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  final TextEditingController PriceController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? NicknameError;
  String? heightError;
  String? WeightError;
  String? ageError;
  String? vaccinatedError;
  String? AdressError;
  String? DescriptionError;
  String? PriceError;
  String? _token;

  String? _selectedgender;

  List<String> _genderOptions = [
    'Male',
    'Female',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchData();
  }

  // --- Image Picker Function ---
  Future<void> getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Picked");
      }
    });
  }

  // --- SnackBar Function ---
  void showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // --- Fetch Category Function ---
  Future<void> fetchCategory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      showSnack('Token not found! Please login again.');
      return;
    }

    final url = Uri.parse('${Addpetapi.baseUrl}/category');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() => categories = data); // Use 'categories'
      } else {
        print('Failed to load categories: ${response.statusCode}');
        showSnack('Failed to load categories!');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      showSnack('Something went wrong while fetching categories!');
    }
  }

  // --- Fetch Breeds By Category ID Function ---
  Future<void> fetchBreedsByCategoryId(String categoryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      showSnack('Token not found! Please login again.');
      return;
    }

    setState(() {
      _isLoadingBreeds = true;
      breedsForSelectedCategory = []; // Clear previous breeds
      _selectedBreedName = null; // Reset selected breed name for display
      _selectedBreedId = null; // Reset selected breed ID for API
    });

    final url = Uri.parse('${Addpetapi.baseUrl}/breed/category/$categoryId');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          breedsForSelectedCategory = data;
          _isLoadingBreeds = false;
        });
      } else {
        print('Failed to load breeds: ${response.statusCode}');
        showSnack('Failed to load breeds!');
        setState(() {
          _isLoadingBreeds = false;
        });
      }
    } catch (e) {
      print('Error fetching breeds: $e');
      showSnack('Something went wrong while fetching breeds!');
      setState(() {
        _isLoadingBreeds = false;
      });
    }
  }

  // --- Fetch Locations Function ---
  Future<void> fetchLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      showSnack('Token not found! Please login again.');
      return;
    }

    setState(() {
      _isLoadingLocations = true;
    });

    final url = Uri.parse('${Addpetapi.baseUrl}/location');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          locations = data;
          _isLoadingLocations = false;
        });
      } else {
        print('Failed to load locations: ${response.statusCode}');
        showSnack('Failed to load locations!');
        setState(() {
          _isLoadingLocations = false;
        });
      }
    } catch (e) {
      print('Error fetching locations: $e');
      showSnack('Something went wrong while fetching locations!');
      setState(() {
        _isLoadingLocations = false;
      });
    }
  }

  // --- Send Pet Data Function (MultipartRequest for image upload) ---
  Future<void> sendPetData() async {
    // --- Input Validation ---
    if (_image == null) {
      showSnack('Please pick an image for the pet.');
      return;
    }

    final fields = [
      NicknameController.text, ageController.text, DescriptionController.text,
      AdressController.text, PriceController.text, heightController.text,
      WeightController.text
    ];
    final dropdowns = [
      _selectedgender, _selectedCategoryId, _selectedBreedId, _selectedLocationId
    ];

    if (fields.any((field) => field.trim().isEmpty) || dropdowns.any((dropdown) => dropdown == null)) {
      showSnack('Please fill all required fields and make selections.');
      return;
    }

    // --- Authentication ---
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      showSnack('Token not found! Please login again.');
      return;
    }

    // --- API Request Setup ---
    final url = Uri.parse('${Addpetapi.baseUrl}/pet');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..fields['Gender'] = _selectedgender!
      ..fields['Vaccinated'] = 'false' // Or from a checkbox
      ..fields['height'] = heightController.text.trim()
      ..fields['Price'] = PriceController.text.trim()
      ..fields['Name'] = NicknameController.text.trim()
      ..fields['BreedId'] = _selectedBreedId!
      ..fields['weight'] = WeightController.text.trim()
      ..fields['CategoryId'] = _selectedCategoryId! // Use the ID here
      ..fields['Age'] = ageController.text.trim()
      ..fields['LocationId'] = _selectedLocationId!
      ..fields['Address'] = AdressController.text.trim()
      ..fields['Discription'] = DescriptionController.text.trim()
      ..fields['Certified'] = 'false'; // Or from a checkbox

    request.files.add(await http.MultipartFile.fromPath('ImageFile', _image!.path));

    // --- Send Request and Handle Response ---
    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        showSnack('Pet data submitted successfully!');
        _clearFormFields();
      } else {
        print('Failed with status: ${response.statusCode}\nResponse: ${response.body}');
        showSnack('Failed to submit data! Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      showSnack('Something went wrong during submission!');
    }
  }

  // Consider extracting field clearing into a separate method
  void _clearFormFields() {
    NicknameController.clear();
    WeightController.clear();
    vaccinatedController.clear();
    AdressController.clear();
    DescriptionController.clear();
    PriceController.clear();
    ageController.clear();
    heightController.clear();
    setState(() {
      _image = null;
      _selectedCategoryName = null;
      _selectedCategoryId = null;
      _selectedBreedName = null;
      _selectedBreedId = null;
      _selectedgender = null;
      _selectedLocationName = null;
      _selectedLocationId = null;
      breedsForSelectedCategory = [];
    });
  }

  Future<void> _loadTokenAndFetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');

    if (_token != null && _token!.isNotEmpty) {
      await fetchCategory(); // Fetch categories
      await fetchLocations(); // Fetch locations
    } else {
      print('Auth token not found or is empty.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Authentication token missing. Please log in.')),
      );
    }
  }

  // Validation functions (keep these as they are)
  String? validatedNickname(String nickname) {
    if (nickname.isEmpty) {
      return 'Nickname cannot be empty';
    }
    if (RegExp(r'[!@#<>?":_~;[\]\\|=+(*&^%0-9-)]').hasMatch(nickname)) {
      return 'Nickname must not contain special characters or numbers';
    }
    return null;
  }

  String? validatedAge(String age) {
    if (age.isEmpty) {
      return 'Age cannot be empty';
    }
    if (!RegExp(r'^\d+$').hasMatch(age)) {
      return 'Age must be a number';
    }
    return null;
  }

  String? validatedHeight(String height) {
    if (height.isEmpty) {
      return 'Height cannot be empty';
    }
    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(height)) {
      return 'Height must be a valid number';
    }
    return null;
  }

  String? validatedWeight(String weight) {
    if (weight.isEmpty) {
      return 'Weight cannot be empty';
    }
    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(weight)) {
      return 'Weight must be a valid number';
    }
    return null;
  }

  String? validatedVaccinated(String vaccinated) {
    if (vaccinated.isEmpty) {
      return 'Vaccinated date cannot be empty';
    }
    return null;
  }

  String? validatedAddress(String address) {
    if (address.isEmpty) {
      return 'Address cannot be empty';
    }
    return null;
  }

  String? validatedDescription(String description) {
    if (description.isEmpty) {
      return 'Description cannot be empty';
    }
    return null;
  }

  String? validatedPrice(String price) {
    if (price.isEmpty) {
      return 'Price cannot be empty';
    }
    if (!RegExp(r'^\d+(\.\d+)?$').hasMatch(price)) {
      return 'Price must be a valid number';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 127, 0, 0),
        centerTitle: true,
        title: const Text(
          'Add Pet Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Image Picker ---
          InkWell(
            onTap: () {
              getImageGallery();
            },
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.grey[100],
              ),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.file(
                        _image!.absolute,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 40,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Tap to add pet photo',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 24),

          // --- Nickname Text Field ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: TextField(
                controller: NicknameController,
                decoration: InputDecoration(
                  labelText: 'Nick Name',
                  errorText: NicknameError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    NicknameError = validatedNickname(value);
                  });
                },
              ),
            ),
          ),

          // --- Category Dropdown ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                hint: const Text('Select Category'),
                // Use _selectedCategoryName for the value
                value: _selectedCategoryName,
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategoryName = newValue;
                    final selectedCategoryObject = categories.firstWhere(
                        (category) => category['name'] == newValue,
                        orElse: () => null);

                    if (selectedCategoryObject != null) {
                      _selectedCategoryId = selectedCategoryObject['id']; // Store the ID
                      fetchBreedsByCategoryId(
                          _selectedCategoryId!); // Fetch breeds using the ID
                    } else {
                      _selectedCategoryId = null;
                      breedsForSelectedCategory = [];
                      _selectedBreedName = null;
                      _selectedBreedId = null;
                    }
                  });
                },
                // Iterate over 'categories' list
                items: categories.map<DropdownMenuItem<String>>((category) {
                  return DropdownMenuItem<String>(
                    value: category['name'], // Value should be the name
                    child: Row(
                      children: [
                        // Display image if available
                        if (category['imagePath'] != null && category['imagePath'].isNotEmpty)
                          Image.network(
                            category['imagePath'],
                            width: 30,
                            height: 30,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.image_not_supported, size: 30),
                          ),
                        const SizedBox(width: 10),
                        Text(category['name']),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // --- Breed Dropdown ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: _isLoadingBreeds
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      hint: const Text('Select Breed'),
                      // Use _selectedBreedName for the value
                      value: _selectedBreedName,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedBreedName = newValue;
                          // Find the corresponding ID for the selected breed
                          final selectedBreedObject = breedsForSelectedCategory.firstWhere(
                                  (breed) => breed['name'] == newValue,
                                  orElse: () => null);
                          if (selectedBreedObject != null) {
                            _selectedBreedId = selectedBreedObject['id']; // Store the ID
                          } else {
                            _selectedBreedId = null;
                          }
                        });
                      },
                      // Iterate over 'breedsForSelectedCategory'
                      items: breedsForSelectedCategory
                          .map<DropdownMenuItem<String>>((breed) {
                        return DropdownMenuItem<String>(
                          value: breed['name'], // Value should be the name
                          child: Text(breed['name']),
                        );
                      }).toList(),
                    ),
            ),
          ),

          // --- Location Dropdown ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: _isLoadingLocations
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      hint: const Text('Select Location'),
                      // Use _selectedLocationName for the value
                      value: _selectedLocationName,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocationName = newValue;
                          // Find the corresponding ID for the selected location
                          final selectedLocationObject = locations.firstWhere(
                                  (location) => location['name'] == newValue,
                                  orElse: () => null);
                          if (selectedLocationObject != null) {
                            _selectedLocationId = selectedLocationObject['id']; // Store the ID
                          } else {
                            _selectedLocationId = null;
                          }
                        });
                      },
                      // Iterate over 'locations' list
                      items: locations.map<DropdownMenuItem<String>>((location) {
                        return DropdownMenuItem<String>(
                          value: location['name'], // Value should be the name
                          child: Text(location['name']),
                        );
                      }).toList(),
                    ),
            ),
          ),

          // --- Age Text Field ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  errorText: ageError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) =>
                    setState(() => ageError = validatedAge(value)),
              ),
            ),
          ),

          // --- Height Text Field ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Height',
                  errorText: heightError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) =>
                    setState(() => heightError = validatedHeight(value)),
              ),
            ),
          ),

          // --- Weight Text Field ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: WeightController,
                decoration: InputDecoration(
                  labelText: 'Weight',
                  errorText: WeightError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) =>
                    setState(() => WeightError = validatedWeight(value)),
              ),
            ),
          ),

          // --- Description Text Field ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: TextField(
                controller: DescriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  errorText: DescriptionError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) =>
                    setState(() => DescriptionError = validatedDescription(value)),
              ),
            ),
          ),

          // --- Address Text Field ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: TextField(
                controller: AdressController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Address',
                  errorText: AdressError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) =>
                    setState(() => AdressError = validatedAddress(value)),
              ),
            ),
          ),

          // --- Price Text Field ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: PriceController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  errorText: PriceError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) =>
                    setState(() => PriceError = validatedPrice(value)),
              ),
            ),
          ),

          // --- Gender Dropdown ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(12.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none, 
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                hint: const Text('Select Gender'),
                value: _selectedgender,
                onChanged: (newValue) =>
                    setState(() => _selectedgender = newValue),
                items: _genderOptions.map((gender) {
                  return DropdownMenuItem<String>(
                      value: gender, child: Text(gender));
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // --- Submit Button ---
          ElevatedButton(
            onPressed: sendPetData, // Call the new sendPetData function
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 127, 0, 0),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text(
              'Add Pet',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}



