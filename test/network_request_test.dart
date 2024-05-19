import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  group('Network Requests', () {
   late  Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter();
      dio.httpClientAdapter = dioAdapter;
    });

    test('Fetch tasks from reqres.in', () async {
      final responsePayload = {'data': [{'id': 1, 'name': 'Test Task'}]};

      dioAdapter.onGet(
        'https://reqres.in/api/tasks',
            (request) => request.reply(200, responsePayload),
      );

      final response = await dio.get('https://reqres.in/api/tasks');
      expect(response.statusCode, 200);
      expect(response.data['data'], isNotEmpty);
    });

    test('Create a task on reqres.in', () async {
      final requestPayload = {'name': 'New Task'};
      final responsePayload = {'id': 2, 'name': 'New Task'};

      dioAdapter.onPost(
        'https://reqres.in/api/tasks',
            (request) => request.reply(201, responsePayload),
        data: requestPayload,
      );

      final response = await dio.post('https://reqres.in/api/tasks', data: requestPayload);
      expect(response.statusCode, 201);
      expect(response.data['name'], 'New Task');
    });
  });
}