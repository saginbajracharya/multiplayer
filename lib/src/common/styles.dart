import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

const white              = Colors.white;
const black              = Colors.black;
const blue               = Colors.blue;
const red                = Colors.red;
const yellow             = Colors.yellow;
const green              = Colors.green;
const transparent        = Colors.transparent;
const gold               = Color(0xFFD4AF37);
const backgroundColor    = Colors.black;
const Color orange       = Colors.orange;
const Color teal         = Colors.teal;
const Color indigo       = Colors.indigo;
const grey               = Colors.grey;

Color? grey200           = Colors.grey[200];
Color? grey300           = Colors.grey[300];
Color? grey400           = Colors.grey[400];
Color? grey500           = Colors.grey[500];
Color? grey600           = Colors.grey[600];
Color? grey700           = Colors.grey[700];
Color? grey800           = Colors.grey[800];
Color? grey900           = Colors.grey[900];

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