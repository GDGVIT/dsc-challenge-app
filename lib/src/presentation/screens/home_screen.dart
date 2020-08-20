import 'package:daily_mcq/src/presentation/screens/daily_challenge/new_challenge.dart';
import 'package:daily_mcq/src/presentation/widgets/dsc_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';

import '../../utils/global_themes.dart';
import '../widgets/show_up.dart';
import 'profile_screen.dart';

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
              DscTitleWidget(),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                    fullscreenDialog: true,
                  ),
                ),
                child: Hero(
                  tag: "profile_pic",
                  child: CircleAvatar(
                    // radius: 30,
                    backgroundImage:
                        NetworkImage(Hive.box("userBox").get("photo_url")),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ShowUp(
                delay: Duration(milliseconds: 200),
                child: Card(
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
              ),
              SizedBox(
                height: 20,
              ),
              ShowUp(
                delay: Duration(milliseconds: 300),
                child: Hero(
                  tag: 'daily_challenge_new',
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: borderRadius8,
                    ),
                    elevation: 2.3,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(NewDailyChallengeScreen.routename);
                      },
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
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ShowUp(
                delay: Duration(milliseconds: 400),
                child: Card(
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
