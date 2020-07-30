import 'package:daily_mcq/screens/signup/instagram_handle.dart';
import 'package:daily_mcq/services/bloc/sign_in/googlesignin_bloc.dart';
import 'package:daily_mcq/utils/global_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatelessWidget {
  static const routename = "/signup";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GooglesigninBloc(),
      child: SignupScreenBuilder(),
    );
  }
}

class SignupScreenBuilder extends StatefulWidget {
  @override
  _SignupScreenBuilderState createState() => _SignupScreenBuilderState();
}

class _SignupScreenBuilderState extends State<SignupScreenBuilder> {
  GooglesigninBloc _googlesigninBloc;

  @override
  void initState() {
    _googlesigninBloc = BlocProvider.of<GooglesigninBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _googlesigninBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<GooglesigninBloc, GooglesigninState>(
          cubit: _googlesigninBloc,
          listener: (context, state) {
            if (state is Authenticated) {
              final snackbar = SnackBar(
                elevation: 0.5,
                content: Text(
                  'Login Successful',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: primaryColor,
              );
              Scaffold.of(context).showSnackBar(snackbar);
              Future.delayed(
                Duration(seconds: 1),
                () => Navigator.of(context)
                    .pushReplacementNamed(AddInstagramHandleScreen.routename),
              );
            } else if (state is Unauthenticated) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => AlertDialog(
                  title: Text('Error'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  content: Text(state.message),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('UNDERSTOOD'),
                      textColor: primaryColor,
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
              );
            }
          },
          child: buildUI(context),
        ),
      ),
    );
  }

  Widget buildUI(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/dsc-logo-square.svg",
                height: 108,
              ),
              SizedBox(
                width: 20,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 36,
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
          SizedBox(
            height: 20,
          ),
          Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.8,
            child: RaisedButton(
              onPressed: () {
                _googlesigninBloc.add(Login());
                print("logged in");
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadiusButton,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Login with Google'),
                  SizedBox(
                    width: 20,
                  ),
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1004px-Google_%22G%22_Logo.svg.png",
                    fit: BoxFit.contain,
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
