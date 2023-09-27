import 'package:brickbreak/data/game_state.dart';
import 'package:brickbreak/world/forge_2d_game_world.dart';
import 'package:flutter/material.dart';

class OverlayBuilder {
  OverlayBuilder._();

  // 2
  static Widget preGame(BuildContext context, Forge2dGameWorld game) {
    return const PreGameOverlay();
  }

  static Widget postGame(BuildContext context, Forge2dGameWorld game) {
    assert(game.gameState == GameState.lost || game.gameState == GameState.won);

    final message = game.gameState == GameState.won ? 'Winner!' : 'Game Over';
    return PostGameOverlay(message: message, game: game);
  }
}

// 3
class PreGameOverlay extends StatelessWidget {
  const PreGameOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Tap Paddle to Begin',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}

class PostGameOverlay extends StatelessWidget {
  final String message;
  final Forge2dGameWorld game;

  const PostGameOverlay({
    super.key,
    required this.message,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 24),
          _resetButton(context, game),
        ],
      ),
    );
  }

  Widget _resetButton(BuildContext context, Forge2dGameWorld game) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: Colors.blue,
        ),
      ),
      onPressed: () => game.resetGame(),
      icon: const Icon(Icons.restart_alt_outlined),
      label: const Text('Replay'),
    );
  }
}
