import 'package:daily_mcq/src/presentation/widgets/dsc_title.dart';
import 'package:daily_mcq/src/utils/global_themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewDailyChallengeScreen extends StatelessWidget {
  static const routename = "/new-daily-challenge";
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
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          child: Hero(
            tag: 'daily_challenge_new',
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius8.add(BorderRadius.circular(3)),
              ),
              elevation: 2.3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CupertinoScrollbar(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          'Daily Challenge',
                          style: boldHeading,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Question',
                            style: boldHeading.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nibh sit amet commodo nulla. Egestas diam in arcu cursus euismod quis viverra. Turpis cursus in hac habitasse. Vulputate ut pharetra sit amet aliquam. Ac feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper. Est sit amet facilisis magna etiam tempor. Vulputate eu scelerisque felis imperdiet proin fermentum leo vel. Nunc non blandit massa enim nec dui nunc mattis. Sit amet massa vitae tortor. Lobortis elementum nibh tellus molestie nunc. Sed augue lacus viverra vitae congue eu consequat. Massa eget egestas purus viverra accumsan in. Proin fermentum leo vel orci porta non pulvinar neque laoreet. Tempus imperdiet nulla malesuada pellentesque elit eget gravida. Tortor aliquam nulla facilisi cras fermentum odio eu feugiat. Ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at augue eget. Nisl tincidunt eget nullam non nisi. Fermentum leo vel orci porta non pulvinar neque laoreet suspendisse. Orci eu lobortis elementum nibh tellus.

Dignissim sodales ut eu sem. Sapien pellentesque habitant morbi tristique senectus et. Euismod quis viverra nibh cras pulvinar. Id cursus metus aliquam eleifend mi in nulla posuere sollicitudin. Dictum sit amet justo donec. Risus nullam eget felis eget nunc lobortis mattis. Et malesuada fames ac turpis egestas maecenas pharetra. Egestas egestas fringilla phasellus faucibus scelerisque. Tortor pretium viverra suspendisse potenti nullam ac. Nunc aliquet bibendum enim facilisis gravida neque convallis.
                                    """,
                          style: greyText.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Your Answer*',
                            style: boldHeading.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          minLines: 1,
                          maxLines: 2,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true,
                          ),
                          decoration: InputDecoration(
                            hintText: "Give a short answer",
                            border: OutlineInputBorder(
                              borderRadius: borderRadius8,
                              borderSide: BorderSide(
                                color: Colors.grey[100].withOpacity(0.1),
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Extra Description',
                            style: boldHeading.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          minLines: 1,
                          maxLines: 2,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true,
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: borderRadius8,
                              borderSide: BorderSide(
                                color: Colors.grey[100].withOpacity(0.1),
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: RaisedButton(
                            elevation: 0,
                            child: Text(
                              'SUBMIT',
                              style: boldHeading.copyWith(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
