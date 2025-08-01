import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to BMICalculatorUI after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BMICalculatorUI()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 51, 37, 141), // Vibrant Coral
              Color.fromARGB(255, 62, 97, 165), // Cool Gray
              Color.fromARGB(255, 44, 78, 120), // Bright Blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.scale,
                size: 100,
                color: const Color.fromARGB(255, 138, 121, 169),
              ),
              SizedBox(height: 20),
              Text(
                'BMI Calculator',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Measure Your Wellness',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 30),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- BMI Calculator UI -------------------


class BMICalculatorUI extends StatefulWidget {
  @override
  State<BMICalculatorUI> createState() => _BMICalculatorUIState();
}

class _BMICalculatorUIState extends State<BMICalculatorUI> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  int height = 0;
  String selectedGender = '';
  double? bmiResult;
  String bmiCategory = "";
  String name = "";

  void clearFields() {
    setState(() {
      _nameController.clear();
      _ageController.clear();
      _weightController.clear();
      _heightController.clear();
      height = 0;
      selectedGender = '';
      bmiResult = null;
      bmiCategory = "";
      name = "";
    });
  }

  void navigateToHistoryPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BMIHistoryPage()),
    );
  }

  void navigateToAboutPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AboutBMIPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC2D3FF), Color(0xFFD6C4F0), Color(0xFFF5E9FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.info_outline, color: Colors.deepPurple),
                      onPressed: navigateToAboutPage,
                    ),
                    Expanded(
                      child: Text(
                        "BMI Calculator",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.history, color: Colors.deepPurple),
                      tooltip: "View History",
                      onPressed: navigateToHistoryPage,
                    ),
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.deepPurple),
                      onPressed: clearFields,
                      tooltip: "Clear",
                    ),
                  ],
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    labelText: "Name",
                    labelStyle: TextStyle(color: Colors.black87),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    buildGenderCard(Icons.male, 'Male'),
                    SizedBox(width: 10),
                    buildGenderCard(Icons.female, 'Female'),
                  ],
                ),
                SizedBox(height: 10),
                buildHeightCard(),
                SizedBox(height: 10),
                Row(
                  children: [
                    buildStepperField("Age", _ageController),
                    SizedBox(width: 10),
                    buildStepperField("Weight (kg)", _weightController),
                  ],
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: calculateBMI,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purpleAccent, Colors.deepPurple],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Calculate BMI",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                if (bmiResult != null) buildBMIResultCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    int age = int.tryParse(_ageController.text) ?? 0;
    int weight = int.tryParse(_weightController.text) ?? 0;

    if (_heightController.text.isNotEmpty) {
      height = int.tryParse(_heightController.text) ?? 0;
    }

    if (height == 0 ||
        weight == 0 ||
        age == 0 ||
        selectedGender == '' ||
        _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all fields to calculate BMI."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);
    String category = getBMICategory(bmi);

    setState(() {
      bmiResult = bmi;
      bmiCategory = category;
      name = _nameController.text;
    });

    FirebaseFirestore.instance.collection('bmi_records').add({
      'name': name,
      'gender': selectedGender,
      'age': age,
      'height': height,
      'weight': weight,
      'bmi': bmi.toStringAsFixed(2),
      'category': category,
      'timestamp': Timestamp.now(),
    });
  }

  Widget buildBMIResultCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          resultText("Name: $name"),
          resultText("Gender: $selectedGender"),
          resultText("Age: ${_ageController.text}"),
          resultText("Height: $height cm"),
          resultText("Weight: ${_weightController.text} kg"),
          resultText("BMI: ${bmiResult!.toStringAsFixed(2)}"),
          resultText("Category: $bmiCategory"),
          SizedBox(height: 20),
          Container(
            height: 300,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 10,
                  maximum: 40,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 10,
                        endValue: 18.5,
                        color: Colors.orange,
                        label: 'UW',
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.black)),
                    GaugeRange(
                        startValue: 18.5,
                        endValue: 25,
                        color: Colors.green,
                        label: 'NW',
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.black)),
                    GaugeRange(
                        startValue: 25,
                        endValue: 30,
                        color: Colors.yellow,
                        label: 'OW',
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.black)),
                    GaugeRange(
                        startValue: 30,
                        endValue: 40,
                        color: Colors.red,
                        label: 'ObW',
                        labelStyle: GaugeTextStyle(fontSize: 12, color: Colors.black)),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: bmiResult ?? 0,
                      needleColor: Colors.red,
                      knobStyle: KnobStyle(color: Colors.red),
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        'BMI = ${bmiResult!.toStringAsFixed(1)}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      angle: 90,
                      positionFactor: 0.8,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeightCard() {
    _heightController.text = height.toString();
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text("Height", style: TextStyle(color: Colors.black, fontSize: 18)),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$height cm",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              Container(
                width: 100,
                child: TextField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    int newHeight = int.tryParse(value) ?? height;
                    if (newHeight >= 0 && newHeight <= 220) {
                      setState(() {
                        height = newHeight;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          Slider(
            value: height.toDouble(),
            min: 0,
            max: 220,
            activeColor: Colors.purple,
            onChanged: (val) {
              setState(() {
                height = val.toInt();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildStepperField(String label, TextEditingController controller) {
    return Expanded(
      child: Container(
        height: 130,
        padding: EdgeInsets.all(12), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              label, 
              style: TextStyle(color: Colors.black87, fontSize: 16), // Reduced font size
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: Colors.deepPurple),
                  iconSize: 24, // Reduced icon size
                  constraints: BoxConstraints(minWidth: 32, minHeight: 32), // Reduced button size
                  onPressed: () {
                    int current = int.tryParse(controller.text) ?? 0;
                    if (current > 0) {
                      setState(() {
                        controller.text = (current - 1).toString();
                      });
                    }
                  },
                ),
                Expanded( // Use Expanded instead of fixed width
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20, // Reduced font size
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                      border: OutlineInputBorder(),
                      isDense: true, // Make the field more compact
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: Colors.deepPurple),
                  iconSize: 24, // Reduced icon size
                  constraints: BoxConstraints(minWidth: 32, minHeight: 32), // Reduced button size
                  onPressed: () {
                    int current = int.tryParse(controller.text) ?? 0;
                    setState(() {
                      controller.text = (current + 1).toString();
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildGenderCard(IconData icon, String gender) {
    bool isSelected = selectedGender == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedGender = gender;
          });
        },
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple])
                : null,
            color: isSelected ? null : Colors.white70,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.black),
              SizedBox(height: 10),
              Text(
                gender,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resultText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style:
            TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
      ),
    );
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal";
    if (bmi < 30) return "Overweight";
    return "Obese";
  }
}

// ------------------- BMI History Page -------------------

class BMIHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("BMI History", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purpleAccent, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('bmi_records')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final records = snapshot.data!.docs;

          if (records.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "No BMI records found",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final data = records[index];
              final docId = records[index].id;
              
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [Color(0xFFF5F5F5), Color(0xFFEDE7F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "👤 Name: ${data['name']}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'delete') {
                                _showDeleteDialog(context, docId, data['name']);
                              }
                            },
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem<String>(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete'),
                                  ],
                                ),
                              ),
                            ],
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        "📊 BMI: ${data['bmi']} (${data['category']})",
                        style: TextStyle(fontSize: 16, color: Colors.deepPurple),
                      ),
                      SizedBox(height: 6),
                      Text(
                        " Age: ${data['age']}     Gender: ${data['gender']}",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 6),
                      Text(
                        " Height: ${data['height']} cm     Weight: ${data['weight']} kg",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          " ${data['timestamp'].toDate()}",
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String docId, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Record"),
          content: Text("Are you sure you want to delete the BMI record for $name?"),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _deleteRecord(context, docId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteRecord(BuildContext context, String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('bmi_records')
          .doc(docId)
          .delete();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("BMI record deleted successfully"),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting record: $error"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}








class AboutBMIPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("About BMI Ranges", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE1F5FE), Color(0xFFEDE7F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("BMI Categories",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
              SizedBox(height: 20),
              Container(
                height: 300, // Fixed height for the gauge
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 10,
                      maximum: 40,
                      ranges: <GaugeRange>[
                        GaugeRange(
                          startValue: 10,
                          endValue: 18.5,
                          color: Colors.orange,
                          label: 'UW',
                          labelStyle: GaugeTextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GaugeRange(
                          startValue: 18.5,
                          endValue: 25,
                          color: Colors.green,
                          label: 'NW',
                          labelStyle: GaugeTextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GaugeRange(
                          startValue: 25,
                          endValue: 30,
                          color: Colors.yellow,
                          label: 'OW',
                          labelStyle: GaugeTextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GaugeRange(
                          startValue: 30,
                          endValue: 40,
                          color: Colors.red,
                          label: 'ObW',
                          labelStyle: GaugeTextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                      pointers: <GaugePointer>[
                        NeedlePointer(
                          value: 10, // Start of the scale
                          needleColor: Colors.red,
                          knobStyle: KnobStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              infoTile("Underweight", "< 18.5", Colors.orange),
              infoTile("Normal weight", "18.5 – 24.9", Colors.green),
              infoTile("Overweight", "25 – 29.9", Colors.yellow),
              infoTile("Obesity", "30 and above", Colors.red),
              SizedBox(height: 20), // Extra padding at bottom
            ],
          ),
        ),
      ),
    );
  }

  Widget infoTile(String label, String range, Color color) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, radius: 10),
        title: Text(label),
        trailing: Text(range, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

