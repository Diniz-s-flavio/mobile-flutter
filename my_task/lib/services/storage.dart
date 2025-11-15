import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'dart:html' as html show window;
import 'dart:io' as io;
import 'package:flutter/services.dart' show MissingPluginException;
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';
import 'storage_base.dart';

StorageService? _storage;

StorageService getStorage() {
  _storage ??= _createStorage();
  return _storage!;
}

StorageService _createStorage() {
  if (kIsWeb) {
    print('Usando WebStorageService (localStorage)');
    return _WebStorageService();
  } else {
    print('Usando FileStorageService (dart:io)');
    return _FileStorageService();
  }
}

class _WebStorageService implements StorageService {
  static const String _storageKey = 'tasks';

  @override
  Future<List<Task>> loadTasks() async {
    try {
      final value = html.window.localStorage[_storageKey];
      if (value == null || value.isEmpty) {
        return [];
      }
      final List<dynamic> list = jsonDecode(value) as List<dynamic>;
      return list.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Erro ao carregar tarefas do localStorage: $e');
      return [];
    }
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    try {
      final contents = jsonEncode(tasks.map((t) => t.toJson()).toList());
      html.window.localStorage[_storageKey] = contents;
    } catch (e) {
      print('Erro ao salvar tarefas no localStorage: $e');
      rethrow;
    }
  }
}

class _FileStorageService implements StorageService {
  static const String _fileName = 'tasks.json';

  Future<io.File> _getFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return io.File('${directory.path}/$_fileName');
    } on MissingPluginException catch (e) {
      print('path_provider not available, falling back to temp: $e');
      final tempDir = io.Directory.systemTemp;
      return io.File('${tempDir.path}/$_fileName');
    } catch (e) {
      print('Error getting app directory, falling back to current: $e');
      return io.File('${io.Directory.current.path}/$_fileName');
    }
  }

  @override
  Future<void> saveTasks(List<Task> tasks) async {
    try {
      final file = await _getFile();
      final jsonList = tasks.map((task) => task.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Erro ao salvar tarefas do arquivo: $e');
      rethrow;
    }
  }

  @override
  Future<List<Task>> loadTasks() async {
    try {
      final file = await _getFile();

      if (!await file.exists()) {
        return [];
      }

      final jsonString = await file.readAsString();

      if (jsonString.isEmpty) {
        return [];
      }

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => Task.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Erro ao carregar tarefas do arquivo: $e');
      return [];
    }
  }
}
