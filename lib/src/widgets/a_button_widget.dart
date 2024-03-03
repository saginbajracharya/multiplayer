import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/styles.dart';

class AButtonWidget extends StatefulWidget {
  const AButtonWidget({super.key, required this.btnText, required this.onPressed,this.child});
  final String btnText;
  final VoidCallback onPressed;
  final Widget? child; 

  @override
  State<AButtonWidget> createState() => _AButtonWidgetState();
}

class _AButtonWidgetState extends State<AButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: white),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return green.withOpacity(0.7); // Disabled color
              }
              return green.withOpacity(0.7); // Regular color
            },
          ),
        ),
        child: widget.child??Text(widget.btnText),
      ),
    );
  }
}