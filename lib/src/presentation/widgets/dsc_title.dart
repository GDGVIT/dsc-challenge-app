import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DscTitleWidget extends StatelessWidget {
  const DscTitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          "assets/images/dsc-logo-square.svg",
          height: 48,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 24,
            ),
            children: [
              TextSpan(text: 'DSC '),
              TextSpan(
                text: 'VIT',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
