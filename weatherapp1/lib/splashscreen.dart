// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:weatherapp1/weather.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late AnimationController _scaleController;
//   late AnimationController _rotationController;
  
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _rotationAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     // Initialize animation controllers
//     _fadeController = AnimationController(
//       duration: Duration(milliseconds: 1500),
//       vsync: this,
//     );
    
//     _scaleController = AnimationController(
//       duration: Duration(milliseconds: 2000),
//       vsync: this,
//     );
    
//     _rotationController = AnimationController(
//       duration: Duration(seconds: 3),
//       vsync: this,
//     );
    
//     // Create animations
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));
    
//     _scaleAnimation = Tween<double>(
//       begin: 0.3,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _scaleController,
//       curve: Curves.elasticOut,
//     ));
    
//     _rotationAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _rotationController,
//       curve: Curves.linear,
//     ));
    
//     // Start animations
//     _startAnimations();
    
//     // Navigate to main screen after delay
//     Timer(Duration(seconds: 4), () {
//       _navigateToMainScreen();
//     });
//   }

//   void _startAnimations() async {
//     await Future.delayed(Duration(milliseconds: 300));
//     _fadeController.forward();
//     _scaleController.forward();
//     _rotationController.repeat();
//   }

//   void _navigateToMainScreen() {
//     Navigator.of(context).pushReplacement(
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => WeatherScreen(),
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           return FadeTransition(opacity: animation, child: child);
//         },
//         transitionDuration: Duration(milliseconds: 800),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     _scaleController.dispose();
//     _rotationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Color(0xFF1E3C72),
//               Color(0xFF2A5298),
//               Color(0xFF3E6FB0),
//               Color(0xFF4A90E2),
//             ],
//             stops: [0.0, 0.3, 0.7, 1.0],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Animated weather icon container
//                 AnimatedBuilder(
//                   animation: Listenable.merge([_fadeAnimation, _scaleAnimation]),
//                   builder: (context, child) {
//                     return FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: ScaleTransition(
//                         scale: _scaleAnimation,
//                         child: Container(
//                           padding: EdgeInsets.all(30),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.15),
//                             borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.1),
//                                 blurRadius: 20,
//                                 spreadRadius: 5,
//                               ),
//                             ],
//                           ),
//                           child: AnimatedBuilder(
//                             animation: _rotationAnimation,
//                             builder: (context, child) {
//                               return Transform.rotate(
//                                 angle: _rotationAnimation.value * 2 * 3.14159,
//                                 child: Text(
//                                   '🌤️',
//                                   style: TextStyle(fontSize: 80),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
                
//                 SizedBox(height: 40),
                
//                 // App title with animation
//                 AnimatedBuilder(
//                   animation: _fadeAnimation,
//                   builder: (context, child) {
//                     return FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: SlideTransition(
//                         position: Tween<Offset>(
//                           begin: Offset(0, 0.5),
//                           end: Offset.zero,
//                         ).animate(CurvedAnimation(
//                           parent: _fadeController,
//                           curve: Curves.easeOutBack,
//                         )),
//                         child: Column(
//                           children: [
//                             Text(
//                               'Weather App',
//                               style: TextStyle(
//                                 fontSize: 36,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                                 letterSpacing: 2.0,
//                                 shadows: [
//                                   Shadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     offset: Offset(2, 2),
//                                     blurRadius: 4,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 12),
//                             Text(
//                               'Stay updated with live weather',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.white.withOpacity(0.9),
//                                 letterSpacing: 0.8,
//                                 fontWeight: FontWeight.w300,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
                
//                 SizedBox(height: 60),
                
//                 // Loading indicator with animation
//                 AnimatedBuilder(
//                   animation: _fadeAnimation,
//                   builder: (context, child) {
//                     return FadeTransition(
//                       opacity: _fadeAnimation,
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             width: 40,
//                             height: 40,
//                             child: CircularProgressIndicator(
//                               valueColor: AlwaysStoppedAnimation<Color>(
//                                 Colors.white.withOpacity(0.8),
//                               ),
//                               strokeWidth: 3,
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Text(
//                             'Loading...',
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.7),
//                               fontSize: 14,
//                               letterSpacing: 1.0,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:weatherapp1/weather.dart'; // Ensure this path is correct for your WeatherScreen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // Animation controllers and animations
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // Total duration for animations
    );

    // Fade animation (from 0 to 1 opacity)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn, // Smooth acceleration
      ),
    );

    // Scale animation (from 0.8 to 1.0 size)
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack, // A slight "bounce" effect at the end
      ),
    );

    // Start the animations
    _controller.forward();

    // Navigate to WeatherScreen after a delay
    Timer(const Duration(milliseconds: 2500), () { // Longer delay to allow animation to complete
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WeatherScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // Start from top
            end: Alignment.bottomCenter, // End at bottom
            colors: [
              Color(0xFF2980B9), // A lighter blue
              Color(0xFF2C3E50), // A darker, almost black-blue
            ],
            stops: [0.3, 0.9], // Control where the colors blend
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation, // Apply scale animation
                child: FadeTransition(
                  opacity: _fadeAnimation, // Apply fade animation
                  child: const Icon(
                    Icons.wb_sunny_rounded, // A more cheerful sun icon
                    size: 120, // Slightly larger icon
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 10.0,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25), // Increased spacing
              FadeTransition(
                opacity: _fadeAnimation, // Apply fade animation to text
                child: const Text(
                  'WeatherWise',
                  style: TextStyle(
                    fontSize: 38, // Larger font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.5, // Increased letter spacing
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 8.0,
                        color: Colors.black45,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'Your Daily Forecast', // New tagline
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}