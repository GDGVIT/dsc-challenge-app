import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../services/bloc/sign_in/googlesignin_bloc.dart';
import '../../../utils/global_themes.dart';
import '../../widgets/my_snackbar.dart';
import '../home_screen.dart';

class AddInstagramHandleScreen extends StatelessWidget {
  static const routename = "/add-insta";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GooglesigninBloc(),
      child: InstaBuilderScreen(),
    );
  }
}

class InstaBuilderScreen extends StatefulWidget {
  @override
  _InstaBuilderScreenState createState() => _InstaBuilderScreenState();
}

class _InstaBuilderScreenState extends State<InstaBuilderScreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _instaHandle = TextEditingController();
  GooglesigninBloc bloc;
  bool disabled = false;

  @override
  void initState() {
    bloc = BlocProvider.of<GooglesigninBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
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
        body: BlocConsumer<GooglesigninBloc, GooglesigninState>(
          cubit: bloc,
          listener: (context, state) {
            if (state is LoginLoading) {
              setState(() {
                disabled = true;
              });
            } else if (state is InstaHandleUpdateSuccess) {
              Scaffold.of(context)
                  .showSnackBar(getMySnackBar("Insta handle updated"));
              setState(() {
                disabled = false;
              });
              Future.delayed(Duration(milliseconds: 1500), () {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routename);
              });
            } else if (state is InstaHandleUpdateFailed) {
              Scaffold.of(context).showSnackBar(getMySnackBar(
                "Something went wrong",
                color: Colors.redAccent,
              ));
              setState(() {
                disabled = false;
              });
            }
          },
          builder: (context, state) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(32),
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
                        controller: _instaHandle,
                        decoration: InputDecoration(
                          hintText: ' @username',
                          contentPadding: EdgeInsets.all(8),
                          prefixIconConstraints:
                              BoxConstraints.tight(Size(32, 32)),
                          prefixIcon: Container(
                            margin: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Image.network(
                              "https://cdn2.iconfinder.com/data/icons/social-icons-grey/512/INSTAGRAM-512.png",
                              // height: 34,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "This field is required. You can also add it later. Press skip to continue";
                          }
                        },
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
                            onPressed: (disabled)
                                ? null
                                : () {
                                    Navigator.of(context).pushReplacementNamed(
                                        HomeScreen.routename);
                                  },
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          RaisedButton(
                            child: Text('Continue'),
                            textColor: Colors.white,
                            onPressed: (disabled)
                                ? null
                                : () {
                                    FocusScope.of(context).unfocus();
                                    if (_formkey.currentState.validate()) {
                                      bloc.add(UpdateInstaHandle(
                                        handle: _instaHandle.text,
                                      ));
                                    }
                                  },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      (disabled) ? LinearProgressIndicator() : Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
