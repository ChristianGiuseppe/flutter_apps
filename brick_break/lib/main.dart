import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:brickbreak/world/forge_2d_game_world.dart';
import 'ui/overlay_builder.dart';

void main() {
  runApp(const BrickBreakAPP());
}

class BrickBreakAPP extends StatelessWidget {
  const BrickBreakAPP({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breakout',
      home: MainGamePage(),
    );
  }
}

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  State<MainGamePage> createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {
  final forge2dGameWorld = Forge2dGameWorld();
  final rwGreen = const Color.fromARGB(255, 21, 132, 67);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rwGreen,
      body: Container(
        color: Colors.black87,
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: const GameWidget.controlled(
          gameFactory: Forge2dGameWorld.new,
          overlayBuilderMap: {
            'PreGame': OverlayBuilder.preGame,
            'PostGame': OverlayBuilder.postGame,
          },
        ),
      ),
    );
  }
}
