import '../models/task.dart';
import 'storage.dart' show getStorage;

class FileStorageService {
  Future<void> saveTasks(List<Task> tasks) async {
    try {
      await getStorage().saveTasks(tasks);
    } catch (e) {
      print('Erro ao salvar tarefas do arquivo: $e');
      rethrow;
    }
  }

  Future<List<Task>> loadTasks() async {
    try {
      return await getStorage().loadTasks();
    } catch (e) {
      print('Erro ao carregar tarefas do arquivo: $e');
      return [];
    }
  }
}