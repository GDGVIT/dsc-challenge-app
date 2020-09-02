import 'package:daily_mcq/src/presentation/screens/leaderboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';

import '../../data/models/leaderboard.dart';
import '../../services/bloc/leaderboard/leaderboard_cubit.dart';
import '../../utils/global_themes.dart';
import '../widgets/dsc_title.dart';
import '../widgets/my_snackbar.dart';
import '../widgets/show_up.dart';
import 'daily_challenge/new_challenge.dart';
import 'profile_screen.dart';
import 'weekly_challenge/new_challenge.dart';

class HomeScreen extends StatelessWidget {
  static const routename = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocProvider(
        create: (context) => LeaderboardCubit(),
        child: HomescreenBuilder(),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Row(
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
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.05,
                  minWidth: MediaQuery.of(context).size.height * 0.05,
                ),
                child: CircleAvatar(
                  // radius: 30,
                  backgroundImage:
                      NetworkImage(Hive.box("userBox").get("photo_url")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomescreenBuilder extends StatefulWidget {
  @override
  _HomescreenBuilderState createState() => _HomescreenBuilderState();
}

class _HomescreenBuilderState extends State<HomescreenBuilder> {
  LeaderboardCubit _leaderboardCubit;
  List<Result> result;

  @override
  void initState() {
    super.initState();
    _leaderboardCubit = BlocProvider.of<LeaderboardCubit>(context);

    _leaderboardCubit.getLeaderboard();
  }

  final svgAssets = [
    SvgPicture.asset(
      "assets/images/noun_trophy.svg",
      height: 24,
      color: Colors.yellow[700],
    ),
    SvgPicture.asset(
      "assets/images/noun_trophy.svg",
      height: 24,
      color: Colors.grey,
    ),
    SvgPicture.asset(
      "assets/images/noun_trophy.svg",
      height: 24,
      color: Colors.lime[900],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ShowUp(
              delay: Duration(milliseconds: 200),
              child: Hero(
                tag: 'leaderboard',
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius8,
                  ),
                  elevation: 2.3,
                  child: InkWell(
                    borderRadius: borderRadius8,
                    onTap: () {
                      setState(() {});
                      if (_leaderboardCubit.state is LeaderboardSuccess) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              LeaderboardScreen(result: result),
                        ));
                      }
                    },
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
                          BlocBuilder<LeaderboardCubit, LeaderboardState>(
                            cubit: _leaderboardCubit,
                            builder: (context, state) {
                              if (state is LeaderboardLoading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is LeaderboardSuccess) {
                                result = state.leaderboard.result;
                                return _buildLeaderboard(result);
                              } else if (state is LeaderboardError) {
                                Scaffold.of(context).showSnackBar(getMySnackBar(
                                  state.message,
                                  color: Colors.redAccent,
                                ));
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildDailyChallengeButton(context),
            SizedBox(
              height: 20,
            ),
            _buildWeeklyChallengeButton(context),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  ShowUp _buildWeeklyChallengeButton(BuildContext context) {
    return ShowUp(
      delay: Duration(milliseconds: 400),
      child: Hero(
        tag: 'weekly_challenge_new',
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius8,
          ),
          elevation: 2.3,
          child: InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(NewWeeklyChallengeScreen.routename);
            },
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
    );
  }

  ShowUp _buildDailyChallengeButton(BuildContext context) {
    return ShowUp(
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
    );
  }

  ConstrainedBox _buildLeaderboard(List<Result> result) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: result.length < 3
            ? double.parse(
                "${result.length * 60}",
              )
            : double.parse("${3 * 60}"),
      ),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: result.length < 3 ? result.length : 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: svgAssets[index],
            title: Text(result[index].username),
            trailing: Text(
              result[index].marks.floor().toString(),
            ),
          );
        },
      ),
    );
  }
}
