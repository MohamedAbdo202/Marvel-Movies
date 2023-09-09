import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Features/Auth/presentation/Cubit/CubitAuth.dart';
import 'Features/Auth/presentation/Pages/LoginScreen.dart';
import 'Features/Movies/presentation/Bloc/Movie_Bloc.dart';

import 'core/apptheme.dart';
import 'injection_container.dart'as di;
void main (
    )async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init();



  runApp(MyApp());

}



class MyApp extends StatelessWidget
{
  MyApp();

  @override
  Widget build(BuildContext context)
  {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,

        builder: (context , child) {
          return  MultiBlocProvider(
              providers: [

                BlocProvider(create: (context) => di.sl<MovieCubit> ()),
                BlocProvider(create: (context) => di.sl<AuthCubit> ()),


              ],child:MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: appTheme,

              home: LoginToMarvel()

          ));
        });
  }
}