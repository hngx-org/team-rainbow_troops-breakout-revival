import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Paddle extends BodyComponent with DragCallbacks {
  final Size size;
  final BodyComponent ground;
  final Vector2 paddlePosition;

  Paddle({
    required this.size,
    required this.ground,
    required this.paddlePosition,
  });

  MouseJoint? _mouseJoint;
  Vector2 dragStartPosition = Vector2.zero();
  Vector2 dragAccumlativePosition = Vector2.zero();

  @override
  void onMount() {
    super.onMount();
    final worldAxis = Vector2(1.0, 0.0);

    final travelEvent = (game.size.x / 2) - (size.width / 2.0);

    final jointDef = PrismaticJointDef()
      ..enableLimit = true
      ..lowerTranslation = -travelEvent
      ..upperTranslation = travelEvent
      ..collideConnected = true;

    jointDef.initialize(body, ground.body, body.worldCenter, worldAxis);
    final joint = PrismaticJoint(jointDef);
    world.createJoint(joint);
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (_mouseJoint != null) {
      dragStartPosition = event.localPosition.gg;
    }
    _setupDragControls();

    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    dragAccumlativePosition += event.delta.xx;
    if ((dragAccumlativePosition - dragStartPosition).length > 0.1) {
      _mouseJoint?.setTarget(dragAccumlativePosition);
      dragStartPosition = dragAccumlativePosition;
    }

    super.onDragUpdate(event);
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _resetDragControls();
    super.onDragEnd(event);
  }

  @override
  void onDragCancel(DragCancelEvent event) {
    _resetDragControls();
    super.onDragCancel(event);
  }

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

  void _resetDragControls() {
    dragAccumlativePosition = Vector2.zero();
    if (_mouseJoint != null) {
      world.destroyJoint(_mouseJoint!);
      _mouseJoint = null;
    }
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = paddlePosition
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
      ..restitution = 1.0
      ..friction = 0.0);

    return paddleBody;
  }
}
