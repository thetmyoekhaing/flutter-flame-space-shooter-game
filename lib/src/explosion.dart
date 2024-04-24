import 'package:space_shooter_game/main.dart';
import 'package:flame/components.dart';

class Explosion extends SpriteAnimationComponent
    with HasGameReference<SpaceShooterGame> {
  Explosion({
    super.position,
  }) : super(
          size: Vector2.all(150),
          anchor: Anchor.center,
          removeOnFinish: true,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'explosion.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: .1,
        textureSize: Vector2.all(32),
        loop: false,
      ),
    );
  }
}
