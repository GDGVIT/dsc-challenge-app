import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../data/models/user.dart';
import '../../data/repos/question.dart';
import '../../services/bloc/sign_in/googlesignin_bloc.dart';
import '../../utils/global_themes.dart';
import '../widgets/dsc_title.dart';
import '../widgets/my_snackbar.dart';
import 'signup/signup_screen_goog.dart';

class ProfileScreen extends StatelessWidget {
  static const routename = "/profile";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GooglesigninBloc(),
      child: ProfileScreenBuilder(),
    );
  }
}

class ProfileScreenBuilder extends StatefulWidget {
  @override
  _ProfileScreenBuilderState createState() => _ProfileScreenBuilderState();
}

class _ProfileScreenBuilderState extends State<ProfileScreenBuilder> {
  UserClass user = UserClass.fromJson(Hive.box("userBox").get("user"));
  bool loading = false;
  TextEditingController _instaHandle;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _instaHandle = TextEditingController(text: user.instaHandle);
    super.initState();
    QuestionRepository.getQuestion(QuestionType.Weekly);
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
        title: DscTitleWidget(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 32,
          ),
          child: BlocListener<GooglesigninBloc, GooglesigninState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                setState(() {
                  loading = true;
                });
              } else if (state is InstaHandleUpdateSuccess) {
                Scaffold.of(context)
                    .showSnackBar(getMySnackBar("Insta handle updated"));
                setState(() {
                  loading = false;
                  user = UserClass.fromJson(Hive.box("userBox").get("user"));
                });
              } else if (state is InstaHandleUpdateFailed) {
                Scaffold.of(context).showSnackBar(getMySnackBar(
                  "Something went wrong",
                  color: Colors.redAccent,
                ));
                setState(() {
                  loading = false;
                });
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: "profile_pic",
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            NetworkImage(Hive.box("userBox").get("photo_url")),
                      ),
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
                            '${user.username}',
                            overflow: TextOverflow.ellipsis,
                            style: boldHeading.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    style: greyText.copyWith(
                      fontFamily: "Montserrat",
                    ),
                    children: [
                      TextSpan(
                        text: "Email: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: "${user.email}"),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: RichText(
                        text: TextSpan(
                          style: greyText.copyWith(
                            fontFamily: "Montserrat",
                          ),
                          children: [
                            TextSpan(
                              text: "Instagram: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "@${user.instaHandle ?? ""}",
                            )
                          ],
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    (loading)
                        ? CircularProgressIndicator()
                        : FlatButton(
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).canvasColor,
        elevation: 0,
        child: Padding(
          padding: EdgeInsets.all(32),
          child: RaisedButton(
            onPressed: () {
              GooglesigninBloc().add(Logout());
              Navigator.of(context).pushNamedAndRemoveUntil(
                  SignupScreen.routename, (route) => false);
            },
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

  addEditInstaHandle(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text('Add/Edit Instagram Handle'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _instaHandle,
            decoration: InputDecoration(
              filled: true,
              hintText: '@dscvitvellore',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: borderRadius8,
              ),
            ),
            validator: (val) {
              if (val.isEmpty) {
                return "This field is required";
              }
            },
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'CANCEL',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            textColor: primaryColor,
            onPressed: () => Navigator.maybePop(context),
          ),
          FlatButton(
            child: Text(
              'DONE',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            textColor: primaryColor,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  loading = true;
                });
                BlocProvider.of<GooglesigninBloc>(context).add(
                  UpdateInstaHandle(
                    handle: _instaHandle.text,
                  ),
                );
                Navigator.maybePop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
