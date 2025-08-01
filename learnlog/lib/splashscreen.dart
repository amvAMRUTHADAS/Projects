// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:learnlog/loginpage.dart';
// import 'package:lottie/lottie.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   String _currentAnimation = "assets/books.json";

//   void _changeAnimation(String animationAsset) {
//     setState(() {
//       _currentAnimation = animationAsset;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

//     Future.delayed(const Duration(seconds: 9), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const Loginpage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // Extend body behind AppBar for gradient continuity
//       appBar: AppBar(
//         backgroundColor: Colors.transparent, // Transparent to show gradient
//         elevation: 10, // No shadow
//         title: const Text(
//           "Lernlog",
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 6, 48, 83),
//             fontFamily: 'Cursive',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF008080), // Teal
//               Color(0xFF20B2AA), // LightSeaGreen
//               Color(0xFF40E0D0), // Turquoise
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Lottie.asset(
//             _currentAnimation,
//             height: 500,
//             fit: BoxFit.contain,
//             onLoaded: (composition) {
//               print('Lottie animation loaded: ${composition.duration}');
//             },
//             errorBuilder: (context, error, stackTrace) {
//               print('Lottie error: $error');
//               return const Text(
//                 'Failed to load animation',
//                 style: TextStyle(color: Colors.white),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:learnlog/loginpage.dart';
// import 'package:lottie/lottie.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   String _currentAnimation = "assets/books.json";

//   void _changeAnimation(String animationAsset) {
//     setState(() {
//       _currentAnimation = animationAsset;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

//     Future.delayed(const Duration(seconds: 9), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const Loginpage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // Extend body behind AppBar for gradient continuity
//       appBar: AppBar(
//         backgroundColor: Colors.transparent, // Transparent to show gradient
//         elevation: 10, // Keep your specified elevation
//         title: const Text(
//           "Lernlog",
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 6, 48, 83),
//             fontFamily: 'Cursive',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF4A148C), // Deep Purple
//               Color(0xFFAB47BC), // Medium Purple
//               Color(0xFFE1BEE7), // Light Purple
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Lottie.asset(
//             _currentAnimation,
//             height: 500,
//             fit: BoxFit.contain,
//             onLoaded: (composition) {
//               print('Lottie animation loaded: ${composition.duration}');
//             },
//             errorBuilder: (context, error, stackTrace) {
//               print('Lottie error: $error');
//               return const Text(
//                 'Failed to load animation',
//                 style: TextStyle(color: Colors.white),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:learnlog/loginpage.dart';
// import 'package:lottie/lottie.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   String _currentAnimation = "assets/books.json";

//   void _changeAnimation(String animationAsset) {
//     setState(() {
//       _currentAnimation = animationAsset;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

//     Future.delayed(const Duration(seconds: 9), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const Loginpage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true, // Extend body behind AppBar for gradient continuity
//       appBar: AppBar(
//         backgroundColor: Colors.transparent, // Transparent to show gradient
//         elevation: 10, // Keep your specified elevation
//         title: const Text(
//           "Lernlog",
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 6, 48, 83),
//             fontFamily: 'Cursive',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF00796B), // Teal
//               Color(0xFF26A69A), // Light Teal
//               Color(0xFFB2DFDB), // Pale Teal
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Lottie.asset(
//             _currentAnimation,
//             height: 500,
//             fit: BoxFit.contain,
//             onLoaded: (composition) {
//               print('Lottie animation loaded: ${composition.duration}');
//             },
//             errorBuilder: (context, error, stackTrace) {
//               print('Lottie error: $error');
//               return const Text(
//                 'Failed to load animation',
//                 style: TextStyle(color: Colors.white),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:learnlog/loginpage.dart';
// import 'package:lottie/lottie.dart';

// class Splash extends StatefulWidget {
//   const Splash({super.key});

//   @override
//   State<Splash> createState() => _SplashState();
// }

// class _SplashState extends State<Splash> {
//   String _currentAnimation = "assets/books.json";

//   void _changeAnimation(String animationAsset) {
//     setState(() {
//       _currentAnimation = animationAsset;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

//     Future.delayed(const Duration(seconds: 9), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const Loginpage()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     SystemChrome.setEnabledSystemUIMode(
//       SystemUiMode.manual,
//       overlays: SystemUiOverlay.values,
//     );
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 10,
//         title: const Text(
//           "Lernlog",
//           style: TextStyle(
//             fontSize: 40,
//             fontWeight: FontWeight.bold,
//             // Changed text color to a soft, complementary shade
//             color: Color(0xFFE0F2F7), // A light, airy blue
//             fontFamily: 'Cursive',
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             // Updated gradient for a softer, more elegant feel
//             colors: [
//               Color.fromARGB(255, 25, 76, 83), // Light Cyan - starting bright and refreshing
//               Color(0xFF4DD0E1), // Cyan - slightly deeper
//               Color.fromARGB(255, 59, 159, 172), // Turquoise - a calm, sophisticated mid-tone
//               Color.fromARGB(255, 15, 85, 94), // Dark Cyan - for a gentle depth
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Center(
//           child: Lottie.asset(
//             _currentAnimation,
//             height: 500,
//             fit: BoxFit.contain,
//             onLoaded: (composition) {
//               print('Lottie animation loaded: ${composition.duration}');
//             },
//             errorBuilder: (context, error, stackTrace) {
//               print('Lottie error: $error');
//               return const Text(
//                 'Failed to load animation',
//                 style: TextStyle(color: Colors.white),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learnlog/loginpage.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String _currentAnimation = "assets/books.json";

  void _changeAnimation(String animationAsset) {
    setState(() {
      _currentAnimation = animationAsset;
    });
  }

  @override
  void initState() {
    super.initState();
    // Keep immersive mode for a truly full-screen experience
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const Loginpage()),
      );
    });
  }

  @override
  void dispose() {
    // Re-enable system UI overlays when the splash screen is disposed
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 4, 45, 50), // Darker Teal
              Color.fromARGB(255, 13, 74, 83), // Cyan - slightly deeper
              Color.fromARGB(255, 13, 65, 71), // Turquoise - a calm, sophisticated mid-tone
              Color.fromARGB(255, 3, 42, 47), // Even Darker Teal for depth
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack( // Use a Stack to layer widgets
          children: [
            Center(
              child: Lottie.asset(
                _currentAnimation,
                height: 500,
                fit: BoxFit.contain,
                onLoaded: (composition) {
                  print('Lottie animation loaded: ${composition.duration}');
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Lottie error: $error');
                  return const Text(
                    'Failed to load animation',
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ),
            // Positioned the text at the top-center
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15, // Adjust this value to move the text up/down
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  "Lernlog",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE0F2F7), // A light, airy blue for good contrast
                    fontFamily: 'Cursive',
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