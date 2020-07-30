import 'package:daily_mcq/screens/home_screen.dart';
import 'package:daily_mcq/utils/global_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddInstagramHandleScreen extends StatefulWidget {
  static const routename = "/add-insta";

  @override
  _AddInstagramHandleScreenState createState() =>
      _AddInstagramHandleScreenState();
}

class _AddInstagramHandleScreenState extends State<AddInstagramHandleScreen> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        title: Row(
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
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          // alignment: Alignment.center,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Enter your Intstagram handle',
                  textAlign: TextAlign.center,
                  style: bigText,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: '@username',
                    contentPadding: EdgeInsets.all(8),
                    prefixIconConstraints: BoxConstraints.tight(Size(24, 24)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Image.network(
                        "https://cdn2.iconfinder.com/data/icons/instagram-new/512/instagram-logo-color-512.png",
                        height: 32,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text('Skip'),
                      textColor: primaryColor,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routename);
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RaisedButton(
                      child: Text('Continue'),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routename);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
