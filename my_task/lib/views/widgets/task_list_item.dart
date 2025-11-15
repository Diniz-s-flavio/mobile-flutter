import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const TaskListItem({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: task.done 
            ? AppColors.accent 
            : AppColors.primary.withOpacity(0.4),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: task.done ? AppColors.accent : Colors.transparent,
                border: Border.all(
                  color: task.done ? AppColors.accent : AppColors.primary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: task.done
                  ? const Icon(
                      Icons.check,
                      size: 18,
                      color: AppColors.dark,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                fontSize: 15,
                color: task.done ? AppColors.accent : Colors.white,
                decoration: task.done ? TextDecoration.lineThrough : null,
                decorationColor: AppColors.accent,
                decorationThickness: 2,
              ),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_outline),
            color: Colors.red[400],
            iconSize: 20,
          ),
        ],
      ),
    );
  }
}