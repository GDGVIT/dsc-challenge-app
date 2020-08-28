import 'package:flutter/material.dart';

import '../../data/models/leaderboard.dart';
import '../../utils/global_themes.dart';
import '../widgets/dsc_title.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Result> result;

  const LeaderboardScreen({
    Key key,
    @required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: primaryColor,
        ),
        elevation: 0,
        title: DscTitleWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Hero(
          tag: 'leaderboard',
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius8,
            ),
            elevation: 2.3,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Scrollbar(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Leaderboard',
                          style: boldHeading,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ListTile(
                            leading: Text("${result[index].position}"),
                            title: Text(result[index].username),
                            trailing: Text("${result[index].marks.floor()}"),
                          );
                        },
                        childCount: result.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
