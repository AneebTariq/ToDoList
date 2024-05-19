import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/utils/app_colors.dart';
import '../../config/utils/app_text_styles.dart';
import '../../config/utils/helper.dart';
import '../../data/bloc/home_bloc/home_bloc.dart';
import '../../data/bloc/home_bloc/home_event.dart';
import '../../data/bloc/home_bloc/home_state.dart';
import '../../data/modals/home_model.dart';
import '../home/widgets/add_todo_widget.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int currentPage=1;
int limit=15;
final ScrollController _scrollController =  ScrollController();
final List<Todos> _data = [];
bool isDataLoad = false;
  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        BlocProvider.of<HomeBloc>(context)
            .add(DataFetchEvent(currentPage, limit));
      }
    });
    BlocProvider.of<HomeBloc>(context)
        .add(DataFetchEvent(currentPage, limit));

    super.initState();
  }
@override
void dispose() {
  _scrollController.dispose();
  super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return ToDoEditScreen(isEdit: false, todo: '', id: null,status: false,);
            },
          );
        },
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(Icons.add, color: AppColors.white),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'My ToDo List',
          style: AppTextStyles.font20_700TextStyle.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (BuildContext context, state) {
          if (state is ErrorState) {
            showToast(state.error, false);
          }
          if (state is DataLoadedState) {
            setState(() {
            isDataLoad = true;
            _data.addAll(state.toDoListModel.todos!);
            currentPage++;
            });
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, state) {
            if (state is ProgressState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DataLoadedState) {

              return ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (context, int i) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                      margin: EdgeInsets.only(top: 20.h,left: 16.w,right: 16.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                            color: AppColors.black.withOpacity(0.2),
                          )
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${_data[i].todo}",
                            style: const TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 5.h,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10.w,),
                              Text(
                                "completed: ${_data[i].completed}",
                                style: AppTextStyles.font14_600TextStyle.copyWith(color:_data[i].completed==true?AppColors.green:AppColors.red),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: (){
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ToDoEditScreen(isEdit: true, todo: '${_data[i].todo}', id:_data[i].id,status: _data[i].completed,);
                                  },
                                );
                              },
                                  icon: Icon(Icons.edit,size: 18,color: AppColors.primaryColor,)),
                              IconButton(
                                  onPressed: (){
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Delete ToDo',style: AppTextStyles.font14_500TextStyle.copyWith(color: AppColors.black),),
                                          content: Text('Do You want to delete this ToDo Task',style: AppTextStyles.font14_500TextStyle.copyWith(color: AppColors.black),),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: AppTextStyles.font14_600TextStyle.copyWith(color: AppColors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 130.w,
                                              child: CustomButton(
                                                buttonColor: AppColors.red,
                                                onPressed: () {
                                                    BlocProvider.of<HomeBloc>(context).add(
                                                      DeleteFromToDoEvent(
                                                        toDoId: _data[i].id,
                                                      ),
                                                    );
                                                    Navigator.of(context).pop();
                                                },
                                                child: state is ProgressState
                                                    ? CircularProgressIndicator(color: AppColors.white)
                                                    : Text(
                                                 'Delete',
                                                  style: AppTextStyles.font14_600TextStyle.copyWith(color: AppColors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.delete,size: 18,color: AppColors.red,)),

                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );

            }else{
              return const SizedBox(
                child: Text('No Data Found'),
              );
            }
           // return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
