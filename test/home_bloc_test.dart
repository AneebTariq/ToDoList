import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/data/bloc/home_bloc/home_bloc.dart';
import 'package:todo_app/data/bloc/home_bloc/home_event.dart';
import 'package:todo_app/data/bloc/home_bloc/home_state.dart';
import 'package:todo_app/data/modals/home_model.dart';
import 'package:todo_app/data/repositries/edit_todo_repo.dart';
import 'package:todo_app/data/repositries/home_repo.dart';
import 'package:todo_app/data/sharepref/shareprefrence.dart';

import 'crud_test.dart';

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockHomeRepo mockHomeRepo;
    late MockEditToDoRepo mockEditToDoRepo;
    late MockSharedPrefClient mockSharedPrefClient;

    setUp(() {
      mockHomeRepo = MockHomeRepo();
      mockEditToDoRepo = MockEditToDoRepo();
      mockSharedPrefClient = MockSharedPrefClient();
      homeBloc = HomeBloc(InitialState())
        ..homeRepo = mockHomeRepo
        ..editToDoRepo = mockEditToDoRepo
        ..sharedPref = mockSharedPrefClient;
    });

    tearDown(() {
      homeBloc.close();
    });

    blocTest<HomeBloc, HomeState>(
      'emits [ProgressState, DataLoadedState] when DataFetchEvent is added and succeeds',
      build: () {
        when(mockHomeRepo.getToDoList(page: anyNamed('page'), limit: anyNamed('limit')))
            .thenAnswer((_) async => ToDoListModel(todos: [Todos(id: 1, userId:1 )]));
        return homeBloc;
      },
      act: (bloc) => bloc.add(DataFetchEvent( 1,  10)),
      expect: () => [
        ProgressState(),
        DataLoadedState(toDoListModel: ToDoListModel(todos: [Todos(id: 1, userId:1 )])),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [ProgressState, ErrorState] when DataFetchEvent is added and fails',
      build: () {
        when(mockHomeRepo.getToDoList(page: anyNamed('page'), limit: anyNamed('limit')))
            .thenThrow(Exception('Error fetching tasks'));
        return homeBloc;
      },
      act: (bloc) => bloc.add(DataFetchEvent( 1,10)),
      expect: () => [
        ProgressState(),
        ErrorState(error: 'User not Found Exception: Error fetching tasks'),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [ToDoUpdateProgressState, AddOrUpdateSuccessState] when AddOrUpdateTodoEvent is added for a new task and succeeds',
      build: () {
        when(mockSharedPrefClient.getUserId()).thenAnswer((_) async => 0);
        when(mockEditToDoRepo.addToDoRepo(todo: 'todo', id: 0, status: false))
            .thenAnswer((_) async => true);
        return homeBloc;
      },
      act: (bloc) => bloc.add(AddOrUpdateTodoEvent(todo: 'New Task', isEdit: false, status: false, id: 0)),
      expect: () => [
        ToDoUpdateProgressState(),
        AddOrUpdateSuccessState(),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [ToDoUpdateProgressState, AddOrUpdateErrorState] when AddOrUpdateTodoEvent is added for a new task and fails',
      build: () {
        when(mockSharedPrefClient.getUserId()).thenAnswer((_) async => 0);
        when(mockEditToDoRepo.addToDoRepo(todo: 'Todos', id: 0, status: false))
            .thenAnswer((_) async => false);
        return homeBloc;
      },
      act: (bloc) => bloc.add(AddOrUpdateTodoEvent(todo: 'New Task', isEdit: false, status: false, id: 0)),
      expect: () => [
        ToDoUpdateProgressState(),
        AddOrUpdateErrorState(error: 'ToDo Added Failed'),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [DeleteProgressState, DeleteSuccessState] when DeleteFromToDoEvent is added and succeeds',
      build: () {
        when(mockEditToDoRepo.deleteToDoRepo(id: 0))
            .thenAnswer((_) async => true);
        return homeBloc;
      },
      act: (bloc) => bloc.add(DeleteFromToDoEvent(toDoId: 1)),
      expect: () => [
        DeleteProgressState(),
        DeleteSuccessState(),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'emits [DeleteProgressState, DeleteErrorState] when DeleteFromToDoEvent is added and fails',
      build: () {
        when(mockEditToDoRepo.deleteToDoRepo(id: 0))
            .thenAnswer((_) async => false);
        return homeBloc;
      },
      act: (bloc) => bloc.add(DeleteFromToDoEvent(toDoId: 1)),
      expect: () => [
        DeleteProgressState(),
        DeleteErrorState(error: 'ToDo Deleted Failed'),
      ],
    );
  });
}

class MockHomeRepo extends Mock implements HomeRepo {}

class MockEditToDoRepo extends Mock implements EditToDoRepo {}

class MockSharedPrefClient extends Mock implements SharedPrefClient {}
