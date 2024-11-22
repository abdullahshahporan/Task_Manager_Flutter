import 'package:flutter/material.dart';
import 'package:t_manager/UI/screens/add_new_task_screen.dart';
import 'package:t_manager/UI/widgets/center_circular_progress_indicator.dart';
import 'package:t_manager/UI/widgets/show_snack_bar.dart';
import 'package:t_manager/UI/widgets/task_card.dart';
import 'package:t_manager/UI/widgets/task_summary_card.dart';
import 'package:t_manager/data/models/network_responses.dart';
import 'package:t_manager/data/models/new_task_model.dart';
import 'package:t_manager/data/models/task_model.dart';

import 'package:t_manager/data/services/network_caller.dart';
import 'package:t_manager/data/utils/urls.dart';


class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskListInProgress = false;
  List<TaskModel> _newTaskList=[];

  @override
  void initState()
  {
    super.initState();
    _getNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildSummarySection(),
          Expanded(
            child: Visibility(
              visible: !_getNewTaskListInProgress,
              replacement:const CenterCircularProgressIndicator(),
              child: ListView.separated(
                itemCount: _newTaskList.length,
                itemBuilder: (context, index) {
                  return  TaskCard();
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapFABButton,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummarySection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(
              count: 09,
              title: 'New',
            ),
            TaskSummaryCard(
              count: 09,
              title: 'Completed',
            ),
            TaskSummaryCard(
              count: 09,
              title: 'Cancelled',
            ),
            TaskSummaryCard(
              count: 09,
              title: 'Progress',
            ),
          ],
        ),
      ),
    );
  }

  void _onTapFABButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskListInProgress = true;
    setState(() {});
    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.newTaskList);
    if(response.isSuccess)
      {
    final TaskListModel taskListModel = TaskListModel.fromJson(response.responseData);
    _newTaskList=taskListModel.taskList ?? [];
      }
    else
      {
        showSnackBarMessage(context, response.errorMessage,true);
      }
_getNewTaskListInProgress=false;
    setState(() {

    });

  }
}
