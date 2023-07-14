import 'package:flutter/material.dart';
import 'package:notes/models/task.dart';

import '../widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  final TextEditingController taskController = TextEditingController();

  void onDelete(Task task) {
    Task? taskDeleted;
    int? index;

    taskDeleted = task;
    index = tasks.indexOf(task);

    setState(() {
      tasks.remove(task);
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
              tasks.insert(index!, taskDeleted!);
            }),
          },
        ),
        duration: const Duration(seconds: 5),
      ),
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
                      controller: taskController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Insira sua tarefa!',
                        hintText: 'Estudar flutter',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        String text = taskController.text;

                        if (text != '') {
                          setState(() {
                            Task task = Task(title: text, date: DateTime.now());
                            tasks.add(task);
                          });
                        } else {
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
                        }

                        taskController.clear();
                      },
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
                    for (Task task in tasks)
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
                      "Você possui ${tasks.length} tarefas pendentes!",
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        tasks.clear();
                      });
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
