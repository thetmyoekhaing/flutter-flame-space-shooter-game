import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:space_shooter_game/src/enemy.dart';
import 'package:space_shooter_game/src/player.dart';

class SpaceShooterGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Player player;

  @override
  FutureOr<void> onLoad() async {
    final parallax = await loadParallaxComponent(
      [
        ParallaxImageData('stars.png'),
      ],
      // baseVelocity is the base value for all the values,
      // so by passing a Vector2(0, -5) to it means that
      // the slower of the layers will move at 0 pixels per second
      // on the x axis and -5 pixels per second on the y axis.
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      // velocityMultiplierDelta is a vector that is applied to the base value for each layer,
      // and in our example the multiplication rate is 5 on only the y axis.
      velocityMultiplierDelta: Vector2(0, 5),
    );
    add(parallax);

    player = Player();

    add(player);

    add(
      SpawnComponent(
        factory: (amount) {
          return Enemy();
        },
        period: 1,
        // area defines the possible area where the components can be placed once created.
        // In our case they should be placed in the area above the screen top,
        // so they can be seen as they are arriving into the playable area.
        area: Rectangle.fromLTWH(0, 0, size.x, -Enemy.enemySize),
      ),
    );
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
    super.onPanUpdate(info);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.startShooting();
    super.onPanStart(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stopShooting();
    super.onPanEnd(info);
  }
}

void main() {
  runApp(GameWidget(game: SpaceShooterGame()));
}
