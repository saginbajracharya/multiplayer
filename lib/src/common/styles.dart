import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

const white           = Colors.white;
const black           = Colors.black;
const grey            = Colors.grey;
const blue            = Colors.blue;
const red             = Colors.red;
const yellow          = Colors.yellow;
const green           = Colors.green;
const transparent     = Colors.transparent;
const gold            = Color(0xFFD4AF37);
const backgroundColor = Colors.black;

ThemeData lightTheme = ThemeData(
  useMaterial3:true,
  applyElevationOverlayColor: false,
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0.0
  ),
  scaffoldBackgroundColor: backgroundColor,
  // Use the colorScheme property to set the background color in light and dark themes
  colorScheme: ColorScheme.fromSwatch().copyWith(background: transparent),
  // Use the canvasColor property to set the background color in light and dark themes for certain elements like the Drawer
  canvasColor: transparent,
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  applyElevationOverlayColor: false,
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0.0
  ),
  scaffoldBackgroundColor: backgroundColor,
  // Use the colorScheme property to set the background color in light and dark themes
  colorScheme: ColorScheme.fromSwatch().copyWith(background: transparent),
  // Use the canvasColor property to set the background color in light and dark themes for certain elements like the Drawer
  canvasColor: transparent,
);

Gradient skyGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.blue[200]!,
    Colors.blue[400]!,
    Colors.blue[600]!,
    Colors.blue[800]!,
  ],
);

final List<List<Color>> _gradientColors = [
  GradientColors.blue,
  GradientColors.coolBlues,
  GradientColors.pink,
  GradientColors.orange,
  GradientColors.indigo,
  GradientColors.alchemistLab,
  GradientColors.almost,
  GradientColors.amour,
  GradientColors.amyCrisp,
  GradientColors.aubergine,
  GradientColors.awesomePine,
  GradientColors.beautifulGreen,
  GradientColors.bigMango,
  GradientColors.black,
  GradientColors.blackGray,
  GradientColors.blessingGet,
  GradientColors.bloodyMary
  // Add more gradient colors as needed
];

List<Color> getRandomGradientColors() {
  final Random random = Random();
  return _gradientColors[random.nextInt(_gradientColors.length)];
}