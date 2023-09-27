import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/rendering.dart';

class PaddleComponent extends BodyComponent with DragCallbacks {
  final Size size;
  final BodyComponent ground;

  @override
  final Vector2 position;
  PaddleComponent({
    required this.size,
    required this.ground,
    required this.position,
  });

  MouseJoint? _mouseJoint;
  Vector2 dragStartPosition = Vector2.zero();
  Vector2 dragAccumlativePosition = Vector2.zero();

  @override
  void render(Canvas canvas) {
    final shape = body.fixtures.first.shape as PolygonShape;

    final paint = Paint()
      ..color = const Color.fromARGB(255, 80, 80, 228)
      ..style = PaintingStyle.fill;

    canvas.drawRect(
        Rect.fromLTRB(
          shape.vertices[0].x,
          shape.vertices[0].y,
          shape.vertices[2].x,
          shape.vertices[2].y,
        ),
        paint);
  }

  @override
  void onMount() {
    super.onMount();
    //Impostare worldAxisper limitare il movimento della paletta all'asse x.
    final worldAxis = Vector2(1.0, 0);
    //Impostare la misura in cui la pagaia può muoversi.
    //Il movimento della paletta è relativo all'origine della paletta,
    // che è al suo centro. Impostare travelExtenta una distanza pari a metà della larghezza dell'area di gioco meno metà della larghezza della racchetta per mantenere il movimento all'interno dell arena.
    final travelExtent = (game.size.x / 2.0) - (size.width / 2.0);
    //Creare la definizione del giunto prismatico con i limiti di movimento.
    final jointDef = PrismaticJointDef()
      ..enableLimit = true
      ..lowerTranslation = -travelExtent
      ..upperTranslation = travelExtent
      ..collideConnected = true;
    //Crea il giunto e poi aggiungilo al mondo di gioco.
    jointDef.initialize(body, ground.body, body.worldCenter, worldAxis);
    final joint = PrismaticJoint(jointDef);
    world.createJoint(joint);
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = position
      ..fixedRotation = true
      ..angularDamping = 1.0
      ..linearDamping = 10.0;

    final paddleBody = world.createBody(bodyDef);

    final shape = PolygonShape()
      ..setAsBox(
        size.width / 2.0,
        size.height / 2.0,
        Vector2(0.0, 0.0),
        0.0,
      );

    paddleBody.createFixture(FixtureDef(shape)
      ..density = 100.0
      ..friction = 0.0
      ..restitution = 1.0);

    return paddleBody;
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (_mouseJoint != null) {}
    dragStartPosition = event.localPosition;
    _setupDragControls();

    // Don't continue passing the event.

    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    dragAccumlativePosition += event.delta;
    if ((dragAccumlativePosition - dragStartPosition).length > 0.1) {
      _mouseJoint?.setTarget(dragAccumlativePosition);
      dragStartPosition = dragAccumlativePosition;
    }

    // Don't continue passing the event
    super.onDragUpdate(event);
  }

  // 2
  @override
  void onDragEnd(DragEndEvent event) {
    _resetDragControls();

    // Don't continue passing the event.
    super.onDragEnd(event);
  }

  // 4
  @override
  void onDragCancel(DragCancelEvent event) {
    _resetDragControls();

    // Don't continue passing the event.
    super.onDragCancel(event);
  }

  // 5
  void _setupDragControls() {
    final mouseJointDef = MouseJointDef()
      ..bodyA = ground.body
      ..bodyB = body
      ..frequencyHz = 5.0
      ..dampingRatio = 0.9
      ..collideConnected = false
      ..maxForce = 2000.0 * body.mass;

    _mouseJoint = MouseJoint(mouseJointDef);
    world.createJoint(_mouseJoint!);
  }

  // 6
  void _resetDragControls() {
    dragAccumlativePosition = Vector2.zero();
    if (_mouseJoint != null) {
      world.destroyJoint(_mouseJoint!);
      _mouseJoint = null;
    }
  }

  void reset() {
    body.setTransform(position, angle);
    body.angularVelocity = 0.0;
    body.linearVelocity = Vector2.zero();
  }
}
