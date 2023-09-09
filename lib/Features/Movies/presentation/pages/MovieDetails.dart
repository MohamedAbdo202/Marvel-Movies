import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_task/core/shared_component/SharedCompenent.dart';

import '../../domain/entites/Movie.dart';
import '../Bloc/Movie_Bloc.dart';

class MovieDetails extends StatelessWidget {
  final Movie model;

  MovieDetails({required this.model});

  @override
  Widget build(BuildContext context) {
    final movieCubit = BlocProvider.of<MovieCubit>(context);
    movieCubit.addRelatedMoviesByTitle(model.title);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                expandedHeight: 240.h,
                floating: false,
                pinned: true,
                flexibleSpace: InkWell(
                  onTap: (){


                  },
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image.network(
                          model.coverUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_circle_filled_sharp,
                                color: Colors.white,
                                size: 43.0,
                              ),
                              SizedBox(height: 7.h),
                              Text(
                                'Play Trailer',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0.sp,
                                  fontFamily: 'Mulish'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
            ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverToBoxAdapter(
                  child: Container(

                    padding: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Container(
                              width: 220.w,
                              child: Text(
                                model.title,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold,
                                    fontFamily: 'Mulish'

                                ),
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.bookmark_outline_outlined, color: Colors.black, size: 24),
                          ],
                        ),
                        SizedBox(height: 12.0.h),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Length',
                                  style: TextStyle(color: HexColor('#9C9C9C'),fontFamily: 'Mulish'),
                                ),
                                SizedBox(height: 4.h),
                                Text('${model.duration} Min',style: TextStyle(fontFamily: 'Mulish'),),
                              ],
                            ),
                            SizedBox(width: 54.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Director',
                                  style: TextStyle(color: HexColor('#9C9C9C'),fontFamily: 'Mulish',
                                  ),
                                  maxLines: 2,

                                ),
                                SizedBox(height: 4.h),
                                Container(width: 90.w,child: Text(model.directedBy,style: TextStyle(fontFamily: 'Mulish'))),
                              ],
                            ),
                            SizedBox(width: 45.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Phase',
                                  style: TextStyle(color: HexColor('#9C9C9C'),fontFamily: 'Mulish'),
                                ),
                                SizedBox(height: 4.h),
                                Text(model.phase.toString(),style: TextStyle(fontFamily: 'Mulish')),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 23.h),
                        Text('Description', style: TextStyle(fontSize: 16.sp,fontFamily: 'Merriweather',color: myColor)),
                        SizedBox(height: 8.h),
                        Text(
                          model.overview ?? 'No overview available',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12.0.sp,
                            color: HexColor('#9C9C9C'),
                          ),
                        ),
                        SizedBox(height: 9.h),
                        Text('Related Movies', style: TextStyle(fontSize: 16.sp, fontFamily: 'Merriweather')),
                        SizedBox(height: 10.h),
                        if (movieCubit.Relatedmovies.isEmpty)
                          Text(
                            'No related movies available',
                            style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 14.sp,
                              color: HexColor('#9C9C9C'),
                            ),
                          )
                        else
                          Container(
                            height: 196.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: movieCubit.Relatedmovies.length,
                              itemBuilder: (context, index) {
                                final model = movieCubit.Relatedmovies[index];
                                return InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 97.w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                                              child: Image(
                                                image: NetworkImage(model.coverUrl),
                                                height: 120.h,
                                                width: 97.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              model.title,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 14.sp,
                                                fontFamily: 'Muish',
                                              ),
                                              maxLines: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 18.w),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
