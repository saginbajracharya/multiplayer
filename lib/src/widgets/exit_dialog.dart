import 'package:flutter/material.dart';
import 'package:multiplayer/src/common/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExitDialog extends StatefulWidget {
  const ExitDialog({ Key? key ,required this.okCallback}) : super(key: key);

  final VoidCallback? okCallback;

  @override
  State<ExitDialog> createState() => _ExitDialogState();
}

class _ExitDialogState extends State<ExitDialog> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titleTextStyle: const TextStyle(fontSize: 14.0,color: black,fontWeight: FontWeight.bold),
      alignment: Alignment.center,
      contentPadding :const EdgeInsets.only(top:20.0,left: 10.0,right: 10.0,bottom: 5.0),
      title: Text(
        AppLocalizations.of(context)!.exitAppDialogText,
        style: const TextStyle(fontSize: 20.0,color: black,fontWeight: FontWeight.bold)
      ),
      titlePadding: const EdgeInsets.only(left: 10,right: 10,top: 20),
      backgroundColor: white,
      shape:  const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: widget.okCallback,
                  style: TextButton.styleFrom(
                    backgroundColor: white,
                    side: const BorderSide(color: white, width: 1), // Border properties
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Adjust the radius as needed
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.yes,style: const TextStyle(color: black,fontSize: 14))
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () async{
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: white,
                    side: const BorderSide(color: white, width: 1), // Border properties
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Adjust the radius as needed
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.no,style: const TextStyle(color: black,fontSize: 14),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}