import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_task/Features/Movies/presentation/pages/TvDetails.dart';
import 'package:movie_task/core/shared_component/SharedCompenent.dart';

import '../Bloc/Movie_Bloc.dart';
import '../Bloc/Movie_stats.dart';
import 'MovieDetails.dart';

class HomePage extends StatelessWidget {

  final ScrollController _scrollController = ScrollController();
  final ScrollController _tvScrollController = ScrollController();

  Future<void> _onScroll(BuildContext context) async {
    final movieCubit = BlocProvider.of<MovieCubit>(context);

    // Check if a fetch operation is already in progress
    if (movieCubit.state is! LoadingMovieState &&
        _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has scrolled to the bottom and no fetch operation is ongoing
      await movieCubit.fetchMovies();
    }
  }


  void _onTVShowScroll(BuildContext context) {
    final movieCubit = BlocProvider.of<MovieCubit>(context);

    if (movieCubit.state is! LoadingTVState &&

    _tvScrollController.position.pixels == _tvScrollController.position.maxScrollExtent) {
      // User has scrolled to the bottom of TV shows
      movieCubit.fetchTvShow();
    }
  }
  @override
  Widget build(BuildContext context) {
    final movieCubit = BlocProvider.of<MovieCubit>(context);
    movieCubit.fetchMovies();
    movieCubit.fetchTvShow();
    return BlocConsumer<MovieCubit, MyState>(
      listener: (context, state) {
         if (state is LoadingTVState && state is LoadedMovieState) {
           Center(child: Text('Waiting'));
         }
      },
      builder: (context, state) {
        final movieCubit = BlocProvider.of<MovieCubit>(context);
        final tvShows = movieCubit.Tvshow;
        final movies = movieCubit.movies;

        return Scaffold(
          appBar: AppBar(
            actions: [
              SvgPicture.asset(
                'assets/images/Notif.svg',
                width: 24.0,  // Set the width and height as needed
                height: 24.0,
              ),
              Padding(
                padding: EdgeInsets.only(right: 18.w),
              ),
            ],
            leading: Padding(
              padding: EdgeInsets.only(left: 20.0.w),
              child: SvgPicture.asset(
                'assets/images/Menu.svg',
                width: 24.0,  // Set the width and height as needed
                height: 24.0,
              ),
            ),
            title:  Text(
              'Marvel',
              style: TextStyle(
                fontSize: 16.sp,
                color: myColor,
                fontFamily: 'Merriweather',fontWeight: FontWeight.bold
              ),
            ),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                _onScroll(context);
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: EdgeInsets.only(top: 16.h, left: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:[ Text(
                        'Tv Shows',
                        style: TextStyle(
                          color: myColor,
                          fontFamily: 'Merriweather',fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),Spacer(),
                        Container(
                          width: 60.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor('#E5E4EA'), // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius: BorderRadius.circular(14.0), // Border radius
                          ),
                          child: Center(
                            child: Text(
                              'See more',
                              style: TextStyle(
                                color: HexColor('#E5E4EA'), // Text color
                                fontFamily: 'Mulish',
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 24.w),

                      ]),
                    SizedBox(height: 16.h),
                    Container(
                      height: 296.h,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification) {
                            _onTVShowScroll(context);
                          }
                          return true;
                        },
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: _tvScrollController,
                          itemCount: tvShows.length,
                          itemBuilder: (context, index) {
                            final model = tvShows[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TvDetails(
                                      model: model,
                                    ),
                                  ),
                                );
                              },                              child: Row(
                                children: [
                                  Container(
                                    width: 137.w,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                          child: Image(
                                            image: NetworkImage(model.coverUrl),
                                            height: 212.h,
                                            width: 143.w,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          model.title,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            fontFamily: 'Mulish',

                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 47.h),
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child:   Row(
                          children:[ Text(
                            'Movies',
                            style: TextStyle(
                              color: myColor,
                              fontFamily: 'Merriweather',fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),Spacer(),
                            Container(
                              width: 60.w,
                              height: 20.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: HexColor('#E5E4EA'), // Border color
                                  width: 1.0, // Border width
                                ),
                                borderRadius: BorderRadius.circular(14.0), // Border radius
                              ),
                              child: Center(
                                child: Text(
                                  'See more',
                                  style: TextStyle(
                                      color: HexColor('#E5E4EA'), // Text color
                                      fontFamily: 'Mulish',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp
                                  ),
                                ),
                              ),
                            ),

                          ]),
                    ),
                    SizedBox(height: 15.h),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final model2 = movies[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                  model: model2,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                                      child: Image(
                                        image: NetworkImage(model2.coverUrl),
                                        height: 120.h,
                                        width: 85.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            model2.title,
                                            style: TextStyle(
                                              fontFamily: 'Mulish',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                            ),
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 22.h),
                                          Text(
                                            model2.directedBy,
                                            style: TextStyle(
                                              fontFamily: 'Mulish',

                                              fontWeight: FontWeight.w400,
                                              fontSize: 12.sp,
                                            ),
                                            maxLines: 2,
                                          ),
                                          SizedBox(height: 21.h),
                                          Row(
                                            children: [
                                              Icon(Icons.watch_later_outlined,size: 10,),
                                              SizedBox(width: 4.w,),
                                              Text(model2.releaseDate,style: TextStyle(
                                                fontFamily: 'Mulish',
                                                fontWeight: FontWeight.w400,
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        );
                      },
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
