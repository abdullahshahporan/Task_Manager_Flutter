import 'package:flutter/material.dart';
import 'package:t_manager/UI/widgets/center_circular_progress_indicator.dart';
import 'package:t_manager/UI/widgets/show_snack_bar.dart';
import 'package:t_manager/UI/widgets/task_card.dart';
import 'package:t_manager/data/models/network_responses.dart';
import 'package:t_manager/data/models/new_task_model.dart';
import 'package:t_manager/data/models/task_model.dart';
import 'package:t_manager/data/services/network_caller.dart';
import 'package:t_manager/data/utils/urls.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompeletedTaskListProgres= false;
  List<TaskModel> _completedTaskList=[];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_getCompeletedTaskListProgres,
      replacement:const CenterCircularProgressIndicator(),
      child: RefreshIndicator(
        onRefresh: () async{
          _getCompletedTaskList();
        },
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return TaskCard(
              taskModel: _completedTaskList[index],
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 8,
            );
          },
        ),
      ),
    );
  }
  Future<void> _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompeletedTaskListProgres=true;

    setState(() {});
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.completedTaskList);
    if (response.isSuccess) {
      final TaskListModel taskListModel =
      TaskListModel.fromJson(response.responseData);
      _completedTaskList = taskListModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
    _getCompeletedTaskListProgres=true;
    setState(() {});
  }
}
