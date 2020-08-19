import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'profile_screen.dart';
import '../../utils/global_themes.dart';

class HomeScreen extends StatelessWidget {
  static const routename = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: Container(
          padding: EdgeInsets.all(16),
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
          child: Row(
            children: <Widget>[
              // SvgPicture.asset(
              //   "assets/images/dsc-logo-square.svg",
              //   height: 48,
              // ),
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
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                    fullscreenDialog: true,
                  ),
                ),
                child: CircleAvatar(
                  radius: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius8,
                ),
                elevation: 2.3,
                child: InkWell(
                  borderRadius: borderRadius8,
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 32,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Leaderboard',
                          style: boldHeading,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('1'),
                              ],
                            ),
                            Text('Lorem'),
                            Text('100'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('1'),
                              ],
                            ),
                            Text('Lorem'),
                            Text('100'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('1'),
                              ],
                            ),
                            Text('Lorem'),
                            Text('100'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('1'),
                              ],
                            ),
                            Text('Lorem'),
                            Text('100'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius8,
                ),
                elevation: 2.3,
                child: InkWell(
                  onTap: () {},
                  borderRadius: borderRadius8,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 48,
                      horizontal: 32,
                    ),
                    child: Text(
                      'Daily Challenge',
                      style: boldHeading,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius8,
                ),
                elevation: 2.3,
                child: InkWell(
                  onTap: () {},
                  borderRadius: borderRadius8,
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 48,
                      horizontal: 32,
                    ),
                    child: Text(
                      'Weekly Challenge',
                      style: boldHeading,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
