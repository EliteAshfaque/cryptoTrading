import 'package:flutter/material.dart';

import '../themes/AppTextTheme.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.heading = '',this.text = '',this.textColor = Colors.white, this.loadingColor});

  final String text,heading;
  final Color textColor;
  final Color? loadingColor;
  @override
  Widget build(BuildContext context) {

    return Container(
        padding: const EdgeInsets.all(16),
        /*color: Colors.black,*/
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              if(heading.isNotEmpty)...[
                _getHeading(context)
              ],
              _getText(context)
            ]
        )
    );
  }

  Padding _getLoadingIndicator() {
    return  Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: SizedBox(
            width: 32,
            height: 32,
            child: CircularProgressIndicator(
                strokeWidth: 3,
              color: loadingColor,
            )
        )
    );
  }

  Widget _getHeading(context) {
    return
      Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            heading,
            style: poppins(fontSize: 16,fontWeight: FontWeight.w600,color:Colors.white ),
            textAlign: TextAlign.center,
          )
      );
  }

  Text _getText(context) {
    return Text(
      text,
      style: poppins(fontSize: 14,fontWeight: FontWeight.w600,color:textColor ),
      textAlign: TextAlign.center,
    );
  }
}