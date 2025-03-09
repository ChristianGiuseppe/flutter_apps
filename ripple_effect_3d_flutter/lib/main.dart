import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MaterialApp(home: RippleEffectDemo()));

class RippleEffectDemo extends StatefulWidget {
  const RippleEffectDemo({super.key});

  @override
  _RippleEffectDemoState createState() => _RippleEffectDemoState();
}

class _RippleEffectDemoState extends State<RippleEffectDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );
  }

  void _toggleAnimation() {
    if (_isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
    setState(() {
      _isAnimating = !_isAnimating;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [

            RippleCircle(size: 300, controller: _controller),
            RippleCircle(size: 250, controller: _controller),
            RippleCircle(size: 200, controller: _controller),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 4,
              ),
              onPressed: () => _toggleAnimation(),
              child: const Icon(Icons.bluetooth, size: 48, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class RippleCircle extends StatelessWidget {
  final double size;
  final AnimationController controller;

  const RippleCircle({required this.size, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 48.0),
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(90)
              ..rotateY(0)  // Rotazione sull'asse Y
              ..rotateZ(90), // Rotazione sull'asse Z
            child: Opacity(
              opacity: 1 - controller.value,
              child: Transform.scale(
                scale: 0.5 + controller.value * 0.5, // Scala da 0.5 a 1.0
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.3),
                      width: 4,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
