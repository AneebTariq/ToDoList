import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/utils/app_colors.dart';
import '../../../config/utils/app_text_styles.dart';
import '../../../config/utils/helper.dart';
import '../../../data/bloc/home_bloc/home_bloc.dart';
import '../../../data/bloc/home_bloc/home_event.dart';
import '../../../data/bloc/home_bloc/home_state.dart';
import '../../widgets/custom_button.dart';
// ignore: must_be_immutable
class ToDoEditScreen extends StatelessWidget {
  ToDoEditScreen({super.key, required this.isEdit, required this.todo, required this.id, required this.status});
  final bool isEdit;
  final String todo;
  final int? id;
   final bool? status;

  final TextEditingController toDoController = TextEditingController();

  bool? isCompleted=false;

  @override
  Widget build(BuildContext context) {
    toDoController.text = isEdit ? todo : '';
    isCompleted = status ?? false;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is AddOrUpdateSuccessState) {
          Navigator.of(context).pop();
          showToast(isEdit ? 'ToDo updated successfully!' : 'ToDo added successfully!', true);
        } else if (state is ErrorState) {
          showToast(state.error, false);
        }
        if(state is ToDoStatusState){
          isCompleted =! isCompleted!;
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text(
            isEdit ? 'Edit ToDo' : 'Add ToDo',
            style: AppTextStyles.font24TextStyle.copyWith(color: AppColors.primaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            isEdit==true?  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('completed',style: AppTextStyles.font14_500TextStyle.copyWith(color: AppColors.black),),
                  IconButton(onPressed: (){
                    BlocProvider.of<HomeBloc>(context)
                        .add(ToDoStatusEvent());
                  }, icon: Icon(Icons.check_box,size: 18,color:isCompleted==true?AppColors.green:AppColors.lightGrey,)),
                ],
              ):const SizedBox(),
              TextFormField(
               initialValue: isEdit==true?todo:'',
                maxLines: 4,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Write something for later',
                  hintStyle: AppTextStyles.font14_600TextStyle.copyWith(color: AppColors.lightGrey),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value){
                 toDoController.text=value;
                },
              ),
            ],
          ),
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
                buttonColor: AppColors.primaryColor,
                onPressed: () {
                  if (toDoController.text.isNotEmpty) {
                    BlocProvider.of<HomeBloc>(context).add(
                      AddOrUpdateTodoEvent(
                        isEdit: isEdit,
                        status: status,
                        todo: toDoController.text,
                        id: id,
                      ),
                    );
                    Navigator.of(context).pop();
                  }else{
                    showToast('please Enter value', false);
                  }
                },
                child: state is ProgressState
                    ? CircularProgressIndicator(color: AppColors.white)
                    : Text(
                  isEdit ? 'Update' : 'Save',
                  style: AppTextStyles.font14_600TextStyle.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}