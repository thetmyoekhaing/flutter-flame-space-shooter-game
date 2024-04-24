import 'dart:async';

import 'package:space_shooter_game/main.dart';
import 'package:space_shooter_game/src/bullet.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef<SpaceShooterGame> {
  Player()
      : super(
          size: Vector2(100, 150),
          anchor: Anchor.center,
        );

  late final SpawnComponent _bulletSpawner;

  @override
  FutureOr<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      "player.png",

      /// sequenced constructor, which is a helper to load animation images
      /// where the frames are already layed down
      /// in the sequence
      ///
      ///

      // amount defines how many frames the animation has, in this case 4

      // stepTime is the time in seconds that each frame will be rendered, before it gets replaced with the next one.

      // textureSize is the size in pixels which defines each frame of the image.

      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: .2,
        textureSize: Vector2(32, 48),
      ),
    );
    position = gameRef.size / 2;

    _bulletSpawner = SpawnComponent(
      // period, we set how much time in seconds it will take between calls,
      // and we choose .2 seconds for now.
      period: .2,
      // We set selfPositioning: true
      // so the spawn component don’t try to position the created component itself
      // since we want to handle that ourselves to make the bullets spawn out of the ship.
      selfPositioning: true,
      // The factory attribute receives a function that will be called every time the period is reached.
      // and must return the create component.
      factory: (index) {
        return Bullet(
          position: position +
              Vector2(
                0,
                -height / 2,
              ),
        );
      },
      autoStart: false,
    );

    game.add(_bulletSpawner);

    return super.onLoad();
  }

  void move(Vector2 delta) {
    position.add(delta);
  }

  void startShooting() {
    _bulletSpawner.timer.start();
  }

  void stopShooting() {
    _bulletSpawner.timer.stop();
  }
}
