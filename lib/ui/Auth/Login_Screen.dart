import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/utils/image_assets.dart';
import '../../config/utils/app_colors.dart';
import '../../config/utils/app_text_styles.dart';
import '../../config/utils/helper.dart';
import '../../data/bloc/login_bloc/login_bloc.dart';
import '../../data/bloc/login_bloc/login_event.dart';
import '../../data/bloc/login_bloc/login_state.dart';
import '../../data/sharepref/shareprefrence.dart';
import '../home/home_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/textfield_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final SharedPrefClient sharePref = SharedPrefClient();
  bool _suffixForPass = true;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
          style: AppTextStyles.font20_700TextStyle.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: BlocListener<LoginBloc, LonigState>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            showToast('Login Successfully', true);
          }
          if (state is ErrorState) {
            showToast(state.error, false);
          }
        },
        child: BlocBuilder<LoginBloc, LonigState>(
          builder: (BuildContext context, state) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 67.h,
                      ),
                      Image.asset(ImageAssets.splashIcon,height: 150.h,width: 150.w,),
                      SizedBox(
                        height: 50.h,
                      ),
                      Text(
                        'Welcome Back to your ToDo',
                        style: AppTextStyles.font20_700TextStyle.copyWith(color: AppColors.black),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hint: 'Name',
                        prefixIcon: Icons.email_outlined,
                        validator: (String? text) {
                          if (text!.isEmpty) {
                            return 'Enter name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hint: 'Password',
                        isObscure: true,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: Icons.password,
                        isVisibilityIconShow: _suffixForPass,
                        isPassword: true,
                        validator: (String? text) {
                          if (text!.isEmpty) {
                            return 'Please enter password';
                          }else if(text.length<4){
                            return 'Please enter long password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomButton(
                        buttonColor: AppColors.primaryColor,
                        child: Center(
                          child: state is ProgressState
                              ? SizedBox(
                              height: 15.h,
                              width: 15.w,
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 2,
                              ))
                              : Text('LogIn',
                              style: AppTextStyles.font16_500TextStyle.copyWith(color: AppColors.white)),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<LoginBloc>(context).add(AuthticateEvent(
                              name: nameController.text.trim(),
                              password: passwordController.text.trim(),
                            ));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
