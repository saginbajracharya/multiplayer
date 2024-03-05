import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/styles.dart';

class AButtonWidget extends StatefulWidget {
  const AButtonWidget({super.key, required this.btnText, required this.onPressed,this.child,this.width,this.height,this.padding,this.buttonStyle});
  final String btnText;
  final VoidCallback onPressed;
  final Widget? child; 
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? buttonStyle;

  @override
  State<AButtonWidget> createState() => _AButtonWidgetState();
}

class _AButtonWidgetState extends State<AButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width??double.infinity,
      height: widget.height,
      padding: widget.padding??const EdgeInsets.symmetric(horizontal:20.0,vertical:10.0),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: widget.buttonStyle??ButtonStyle(
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