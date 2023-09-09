
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_task/Features/Auth/presentation/Cubit/Stats.dart';
import 'package:movie_task/Features/Movies/presentation/pages/Home.dart';

import '../../../../core/shared_component/SharedCompenent.dart';
import '../Cubit/CubitAuth.dart';
import 'LoginScreen.dart';

class reguser extends StatefulWidget {

  @override
  State<reguser> createState() => _reguserState();
}

class _reguserState extends State<reguser> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isAgreed = false;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, LoginState>(
      listener: (context, state) {
        if (state is RegistrationSuccess) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  LoginToMarvel()  ));

        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(

            systemOverlayStyle: SystemUiOverlayStyle(

      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(left: 20.w,right: 23.w),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey, Hello',
                      style: TextStyle(fontFamily: 'WorkSans',fontSize: 30.sp,fontWeight: FontWeight.bold)
                    ),
                    SizedBox(height: 18.h,),
                    Text(
                      'Enter your credentials to access your account',
                        style: TextStyle(fontFamily: 'WorkSans',fontSize: 20.sp)

                    ),
                    SizedBox(
                      height: 55.0.h,
                    ),
                    Text('Name',
                        style: TextStyle(fontFamily: 'WorkSans',fontSize: 20.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    defaultFormField(height: 44.h,
                      controller: nameController,
                      type: TextInputType.name,
                      validator: ( value)
                      {
                        if(value== null || value.isEmpty)
                        {
                          return 'name must not be empty';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    Text('Email address',
                        style: TextStyle(fontFamily: 'WorkSans',fontSize: 20.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validator: ( value)
                      {
                        if(value== null || value.isEmpty)
                        {
                          return 'email must not be empty';
                        }

                        return null;
                      },

                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    Text('Password',
                        style: TextStyle(fontFamily: 'WorkSans',fontSize: 20.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    defaultFormField(
                      controller: passwordController,
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
                      validator: ( value)
                      {
                        if(value== null || value.isEmpty)
                        {
                          return 'password must not be empty';
                        }

                        return null;
                      },
                    ),






                    SizedBox(
                      height: 24.0.h,
                    ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAgreed = !isAgreed;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        isAgreed ? Icons.check_circle : Icons.circle_outlined,
                        color: isAgreed ? Colors.green : Colors.black,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'I agree to the ',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          color: HexColor('#777777'),
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'Terms & Privacy',
                        style: TextStyle(
                          fontFamily: 'WorkSans',
                          color: Colors.black,
                          fontSize: 14.sp,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),),

                    SizedBox(
                      height: 40.0.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegistrationLoading,
                      builder: (context) => defaultButton(
                        background: myColor,
                        radius: 15,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).register(
                              nameController.text,
                              emailController.text,
                              passwordController.text,

                            );

                          }


                        },
                        text: 'Sign up',
                        isUpperCase: true,
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    ),

                    SizedBox(height: 10,)     ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Alredy have an account?',
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontSize: 14.sp,
                          ),
                        ),
                        TextButton(
                            onPressed: () {

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => LoginToMarvel()),
                              );

                            },
                            child: Text(
                              'Login',
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
          ),
        );
      },

    );
  }
}
