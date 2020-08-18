import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

import '../../utils/global_themes.dart';

class ProfileScreen extends StatelessWidget {
  static const routename = "/profile";

  addEditInstaHandle(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text('Add/Edit Instagram Handle'),
        content: TextField(
          decoration: InputDecoration(
            filled: true,
            hintText: '@dscvitvellore',
            hintStyle: TextStyle(
              color: primaryColor,
            ),
            fillColor: primaryColor.withOpacity(0.2),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: borderRadius10,
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('CANCEL'),
            textColor: primaryColor,
            onPressed: () => Navigator.maybePop(context),
          ),
          FlatButton(
            child: Text('DONE'),
            textColor: primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.maybePop(context),
          )
        ],
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    // child: SvgPicture.asset(
                    //   "assets/images/dsc-logo-square.svg",
                    //   height: 100,
                    // ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Siddhartha Varma',
                          overflow: TextOverflow.ellipsis,
                          style: boldHeading.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Score: 000')
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Email: siddverma999@gmail.com",
                style: greyText,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                "Leaderboard: 0",
                style: greyText,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Text(
                      "Instagram: @handledfnkdnfsdfnsklnfskldnkld",
                      style: greyText,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FlatButton(
                    child: Text('Edit'),
                    textColor: primaryColor,
                    onPressed: () => addEditInstaHandle(context),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).canvasColor,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: RaisedButton(
            onPressed: () {},
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text('LOGOUT'),
            ),
            textColor: Colors.white,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}
