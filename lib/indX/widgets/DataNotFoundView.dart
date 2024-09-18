import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/ThemeColor.dart';

class DataNotFoundView extends StatelessWidget {
  const DataNotFoundView({super.key, this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45,vertical: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/svg/data_not_found.svg"),
                Text(text,textAlign: TextAlign.center,style: const TextStyle(
                  color: gray_4,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  fontFamily: 'poppins'
                ))
              ]
          )
      ),
    );
  }


}