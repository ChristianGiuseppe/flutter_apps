import 'package:brickbreak/components/ball_component.dart';
import 'package:brickbreak/data/game_state.dart';
import 'package:brickbreak/world/forge_2d_game_world.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class DeadZone extends BodyComponent<Forge2dGameWorld> with ContactCallbacks {
  final Size size;
  @override
  final Vector2 position;

  DeadZone({required this.size, required this.position});

  @override
  bool get renderBody => false;
  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..userData = this
      ..position = position;

    final zoneBody = world.createBody(bodyDef);
    final shape = PolygonShape()
      ..setAsBox(size.width / 2.0, size.height / 2.0, Vector2.zero(), 0.0);

    zoneBody.createFixture(FixtureDef(shape)
      ..isSensor =
          true); //isSensor I corpi dei sensori rilevano le collisioni ma non reagiscono
    return zoneBody;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is BallComponent) {
      game.gameState = GameState.lost;
    }
  }
}
