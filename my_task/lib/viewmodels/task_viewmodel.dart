import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/shared_preferences_service.dart';
import '../services/file_storage_service.dart';
import '../services/sqlite_service.dart';

enum StorageType { sharedPreferences, fileStorage, sqlite }

class TaskViewModel extends ChangeNotifier {
  final SharedPreferencesService _sharedPrefsService = SharedPreferencesService();
  final FileStorageService _fileService = FileStorageService();
  final SQLiteService _sqliteService = SQLiteService();

  List<Task> _tasks = [];
  StorageType _currentStorage = StorageType.sharedPreferences;
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  StorageType get currentStorage => _currentStorage;
  bool get isLoading => _isLoading;

  Future<void> loadTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      switch (_currentStorage) {
        case StorageType.sharedPreferences:
          _tasks = await _sharedPrefsService.loadTasks();
          break;
        case StorageType.fileStorage:
          _tasks = await _fileService.loadTasks();
          break;
        case StorageType.sqlite:
          _tasks = await _sqliteService.loadTasks();
          break;
      }
    } catch (e) {
      print('Erro ao carregar tarefas: $e');
      _tasks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;

    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title.trim(),
      done: false,
    );

    try {
      if (_currentStorage == StorageType.sqlite) {
        await _sqliteService.insert(newTask);
      } else {
        _tasks.add(newTask);
        await _saveTasks();
      }
      await loadTasks();
    } catch (e) {
      print('Erro ao adicionar tarefa: $e');
    }
  }

  Future<void> toggleTask(Task task) async {
    try {
      final updatedTask = task.copyWith(done: !task.done);

      if (_currentStorage == StorageType.sqlite) {
        await _sqliteService.update(updatedTask);
      } else {
        final index = _tasks.indexWhere((t) => t.id == task.id);
        if (index != -1) {
          _tasks[index] = updatedTask;
          await _saveTasks();
        }
      }
      await loadTasks();
    } catch (e) {
      print('Erro ao atualizar tarefa: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      if (_currentStorage == StorageType.sqlite) {
        await _sqliteService.delete(id);
      } else {
        _tasks.removeWhere((task) => task.id == id);
        await _saveTasks();
      }
      await loadTasks();
    } catch (e) {
      print('Erro ao deletar tarefa: $e');
    }
  }

  Future<void> changeStorage(StorageType newStorage) async {
    _currentStorage = newStorage;
    await loadTasks();
  }

  Future<void> _saveTasks() async {
    switch (_currentStorage) {
      case StorageType.sharedPreferences:
        await _sharedPrefsService.saveTasks(_tasks);
        break;
      case StorageType.fileStorage:
        await _fileService.saveTasks(_tasks);
        break;
      case StorageType.sqlite:
        break;
    }
  }
}