import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multiplayer/src/views/game_view/doodle_dash.dart';
import 'package:multiplayer/src/widgets/a_button_widget.dart';
// import '../../settings/settings_view.dart';

// Overlay that appears for the main menu
class MainMenuOverlay extends StatefulWidget {
  const MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  Character character = Character.dash;

  @override
  Widget build(BuildContext context) {
    DoodleDash game = widget.game as DoodleDash;
    return LayoutBuilder(
      builder: (context, constraints) {
      final characterWidth = constraints.maxWidth / 5;
      final bool screenHeightIsSmall = constraints.maxHeight < 760;
      return Material(
        color: Theme.of(context).colorScheme.background,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20.0),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Select Character
                Text('Select your character:',style: Theme.of(context).textTheme.headlineSmall!),
                if (!screenHeightIsSmall) const WhiteSpace(height: 30),
                //Characters 
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2, // Number of columns
                  mainAxisSpacing: 10.0, // Spacing between items along the main axis
                  crossAxisSpacing: 10.0, // Spacing between items along the cross axis
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  children: [
                    for (var char in [Character.dash, Character.sparky])
                      CharacterButton(
                        character: char,
                        selected: character == char,
                        onSelectChar: () {
                          setState(() {
                            character = char;
                          });
                        },
                        characterWidth: characterWidth,
                      ),
                  ],
                ),
                if (!screenHeightIsSmall) const WhiteSpace(height: 50),
                Text('Difficulty:',style: Theme.of(context).textTheme.bodyLarge!),
                LevelPicker(
                  level: game.levelManager.selectedLevel.toDouble(),
                  label: game.levelManager.selectedLevel.toString(),
                  onChanged: ((value) {
                    setState(() {
                      game.levelManager.selectLevel(value.toInt());
                    });
                  }),
                ),
                if (!screenHeightIsSmall) const WhiteSpace(height: 50),
                AButtonWidget(
                  btnText: 'Start', 
                  onPressed:() async{
                    game.gameManager.selectCharacter(character);
                    game.startGame();
                  },
                ),
                AButtonWidget(
                  btnText: 'Back', 
                  onPressed:() async{
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class LevelPicker extends StatelessWidget {
  const LevelPicker({
    super.key,
    required this.level,
    required this.label,
    required this.onChanged,
  });

  final double level;
  final String label;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: level,
      max: 5,
      min: 1,
      divisions: 4,
      label: label,
      onChanged: onChanged,
    );
  }
}

class CharacterButton extends StatelessWidget {
  const CharacterButton(
  {
    super.key,
    required this.character,
    this.selected = false,
    required this.onSelectChar,
    required this.characterWidth
  });

  final Character character;
  final bool selected;
  final void Function() onSelectChar;
  final double characterWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: (selected)
      ? ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(31, 64, 195, 255)))
      : null,
      onPressed: onSelectChar,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/game/${character.name}_center.png',
              height: characterWidth,
              width: characterWidth,
            ),
            const WhiteSpace(height: 10),
            Text(
              character.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 100});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
