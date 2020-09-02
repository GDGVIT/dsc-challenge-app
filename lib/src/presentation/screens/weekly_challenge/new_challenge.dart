import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/question.dart';
import '../../../data/repos/question.dart';
import '../../../services/bloc/question/question_bloc.dart';
import '../../../utils/global_themes.dart';
import '../../widgets/dsc_title.dart';
import '../../widgets/my_snackbar.dart';
import '../history.dart';

class NewWeeklyChallengeScreen extends StatelessWidget {
  static const routename = "/new-weekly-challenge";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: primaryColor,
          ),
          elevation: 0,
          title: DscTitleWidget(),
          actions: [
            IconButton(
              color: primaryColor,
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return HistoryScreen(QuestionType.Weekly);
                  },
                ));
              },
            ),
          ],
        ),
        body: NewWeeklyChallengeBuilder(),
      ),
    );
  }
}

class NewWeeklyChallengeBuilder extends StatefulWidget {
  @override
  _NewWeeklyChallengeBuilderState createState() =>
      _NewWeeklyChallengeBuilderState();
}

class _NewWeeklyChallengeBuilderState extends State<NewWeeklyChallengeBuilder> {
  QuestionBloc _questionBloc;
  TextEditingController _answerController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  bool _loading = false;
  Question _question;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _questionBloc = BlocProvider.of<QuestionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionBloc, QuestionState>(
      cubit: _questionBloc,
      buildWhen: (previous, current) {
        if (previous is QuestionLoading && current is GetWeeklyQuestionSucess) {
          return true;
        }
        if (previous is QuestionLoading && current is GetWeeklyQuestionError) {
          return true;
        }
        if (previous is QuestionInitial && current is QuestionLoading) {
          return false;
        }
        return false;
      },
      listener: (context, state) {
        if (state is PostQuestionSuccess) {
          setState(() {
            _loading = false;
          });
          Scaffold.of(context)
              .showSnackBar(getMySnackBar("Answer submitted successfully"));
        } else if (state is PostQuestionFailure) {
          setState(() {
            _loading = false;
          });
          Scaffold.of(context).showSnackBar(
            getMySnackBar(
              "Answer updated",
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is QuestionInitial) {
          _questionBloc.add(GetWeeklyQuestion());
          return buildLoading(context);
        } else if (state is QuestionLoading) {
          return buildLoading(context);
        } else if (state is GetWeeklyQuestionSucess) {
          _question = state.question;
          return buildUI(context, state.question);
        } else if (state is GetWeeklyQuestionError) {
          Future.delayed(Duration(seconds: 2), () {
            Scaffold.of(context).showSnackBar(getMySnackBar(
              state.message,
              color: Colors.redAccent,
            ));
          });
          return buildLoading(context);
        }
        return Container();
      },
    );
  }

  Widget buildUI(BuildContext context, Question question) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 16),
        padding: EdgeInsets.all(16),
        child: Hero(
          tag: 'weekly_challenge_new',
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          'Weekly Challenge',
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
                        SizedBox(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              // border: Border.all(color: Colors.grey),
                              color: Colors.grey[100],
                            ),
                            child: Text(
                              // "",
                              "${DateFormat.yMMMEd().format(question.question.displayDate)}",
                              style: greyText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${question.question.questionBody}",
                            style: greyText.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Your Project Link*',
                            style: boldHeading.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _answerController,
                          minLines: 1,
                          maxLines: 2,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true,
                          ),
                          decoration: InputDecoration(
                            hintText: "paste your link here",
                            border: OutlineInputBorder(
                              borderRadius: borderRadius8,
                              borderSide: BorderSide(
                                color: Colors.grey[100].withOpacity(0.1),
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "link is required";
                            } else if (value.contains(" ")) {
                              return "link cannot contain spaces";
                            } else if (!value.contains(RegExp(
                                r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+'))) {
                              return "not a valid link";
                            }
                          },
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
                        TextFormField(
                          controller: _descriptionController,
                          minLines: 1,
                          maxLines: 2,
                          toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            paste: true,
                            selectAll: true,
                          ),
                          decoration: InputDecoration(
                            hintText: "a short description about your project",
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
                        (_loading)
                            ? CircularProgressIndicator()
                            : Container(
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
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        _loading = true;
                                      });
                                      print(question.question.id);
                                      _questionBloc.add(
                                        PostQuestion(
                                          questionType: QuestionType.Weekly,
                                          id: _question.question.id,
                                          answer: _answerController.text,
                                          description:
                                              _descriptionController.text,
                                        ),
                                      );
                                    }
                                  },
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

  Widget buildLoading(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 16),
        padding: EdgeInsets.all(16),
        child: Hero(
          tag: 'weekly_challenge_new',
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
                        'Weekly Challenge',
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
                      SizedBox(
                        height: 20,
                      ),
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Your Project Link*',
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
                        enabled: false,
                        minLines: 1,
                        maxLines: 2,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "paste your link here",
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
                        enabled: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          hintText: "a short description about your project",
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
                          onPressed: null,
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
    );
  }
}
