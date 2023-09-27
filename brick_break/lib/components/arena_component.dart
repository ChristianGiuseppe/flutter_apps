import 'package:brickbreak/world/forge_2d_game_world.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class ArenaComponent extends BodyComponent<Forge2dGameWorld> {
  ArenaComponent({this.size})
      : assert(size == null || size.x >= 1.0, size.y <= 1.0);
  Vector2? size;
  late Vector2 arenaSize;

  //viene chiamato prima createBodyper consentire qualsiasi inizializzazione che potrebbe essere necessario eseguire. Qui ottieni la dimensione dell'area visibile nelle coordinate mondiali di Forge2D.
  @override
  Future<void> onLoad() {
    arenaSize = size ?? game.size;
    return super.onLoad();
  }

  @override
  Body createBody() {
    final bodyRef = BodyDef()
      ..position = Vector2(0, 0)
      ..type = BodyType.static;

    final arenaBody = world.createBody(bodyRef);

    final vertices = <Vector2>[
      arenaSize,
      Vector2(0, arenaSize.y),
      Vector2(0, 0),
      Vector2(arenaSize.x, 0),
    ];

    final chain = ChainShape()..createLoop(vertices);

    for (var index = 0; index < chain.childCount; index++) {
      arenaBody.createFixture(FixtureDef(chain.childEdge(index))
        ..density = 2000.0 //densitià del muro o di 2.000 kg/m^2
        ..friction = 0.0 //è priva di attrito
        ..restitution = 0.4); //la parete ha un rinculo elastico del 40%
    }

    return arenaBody;
  }
}
