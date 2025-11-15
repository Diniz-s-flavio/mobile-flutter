import '../models/task.dart';

abstract interface class StorageService {
  Future<List<Task>> loadTasks();
  Future<void> saveTasks(List<Task> tasks);
}
