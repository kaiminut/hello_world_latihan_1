import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animasi Gelombang Hello World',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const WaveTextScreen(),
    );
  }
}

class WaveTextScreen extends StatefulWidget {
  const WaveTextScreen({Key? key}) : super(key: key);

  @override
  State<WaveTextScreen> createState() => _WaveTextScreenState();
}

class _WaveTextScreenState extends State<WaveTextScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String text = "Hello World";

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Belajar Pemograman Bergerak Latihan 1",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(text.length, (index) {
                // Perhitungan gelombang sinus
                double wave = calculateWave(_controller.value * 2 * 3.14159 + (index * 0.4));

                double translateY = wave * 15;
                double scale = 1.0 + (wave * 0.15);

                return Transform.translate(
                  offset: Offset(0, translateY),
                  child: Transform.scale(
                    scale: scale,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Text(
                        text[index],
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          // Menggunakan warna biru/cyan yang aman tanpa batasan hue
                          color: Colors.primaries[(index * 3) % Colors.primaries.length],
                          shadows: [
                            Shadow(
                              color: Colors.blueAccent.withOpacity(0.6),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  double calculateWave(double radians) {
    const double pi = 3.141592653589793;
    double x = radians % (2 * pi);
    if (x < 0) x += 2 * pi;
    if (x > pi) {
      return -calculateWave(x - pi);
    }
    return (4 * x * (pi - x)) / (pi * pi - 4 * x * (pi - x));
  }
}