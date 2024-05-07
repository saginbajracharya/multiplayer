// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/constant.dart';
import './doodle_dash.dart';

class WorldView extends ParallaxComponent<DoodleDash> {
  @override
  Future<void> onLoad() async {
    parallax = await game.loadParallax(
      [
        ParallaxImageData(AssetImages.parallexSolidBg),
        ParallaxImageData(AssetImages.parallexSmallStarsBg),
        ParallaxImageData(AssetImages.parallexBigStarsBg),
        ParallaxImageData(AssetImages.parallexOrbsBg),
        ParallaxImageData(AssetImages.parallexBlockShapesBg),
        ParallaxImageData(AssetImages.parallexSquigglesBg),
      ],
      fill: LayerFill.width,
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(0, -5),
      velocityMultiplierDelta: Vector2(0, 1.2),
    );
  }
}