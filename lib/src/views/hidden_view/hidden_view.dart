import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:multiplayer/src/common/styles.dart';

class HiddenView extends StatefulWidget {
  const HiddenView({super.key, this.versionText});
  final String? versionText;

  static const routeName = '/hidden_page';

  @override
  State<HiddenView> createState() => _HiddenViewState();
}

class _HiddenViewState extends State<HiddenView> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true); // Repeat the animation
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: _buildSunWithFlames(),
          ),
          Center(
            child: _buildStaticText(widget.versionText),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return CustomPaint(
          painter: WaveBackgroundPainter(_waveController.value),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }

  Widget _buildSunWithFlames() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return CustomPaint(
              painter: SunWithFlamesPainter(_rotationController.value),
              child: const SizedBox(
                width: 200,
                height: 200,
              ),
            );
          },
        ),
        Center(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              black.withOpacity(0.4), // Adjust the opacity value (0.0 to 1.0)
              BlendMode.srcATop,
            ),
            child: Image.asset(
              'assets/images/logo.png', // Replace with your actual logo asset path
              width: 270,
              height: 270,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStaticText(versionText) {
    return Container(
      width: 200,
      height: 200,
      alignment: Alignment.center,
      child: Text(
        versionText.toString(),
        style: const TextStyle(
          color: white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SunWithFlamesPainter extends CustomPainter {
  final double rotationValue;

  SunWithFlamesPainter(this.rotationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final sunPaint = Paint()
      ..color = grey900!.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    final flamePaint = Paint()
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    const int numFlames = 30;
    const double angleIncrement = 2 * math.pi / numFlames;
    final double initialAngle = rotationValue * 2 * math.pi;

    for (int i = 0; i < numFlames; i++) {
      final double angle = initialAngle + i * angleIncrement;

      final double startX = centerX + radius * math.cos(angle);
      final double startY = centerY + radius * math.sin(angle);

      final double endX = startX + 70 * math.cos(angle);
      final double endY = startY + 70 * math.sin(angle);

      final double controlX1 = startX + radius * 0.15 * math.cos(angle - angleIncrement / 4);
      final double controlY1 = startY + radius * 0.15 * math.sin(angle - angleIncrement / 4);

      final double controlX2 = startX + radius * 0.15 * math.cos(angle + angleIncrement / 4);
      final double controlY2 = startY + radius * 0.15 * math.sin(angle + angleIncrement / 4);

      final double flameWidth = i.isEven ? 8 : 12;
      final double flameHeight = i.isEven ? 20 : 40; // Adjust the heights here

      final Path flamePath = Path()
        ..moveTo(startX, startY)
        ..quadraticBezierTo(controlX1, controlY1, endX, endY)
        ..quadraticBezierTo(controlX2, controlY2, startX, startY);

      final Rect flameRect = Rect.fromCenter(
        center: Offset(startX, startY),
        width: flameWidth,
        height: flameHeight,
      );

      flamePaint.shader = const LinearGradient(
        colors: [orange, yellow],
      ).createShader(flameRect);

      canvas.drawPath(flamePath, flamePaint);
    }

    // Create a gradient for the middle circle
    final middleCircleGradient = RadialGradient(
      colors: [indigo.withOpacity(0.5), teal.withOpacity(0.5)],
    );
    final middleCirclePaint = Paint()
      ..shader = middleCircleGradient.createShader(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      );
    canvas.drawCircle(Offset(centerX, centerY), radius, middleCirclePaint);

    canvas.drawCircle(Offset(centerX, centerY), radius, sunPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WaveBackgroundPainter extends CustomPainter {
  final double animationValue;

  WaveBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final double hueShift = animationValue * 360.0 % 360.0; // Ensure hue is within [0, 360]
    final double yOffset = animationValue * size.height; // Vertical offset

    const gradientStart = Alignment(-1.0, 1.0);
    const gradientEnd = Alignment(1.0, -1.0);

    final shader = LinearGradient(
      colors: [
        HSLColor.fromAHSL(1.0, hueShift, 1.0, 0.5).toColor(),
        HSLColor.fromAHSL(1.0, (hueShift + 120.0) % 360.0, 1.0, 0.5).toColor(),
        HSLColor.fromAHSL(1.0, (hueShift + 240.0) % 360.0, 1.0, 0.5).toColor(),
        HSLColor.fromAHSL(1.0, (hueShift + 0.0) % 360.0, 1.0, 0.5).toColor(),
        HSLColor.fromAHSL(1.0, (hueShift + 60.0) % 360.0, 1.0, 0.5).toColor(),
      ],
      begin: gradientStart,
      end: gradientEnd,
      transform: const GradientRotation(math.pi / 4), // Counter-clockwise rotation
    ).createShader(Rect.fromLTWH(0, yOffset, size.width, size.height));

    final paint = Paint()..shader = shader;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}