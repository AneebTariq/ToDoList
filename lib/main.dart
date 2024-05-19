import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/ui/Auth/splash_screen.dart';
import 'config/utils/app_colors.dart';
import 'data/bloc/home_bloc/home_bloc.dart';
import 'data/bloc/home_bloc/home_state.dart';
import 'data/bloc/login_bloc/login_bloc.dart';
import 'data/bloc/login_bloc/login_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<LoginBloc>(create: (context) => LoginBloc(InitState())),
      BlocProvider<HomeBloc>(create: (context) => HomeBloc(InitialState())),
    ],
    child:ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MyApp();
        }),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        title: 'ToDo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
        ),
        home:  const SplashScreen(),
      ),
    );
  }
}
