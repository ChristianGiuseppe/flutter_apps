import 'package:brickbreak/components/ball_component.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/rendering.dart';

import '../../world/forge_2d_game_world.dart';

class BrickComponent extends BodyComponent<Forge2dGameWorld>
    with ContactCallbacks {
  final Size size;
  @override
  final Vector2 position;
  final Color color;

  BrickComponent(this.size, this.position, this.color);

  @override
  void render(Canvas canvas) {
    if (body.fixtures.isEmpty) {
      return;
    }

    final rectangle = body.fixtures.first.shape as PolygonShape;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromCenter(
          center: rectangle.centroid.toOffset(),
          width: size.width,
          height: size.height,
        ),
        paint);
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..userData = this
      ..position = position
      ..angularDamping = 1.0 // per evitare che si sposti di posizione
      ..linearDamping = 1.0; // per evitare che si sposti di posizione
    final brickBody = world.createBody(bodyDef);
    final shape = PolygonShape()
      ..setAsBox(
        size.width / 2.0,
        size.height / 2.0,
        Vector2(0.0, 0.0),
        0.0,
      );

    brickBody.createFixture(
      FixtureDef(shape)
        ..density = 100.0
        ..friction = 0.0
        ..restitution = 0.1,
    );

    return brickBody;
  }

  var destroy = false;
  @override
  void beginContact(Object other, Contact contact) {
    if (other is BallComponent) {
      destroy = true;
    }
    super.beginContact(other, contact);
  }
}
