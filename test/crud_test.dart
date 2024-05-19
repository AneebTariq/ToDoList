import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class Task {
  int id;
  String name;

  Task({required this.id, required this.name});
}

class TaskService {
  final Dio dio;

  TaskService(this.dio);

  Future<List<Task>> fetchTasks() async {
    final response = await dio.get('https://reqres.in/api/tasks');
    final data = response.data['data'] as List;
    return data.map((task) => Task(id: task['id'], name: task['name'])).toList();
  }

  Future<Task> createTask(String name) async {
    final response = await dio.post('https://reqres.in/api/tasks', data: {'name': name});
    final data = response.data;
    return Task(id: data['id'], name: data['name']);
  }

  Future<void> updateTask(Task task) async {
    await dio.put('https://reqres.in/api/tasks/${task.id}', data: {'name': task.name});
  }

  Future<void> deleteTask(int id) async {
    await dio.delete('https://reqres.in/api/tasks/$id');
  }
}

void main() {
  group('Task CRUD Operations', () {
    late TaskService taskService;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter();
      dio.httpClientAdapter = dioAdapter;
      taskService = TaskService(dio);
    });

    test('Fetch tasks', () async {
      final responsePayload = {'data': [{'id': 1, 'name': 'Test Task'}]};

      dioAdapter.onGet(
        'https://reqres.in/api/tasks',
            (request) => request.reply(200, responsePayload),
      );

      final tasks = await taskService.fetchTasks();
      expect(tasks, isNotEmpty);
      expect(tasks.first.name, 'Test Task');
    });

    test('Create a task', () async {
      final requestPayload = {'name': 'New Task'};
      final responsePayload = {'id': 2, 'name': 'New Task'};

      dioAdapter.onPost(
        'https://reqres.in/api/tasks',
            (request) => request.reply(201, responsePayload),
        data: requestPayload,
      );

      final task = await taskService.createTask('New Task');
      expect(task.name, 'New Task');
    });

    test('Update a task', () async {
      final task = Task(id: 1, name: 'Updated Task');

      dioAdapter.onPut(
        'https://reqres.in/api/tasks/${task.id}',
            (request) => request.reply(200, {}),
        data: {'name': task.name},
      );

      await taskService.updateTask(task);
      // Verifying only through HTTP call success since no response data is expected
    });

    test('Delete a task', () async {
      dioAdapter.onDelete(
        'https://reqres.in/api/tasks/1',
            (request) => request.reply(200, {}),
      );

      await taskService.deleteTask(1);
      // Verifying only through HTTP call success since no response data is expected
    });
  });
}
