import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/utils/helper.dart';
import '../../modals/home_model.dart';
import '../../repositries/edit_todo_repo.dart';
import '../../repositries/home_repo.dart';
import '../../sharepref/shareprefrence.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  ToDoListModel? toDoListModel;
  HomeRepo homeRepo = HomeRepo();
  EditToDoRepo editToDoRepo = EditToDoRepo();
  SharedPrefClient sharedPref = SharedPrefClient();
  int currentPage = 1;
  bool isFetching = false;

  HomeBloc(super.initialState);

  // HomeBloc() : super(InitialState()) {
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is DataFetchEvent) {
      yield ProgressState();
      try {
        toDoListModel = await homeRepo.getToDoList(page:event.currentPage,limit: event.limit);
        if (toDoListModel != null) {
          yield DataLoadedState(toDoListModel: toDoListModel!);
        } else {
          yield ErrorState(error: 'Something went wrong');
        }
      } catch (e) {
        yield ErrorState(error: "User not Found $e");
      }
    }
    if(event is AddOrUpdateTodoEvent){
      try{
        if(event.isEdit){
          bool updated=await editToDoRepo.updateToDoRepo(todo: event.todo, id: event.id!, status:event.status!);
          if(updated ==true){
            showToast('ToDo Updated Successfully', true);
          }else{
            showToast('ToDo Updated Failed', false);
          }
        }else{
          final userId=await sharedPref.getUserId();
          print('This is user id:: $userId');
          bool isAdded=await editToDoRepo.addToDoRepo(todo: event.todo, id: userId!, status:event.status!);
          if(isAdded ==true){
            showToast('ToDo Added Successfully', true);
          }else{
            showToast('ToDo Added Failed', false);
          }
        }
      }catch(e,st){
        print('this ToDo give exception $e $st');
        yield ErrorState(error: "ToDo Is not Saved: $e");
      }
    }
    if(event is DeleteFromToDoEvent){
      try{
        bool isDeleted=await editToDoRepo.deleteToDoRepo(id: event.toDoId!);
        if(isDeleted ==true){
          showToast('ToDo Deleted Successfully', true);
        }else{
          showToast('ToDo Deleted Failed', false);
        }
      }catch(e){
        yield ErrorState(error: "ToDo is Not Deleted: $e");
      }
    }

    if(event is ToDoStatusEvent){
      yield ToDoStatusState();
    }
  }
}
