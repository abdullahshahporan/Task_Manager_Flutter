import 'package:flutter/material.dart';
import 'package:t_manager/UI/utils/app_color.dart';
import 'package:t_manager/data/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key, required this.taskModel,
  });
final TaskModel taskModel;
  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title ?? '',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              widget.taskModel.description ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              'Date: ${  widget.taskModel.createdDate ?? ''},}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buidTaskStatusChip(),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: _onTapEditButton,
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: _onTapDeleteButton,
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onTapEditButton() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
                children:
                    ['New', 'Completed', 'Cancelled', 'Progress'].map((e) {
              return ListTile(
                onTap: (){},
                title: Text(e),
              );
            }).toList(),),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Ok'),
              ),
            ],
          );
        });
  }

  void _onTapDeleteButton() {}

  Widget _buidTaskStatusChip() {
    return Chip(
      label: Text(
        'New',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: BorderSide(color: AppColor.themeColor),
    );
  }
}
