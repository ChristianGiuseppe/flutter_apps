import 'dart:async';

import 'package:brickbreak/components/arena_component.dart';
import 'package:brickbreak/components/ball_component.dart';
import 'package:brickbreak/components/brick/brick_wall.dart';
import 'package:brickbreak/components/dead_zone_component.dart';
import 'package:brickbreak/components/paddle_component.dart';
import 'package:brickbreak/data/game_state.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Forge2dGameWorld extends Forge2DGame with DragCallbacks, TapCallbacks {
  Forge2dGameWorld() : super(gravity: Vector2.zero(), zoom: 20);
  late final BallComponent _ball;
  late final ArenaComponent _arena;
  late final PaddleComponent _paddle;
  late final DeadZone _deadZone;
  late final BrickWall _brickWall;

  GameState gameState = GameState.init;

  @override
  FutureOr<void> onLoad() async {
    await _initGame();
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (gameState == GameState.ready) {
      overlays.remove('PreGame');
      _ball.body.applyLinearImpulse(Vector2(-5000,
          -5000)); //rappresenta la forza applicata alla palla _ball.body.applyLinearImpulse(Vector2(-10.0, -10.0));
      gameState = GameState.running;
    }
    super.onTapDown(event);
  }

  @override
  void update(double dt) {
    if (gameState == GameState.lost || gameState == GameState.won) {
      pauseEngine();
      overlays.add('PostGame');
    }
    super.update(dt);
  }

  Future<void> _initGame() async {
    _arena = ArenaComponent(size: null);
    await add(_arena);

    final brickWallPosition = Vector2(0.0, size.y * 0.075);

    _brickWall = BrickWall(
      position: brickWallPosition,
      rows: 8,
      columns: 6,
    );

    await add(_brickWall);

    final deadSize = Size(size.x, size.y * 0.1);
    final deadZonePosition =
        Vector2(size.x / 2.0, size.y - (size.y * 0.1) / 2.0);
    _deadZone = DeadZone(size: deadSize, position: deadZonePosition);

    await add(_deadZone);

    const paddleSize = Size(40.0, 8);
    final paddlePosition = Vector2(
      size.x / 2.0,
      size.y - deadSize.height - paddleSize.height / 2.0,
    );

    _paddle = PaddleComponent(
      size: paddleSize,
      ground: _arena,
      position: paddlePosition,
    );

    await add(_paddle);

    final ballPosition = Vector2(size.x / 2.0, size.y / 2.0 + 10.0);
    _ball = BallComponent(position: ballPosition, radius: 4);
    await add(_ball);

    gameState = GameState.ready;
    overlays.add('PreGame');
  }

  Future<void> resetGame() async {
    gameState = GameState.init;

    _ball.reset();
    _paddle.reset();
    await _brickWall.reset();

    gameState = GameState.ready;

    overlays.remove(overlays.activeOverlays.first);
    overlays.add('PreGame');

    resumeEngine();
  }
}
