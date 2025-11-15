import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../viewmodels/task_viewmodel.dart';
import 'widgets/task_input.dart';
import 'widgets/task_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskViewModel>().loadTasks();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _getStorageInfo(int index) {
    switch (index) {
      case 0:
        return 'Armazena dados em formato JSON usando key-value pairs. Ideal para configurações e dados simples.';
      case 1:
        return 'Salva tarefas em um arquivo JSON local. Ótimo para backups e portabilidade de dados.';
      case 2:
        return 'Banco de dados relacional com operações CRUD completas. Melhor para dados estruturados e queries complexas.';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: AppColors.mid,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.3),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MyTasks',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: AppColors.accent,
              ),
            ),
            Text(
              'Controle de Tarefas Pessoais',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          final viewModel = context.read<TaskViewModel>();
          viewModel.changeStorage(StorageType.values[index]);
        },
        backgroundColor: AppColors.mid,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'SharedPreferences',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file),
            label: 'File Storage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'SQLite',
          ),
        ],
      ),
      body: Consumer<TaskViewModel>(
        builder: (context, viewModel, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  TaskInput(
                    onSubmit: (title) => viewModel.addTask(title),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppColors.mid,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Minhas Tarefas (${viewModel.tasks.length})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (viewModel.isLoading)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        else if (viewModel.tasks.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Text(
                                'Nenhuma tarefa cadastrada.\nAdicione uma nova tarefa acima!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.tasks.length,
                            itemBuilder: (context, index) {
                              final task = viewModel.tasks[index];
                              return TaskListItem(
                                task: task,
                                onToggle: () => viewModel.toggleTask(task),
                                onDelete: () => viewModel.deleteTask(task.id),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      _getStorageInfo(_currentIndex),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}