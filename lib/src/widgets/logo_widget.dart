import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/common/styles.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({super.key, this.seconds});
  final int? seconds;

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the animation
    Future.delayed(Duration(seconds: widget.seconds??2), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(seconds: widget.seconds??2),
      child: Text(
        AppLocalizations.of(context)!.appTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: white,
          fontSize: 30.0, // Adjust the font size as needed
          fontWeight: FontWeight.bold, // Make the text bold
          letterSpacing: 5,
          wordSpacing: 5,
          shadows: [
            Shadow(
              blurRadius: 4.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }
}