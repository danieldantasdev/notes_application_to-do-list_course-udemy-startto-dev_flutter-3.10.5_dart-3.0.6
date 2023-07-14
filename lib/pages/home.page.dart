import 'package:flutter/material.dart';
import 'package:notes/models/task.dart';

import '../repositories/repositories.dart';
import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();
  final TaskRepository _taskRepository = TaskRepository();
  String? _errorText;

  void onDelete(Task task) {
    Task? taskDeleted;
    int? index;

    taskDeleted = task;
    index = _tasks.indexOf(task);

    setState(() {
      _tasks.remove(task);
      _taskRepository.save(_tasks);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Tarefa ${task.title} removida com sucesso!",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        action: SnackBarAction(
          textColor: Colors.tealAccent,
          label: 'Desfazer',
          onPressed: () => {
            setState(() {
              _tasks.insert(index!, taskDeleted!);
            }),
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void onDeleteAll() {
    setState(() {
      _tasks.clear();
      _taskRepository.save(_tasks);
    });
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Limpar tudo?"),
        content: const Text("Tem certeza que deseja apagar todas tarefas?"),
        actions: [
          TextButton(
            onPressed: () => {
              Navigator.of(context).pop(),
            },
            style: TextButton.styleFrom(foregroundColor: Colors.tealAccent),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => {
              Navigator.of(context).pop(),
              onDeleteAll(),
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Limpar"),
          ),
        ],
      ),
    );
  }

  void onSave() {
    String text = _taskController.text;

    if (text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertWidget(
            title: 'Erro',
            content: 'Não pode adicionar uma tarefa vazia!',
            closeButtonLabel: 'Fechar',
          );
        },
      );

      setState(() {
        _errorText = 'O Título não pode ser vazio';
      });
    } else {
      setState(() {
        _errorText = null;

        Task task = Task(
          title: text,
          datetime: DateTime.now(),
        );
        _tasks.add(task);
        _taskRepository.save(_tasks);
      });
    }

    _taskController.clear();
  }

  @override
  void initState() {
    super.initState();

    _taskRepository.get('task_list').then(
          (value) => {
            setState(() {
              _tasks = value;
            })
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: _taskController,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.tealAccent,
                          )),
                          border: const OutlineInputBorder(),
                          labelText: 'Insira sua tarefa!',
                          hintText: 'Ex: Estudar flutter',
                          errorText: _errorText,
                          labelStyle: const TextStyle(
                            color: Colors.tealAccent,
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: onSave,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent,
                          fixedSize: const Size(60, 60)),
                      child: const Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (Task task in _tasks)
                      // ListTile(
                      //   title: Text(task),
                      //   subtitle: Text(convertDate(DateTime.now())),
                      //   leading: const Icon(Icons.save),
                      //   onTap: () {
                      //     print('tarefa: ${task}');
                      //   },
                      // ),
                      ListItemWidget(
                        task: task,
                        onDelete: onDelete,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Você possui ${_tasks.length} tarefas pendentes!",
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDeleteConfirmationDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent,
                    ),
                    child: const Text("Limpar tudo!"),
                  )
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
