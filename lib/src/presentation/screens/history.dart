import 'package:daily_mcq/src/data/models/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repos/question.dart';
import '../../services/bloc/history/history_cubit.dart';
import '../../utils/global_themes.dart';
import '../widgets/my_snackbar.dart';

class HistoryScreen extends StatelessWidget {
  final QuestionType questionType;

  const HistoryScreen(this.questionType);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: primaryColor,
        ),
        title: Text('Response History'),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => HistoryCubit(),
        child: HistoryBuilder(questionType),
      ),
    );
  }
}

class HistoryBuilder extends StatefulWidget {
  final QuestionType questionType;

  const HistoryBuilder(this.questionType);
  @override
  _HistoryBuilderState createState() => _HistoryBuilderState();
}

class _HistoryBuilderState extends State<HistoryBuilder> {
  HistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    _historyCubit = BlocProvider.of<HistoryCubit>(context);
    _historyCubit.getHistory(widget.questionType);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: _historyCubit,
      builder: (context, state) {
        if (state is HistoryInitial) {
          return buildLoading();
        } else if (state is HistoryLoading) {
          return buildLoading();
        } else if (state is HistoryError) {
          Future.delayed(Duration(seconds: 2), () {
            Scaffold.of(context).showSnackBar(getMySnackBar(
              state.message,
              color: Colors.redAccent,
            ));
          });
          return buildLoading();
        } else if (state is HistoryLoaded) {
          List<History> history = state.history.history;
          history = List.from(history.reversed);

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: history.length,
            itemBuilder: (context, index) => ExpansionTile(
              leading: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor:
                    (history[index].correctAnswer == history[index].yourAnswer)
                        ? primaryColor
                        : Colors.redAccent,
                child: Icon(
                    (history[index].correctAnswer == history[index].yourAnswer)
                        ? Icons.done
                        : Icons.close),
              ),
              title: Text(
                history[index].question,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(history[index].marks.toString()),
              children: [
                ListTile(
                  title: Text('Your answer'),
                  subtitle: Text(history[index].yourAnswer),
                ),
                ListTile(
                  title: Text('Correct Answer'),
                  subtitle: Text(history[index].correctAnswer),
                ),
                ListTile(
                  title: Text('Marks awarded'),
                  subtitle: Text(history[index].marks.toString()),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
