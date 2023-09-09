import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_task/Features/Auth/presentation/Pages/RegisterScreen.dart';

import 'package:movie_task/core/shared_component/SharedCompenent.dart';

import '../../../Movies/presentation/pages/BottomNavigationBar.dart';
import '../Cubit/CubitAuth.dart';
import '../Cubit/Stats.dart';


class LoginToMarvel extends StatefulWidget {
  const LoginToMarvel({Key? key}) : super(key: key);

  @override
  _LoginToMarvelState createState() => _LoginToMarvelState();
}

class _LoginToMarvelState extends State<LoginToMarvel> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>(); // Add this line


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login failed. Please check your credentials.'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
          }
        },
        builder: (context, state) {

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 256.h,
                    child: Image.asset(
                      'assets/images/LoginImage.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 26.w, right: 24.w, top: 25.h),
                      child: Form(
                        key: formKey,
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Text(
                                'Let`s Connect With Us!',
                                style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 44.h),
                            defaultFormField(
                              height: 44.h,
                              controller: emailController,
                              label: 'Email Address',
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email must not be empty';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 24.0.h,
                            ),
                            defaultFormField(
                              height: 44.h,
                              controller: passwordController,
                              label: 'Password',
                              suffix: isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility_rounded,
                              isPassword: !isPasswordVisible,
                              suffixPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              type: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password must not be empty';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forget password?',
                                    style: TextStyle(
                                      fontFamily: 'WorkSans',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 29.h),
                            ConditionalBuilder(
                              condition: state is! LoginLoadingSuccess,
                              builder: (context) => defaultButton(
                                background: myColor,
                                radius: 24,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthCubit>(context).signIn(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                },
                                text: 'Login',

                              ),
                              fallback: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(height: 29.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                    fontFamily: 'WorkSans',
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) => reguser()),
                                      );
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontFamily: 'WorkSans',
                                        fontSize: 14.sp,
                                        color: myColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  )],
              ),
            ),
          );}
    );
  }
}