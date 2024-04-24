import 'package:space_shooter_game/main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Bullet({super.position})
      : super(
          size: Vector2(25, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'bullet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(8, 16),
      ),
    );

    add(
      RectangleHitbox(
        // active collides with other Hitboxes of type active or passive

        // passive collides with other Hitboxes of type active

        // inactive will not collide with any other Hitboxes
        collisionType: CollisionType.passive,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // We add to the bullet’s y axis position at a rate of -500 pixels per second.
    // Remember going up in the y axis means getting closer to 0 since the top left corner of the screen is 0, 0.

    position.y += dt * -500;

    // If the y is smaller than the negative value of the bullet’s height,
    // means that the component is completely off the screen and it can be removed.
    if (position.y < -height) {
      removeFromParent();
    }
  }
}
