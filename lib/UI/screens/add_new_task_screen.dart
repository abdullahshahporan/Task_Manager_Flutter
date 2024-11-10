import 'package:flutter/material.dart';
import 'package:t_manager/UI/widgets/task_manager_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addnewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TaskManagerAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _titleTEController,
                  decoration: const InputDecoration(
                    hintText: 'Tite',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter a Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _descriptionTEController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter a Title';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: !_addnewTaskInProgress,
                  replacement: const CircularProgressIndicator(),
                  child: ElevatedButton(
                    onPressed: _onTapSubmitButton,
                    child: const Icon(Icons.arrow_forward_ios_outlined),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formkey.currentState!.validate()) {
      _addnewTask();
    }
  }

  Future<void> _addnewTask() async {
    _addnewTaskInProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "title": _titleTEController,
      "description": _descriptionTEController,
      "status": "New",
    };
  }
}
