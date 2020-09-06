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
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            color: Theme.of(context).canvasColor,
            disabledColor: Theme.of(context).canvasColor,
            onPressed: null,
          )
        ],
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
              // padding: EdgeInsets.all(16),
              child: Scrollbar(
                child: CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                      sliver: SliverToBoxAdapter(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Leaderboard',
                            style: boldHeading,
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      sliver: SliverList(
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
