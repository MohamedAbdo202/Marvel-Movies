import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/Features/Movies/presentation/Bloc/Movie_Bloc.dart';
import 'package:movie_task/Features/Movies/presentation/Bloc/Movie_stats.dart';


class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MovieCubit,MyState>(
      listener: (context,state){},
      builder: (context,state){
        var cubit =MovieCubit.get(context);
        return Scaffold(

          bottomNavigationBar: BottomNavigationBar(items:cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottom(index);
              },
            type: BottomNavigationBarType.fixed, // Set the type to fixed if you have more than three items without labels
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
        );

      },


    );
  }
}
