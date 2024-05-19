import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo_app/data/bloc/login_bloc/login_bloc.dart';
import 'package:todo_app/data/bloc/login_bloc/login_event.dart';
import 'package:todo_app/data/bloc/login_bloc/login_state.dart';
import 'package:todo_app/data/modals/login_model.dart';
import 'package:todo_app/data/repositries/login_repositry.dart';
import 'package:todo_app/data/sharepref/shareprefrence.dart';


// Mock classes
class MockLoginRepo extends Mock implements LoginRepo {}

class MockSharedPrefClient extends Mock implements SharedPrefClient {}

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;
    late MockLoginRepo mockLoginRepo;
    late MockSharedPrefClient mockSharedPrefClient;

    setUp(() {
      mockLoginRepo = MockLoginRepo();
      mockSharedPrefClient = MockSharedPrefClient();
      loginBloc = LoginBloc(InitState())
        ..loginRepository = mockLoginRepo
        ..sharepref = mockSharedPrefClient;
    });

    tearDown(() {
      loginBloc.close();
    });

    blocTest<LoginBloc, LonigState>(
      'emits [ProgressState, LoginSuccessState] when AuthticateEvent is added and succeeds',
      build: () {
        final loginResponseModel = LoginResponseModel(token: 'fake_token');
        when(mockLoginRepo.userLogin(name: 'name', password: 'password'))
            .thenAnswer((_) async => loginResponseModel);
        when(mockSharedPrefClient.setUser(loginResponseModel)).thenAnswer((_) async => true);
        return loginBloc;
      },
      act: (bloc) => bloc.add(AuthticateEvent(name: 'test_user', password: 'test_password')),
      expect: () => [
        LoginSuccessState(loginDetails: LoginResponseModel(token: 'fake_token')),
      ],
    );

    blocTest<LoginBloc, LonigState>(
      'emits [ProgressState, ErrorState] when AuthticateEvent is added and fails',
      build: () {
        when(mockLoginRepo.userLogin(name: 'name', password: 'password'))
            .thenThrow(Exception('Login failed'));
        return loginBloc;
      },
      act: (bloc) => bloc.add(AuthticateEvent(name: 'test_user', password: 'test_password')),
      expect: () => [
        LoginErrorState(error: 'User not Found Exception: Login failed'),
      ],
    );

    blocTest<LoginBloc, LonigState>(
      'emits [ProgressState, ErrorState] when AuthticateEvent is added and login model token is null',
      build: () {
        final loginResponseModel = LoginResponseModel(token: null);
        when(mockLoginRepo.userLogin(name: 'name', password:'password'))
            .thenAnswer((_) async => loginResponseModel);
        return loginBloc;
      },
      act: (bloc) => bloc.add(AuthticateEvent(name: 'test_user', password: 'test_password')),
      expect: () => [
        LoginErrorState(error: 'Something went wrong'),
      ],
    );
  });
}


