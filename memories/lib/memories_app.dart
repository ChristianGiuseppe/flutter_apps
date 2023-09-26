import 'package:flutter/material.dart';
import 'package:memories/memories_game.dart';

class MemoriesApp extends StatelessWidget {
  const MemoriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            background: const Color(0xFF598392),
            seedColor: const Color(0xFF598392)),
        useMaterial3: true,
      ),
      home: const MemoriesHomePage(),
    );
  }
}

class MemoriesHomePage extends StatefulWidget {
  const MemoriesHomePage({super.key});

  @override
  State<MemoriesHomePage> createState() => _MemoriesHomePageState();
}

class _MemoriesHomePageState extends State<MemoriesHomePage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
    value: 0.5,
  )..repeat(reverse: true);

  final Tween<double> _tween = Tween(begin: 0.8, end: 1);
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MemoriesGame()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Image(
                      image: AssetImage('assets/images/memories_title.png')),
                  const Expanded(
                      child: Image(
                          image:
                              AssetImage('assets/images/memories_card.png'))),
                  ScaleTransition(
                    scale: _tween.animate(_controller),
                    child: const Text(
                      'Tap to \nSTART',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Mali',
                          fontSize: 32.0,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
