import 'package:brickbreak/world/forge_2d_game_world.dart';
import 'package:flame/game.dart';
import 'package:flutter/rendering.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

//Definizione ball: I corpi sono gli oggetti fondamentali nella scena della fisica. Possiedono le proprietà fisiche di un corpo rigido.
//Ci sono tre tipi di corpi in Forge2D: statici, dinamici e cinematici:
///I corpi statici non si muovono. I mattoni nel muro di mattoni saranno corpi statici.
///I corpi dinamici reagiscono alle forze. Forge2D aggiorna i corpi dinamici rispettando le leggi del moto di Newton.
///La palla e la pagaia sono corpi dinamici.
///I corpi cinematici sono un ibrido tra corpi statici e dinamici. Una ruota panoramica è un esempio di corpo cinematico.
/// La posizione della ruota panoramica rimane fissa, ma il movimento della ruota panoramica che ruota attorno al suo centro è dinamico. Il gioco BreakBrick non usa corpi cinematici.

class BallComponent extends BodyComponent<Forge2dGameWorld> {
  BallComponent({required this.position, required this.radius});
  @override
  final Vector2 position;
  final double radius;
  final _gradient = RadialGradient(
    center: Alignment.topLeft,
    colors: [
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 1.0).toColor(),
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.9).toColor(),
      const HSLColor.fromAHSL(1.0, 0.0, 0.0, 0.4).toColor(),
    ],
    stops: const [0.0, 0.5, 1.0],
    radius: 0.95,
  );

  @override
  Body createBody() {
    final bodyDef = BodyDef() //è l'anima del corpo rigido
      ..type = BodyType.dynamic
      ..userData = this
      ..position = position;

    final ball = world.createBody(bodyDef);
    final shape = CircleShape()..radius = radius;

    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0
      ..density = 1.0;
    ball.createFixture(fixtureDef);
    return ball;
  }

  void reset() {
    body.setTransform(position, angle);
    body.angularVelocity = 0.0;
    body.linearVelocity = Vector2.zero();
  }

  @override
  void render(Canvas canvas) {
    // 2
    final circle = body.fixtures.first.shape as CircleShape;

    // 3
    final paint = Paint()
      ..shader = _gradient.createShader(Rect.fromCircle(
        center: circle.position.toOffset(),
        radius: radius,
      ))
      ..style = PaintingStyle.fill;

    // 4
    canvas.drawCircle(circle.position.toOffset(), radius, paint);
  }
}
