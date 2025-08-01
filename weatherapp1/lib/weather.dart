



import 'dart:math';
import 'package:flutter/material.dart';
import 'package:weatherapp1/splashscreen.dart';





class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat', // Using a common, modern font
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController cityController = TextEditingController();

  Map<String, dynamic>? weatherData;
  final Random random = Random();

  // Mock weather data generator
  Map<String, dynamic> generateMockWeatherData(String city) {
    final conditions = ['Clear', 'Clouds', 'Rain', 'Drizzle', 'Snow', 'Mist'];
    final descriptions = {
      'Clear': 'clear sky',
      'Clouds': 'scattered clouds',
      'Rain': 'light rain',
      'Drizzle': 'light drizzle',
      'Snow': 'light snow',
      'Mist': 'mist'
    };

    final condition = conditions[random.nextInt(conditions.length)];
    final temp = 15 + random.nextInt(20); // Temperature between 15-35°C

    return {
      'name': city,
      'sys': {'country': 'IN'},
      'main': {
        'temp': temp.toDouble(),
        'feels_like': (temp + random.nextInt(5) - 2).toDouble(),
        'humidity': 44 + random.nextInt(40), // Humidity 44-84%
        'pressure': 1000 + random.nextInt(50), // Pressure 1000-1050 hPa
      },
      'weather': [
        {
          'main': condition,
          'description': descriptions[condition],
        }
      ],
      'wind': {
        'speed': (random.nextDouble() * 10).toDouble(), // Wind speed 0-10 m/s
      }
    };
  }

  void searchWeatherByCity(String city) {
    if (city.isEmpty) return;

    FocusScope.of(context).unfocus(); // Dismiss keyboard
    setState(() {
      weatherData = generateMockWeatherData(city);
    });
  }

  void generateRandomWeather() {
    final cities = [
      'Mumbai',
      'Delhi',
      'Bangalore',
      'Chennai',
      'Kolkata',
      'Kochi',
      'Hyderabad',
      'Pune',
      'Ahmedabad',
      'Jaipur'
    ];
    final randomCity = cities[random.nextInt(cities.length)];

    FocusScope.of(context).unfocus(); // Dismiss keyboard
    setState(() {
      weatherData = generateMockWeatherData(randomCity);
      cityController.text = randomCity;
    });
  }

  String getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return '☀️';
      case 'clouds':
        return '☁️';
      case 'rain':
        return '🌧️';
      case 'drizzle':
        return '🌦️';
      case 'thunderstorm':
        return '⛈️';
      case 'snow':
        return '🌨️';
      case 'mist':
      case 'fog':
      case 'haze':
        return '🌫️';
      default:
        return '🌤️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WeatherWise', // Updated App Title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true, // Extend body behind app bar for full gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade800,
              Colors.indigo.shade900,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0), // Increased padding
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight -
                    40, // Adjusted for new padding
              ),
              child: Column(
                children: [
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), // Frosted effect
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: cityController,
                            decoration: InputDecoration(
                              hintText: 'Enter city name',
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(fontSize: 18, color: Colors.white),
                            textCapitalization: TextCapitalization.words,
                            onSubmitted: (value) => searchWeatherByCity(value),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search, color: Colors.white),
                          onPressed: () => searchWeatherByCity(cityController.text),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25), // Increased spacing

                  // Random weather button
                  ElevatedButton.icon(
                    onPressed: generateRandomWeather,
                    icon: Icon(Icons.shuffle, size: 20),
                    label: Text(
                      'Surprise Me!', // Changed text
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent[400], // New accent color
                      foregroundColor: Colors.blue.shade900,
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8, // Increased elevation
                      shadowColor: Colors.black.withOpacity(0.4),
                    ),
                  ),
                  SizedBox(height: 40), // Increased spacing

                  // Weather display
                  weatherData != null
                      ? WeatherDisplay(
                          weatherData: weatherData!,
                          getWeatherIcon: getWeatherIcon,
                        )
                      : Container(
                          height: 300,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloudy_snowing, // Changed icon
                                  size: 80,
                                  color: Colors.white54,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  'Find out the weather or get a random forecast!',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 17,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final String Function(String) getWeatherIcon;

  const WeatherDisplay({
    Key? key,
    required this.weatherData,
    required this.getWeatherIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = weatherData['main']['temp'].round();
    final feelsLike = weatherData['main']['feels_like'].round();
    final condition = weatherData['weather'][0]['main'];
    final description = weatherData['weather'][0]['description'];
    final cityName = weatherData['name'];
    final country = weatherData['sys']['country'];
    final humidity = weatherData['main']['humidity'];
    final windSpeed = weatherData['wind']['speed'];
    final pressure = weatherData['main']['pressure'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0), // Slightly reduced horizontal padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // City name
          Text(
            '$cityName, $country',
            style: TextStyle(
              fontSize: 34, // Increased font size
              fontWeight: FontWeight.w900, // Bolder
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 25), // Increased spacing

          // Weather icon and temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getWeatherIcon(condition),
                style: TextStyle(fontSize: 90), // Larger icon
              ),
              SizedBox(width: 25), // Increased spacing
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${temp}°C',
                    style: TextStyle(
                      fontSize: 60, // Larger temperature
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(1.0, 1.0),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Feels like ${feelsLike}°C',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 25),

          // Weather description
          Text(
            description.toUpperCase(),
            style: TextStyle(
              fontSize: 22, // Larger description
              color: Colors.white,
              letterSpacing: 1.5, // Increased letter spacing
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50), // Increased spacing

          // Weather details
          Container(
            padding: EdgeInsets.all(20.0), // Increased padding
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15), // More transparent
              borderRadius: BorderRadius.circular(20), // More rounded corners
              border: Border.all(color: Colors.white.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: WeatherDetail(
                      icon: Icons.water_drop_outlined, // Changed icon
                      label: 'Humidity',
                      value: '${humidity}%',
                    ),
                  ),
                  Expanded(
                    child: WeatherDetail(
                      icon: Icons.waves_outlined, // Changed icon
                      label: 'Wind',
                      value: '${windSpeed.toStringAsFixed(1)} m/s',
                    ),
                  ),
                  Expanded(
                    child: WeatherDetail(
                      icon: Icons.speed_outlined, // Changed icon
                      label: 'Pressure',
                      value: '${pressure} hPa',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherDetail({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.tealAccent[200], size: 30), // Accent color for icons
        SizedBox(height: 10), // Increased spacing
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13, // Slightly larger font
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6), // Increased spacing
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18, // Larger value font
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}