import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DscTitleWidget extends StatelessWidget {
  const DscTitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SvgPicture.asset(
            "assets/images/dsc-logo-square.svg",
            height: 30,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 12,
              ),
              children: [
                TextSpan(text: 'Developer Student Clubs'),
                TextSpan(
                  text: '\nVellore Institute of Technology',
                  style: TextStyle(
                    fontSize: 7,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
