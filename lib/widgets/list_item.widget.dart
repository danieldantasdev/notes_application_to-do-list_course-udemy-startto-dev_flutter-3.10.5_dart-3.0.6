import 'package:flutter/material.dart';
import 'package:notes/models/task.dart';

import '../utils/utils.dart';

class ListItemWidget extends StatelessWidget {
  ListItemWidget({super.key, required this.task});

  final Task task;
  final MethodsGlobal _methodsGlobal = MethodsGlobal();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _methodsGlobal.convertDate(task.date),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
