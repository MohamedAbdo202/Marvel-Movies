import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:movie_task/Features/Movies/domain/entites/TvShow.dart';
import 'package:movie_task/core/shared_component/SharedCompenent.dart';


class TvDetails extends StatelessWidget {
  final TvShow model;

  TvDetails({required this.model});

  @override
  Widget build(BuildContext context) {

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
                flexibleSpace: InkWell(onTap: (){},

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
                                size: 45.0,
                              ),
                              SizedBox(height: 8.h),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'season',
                                  style: TextStyle(color: HexColor('#9C9C9C'),fontFamily: 'Mulish'),
                                ),
                                SizedBox(height: 4.h),
                                Text('${model.season} ',style: TextStyle(fontFamily: 'Mulish'),),
                              ],
                            ),
                            SizedBox(width: 30.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Episodes',
                                  style: TextStyle(color: HexColor('#9C9C9C'),fontFamily: 'Mulish',
                                  ),
                                  maxLines: 2,

                                ),
                                SizedBox(height: 4.h),
                                Text(model.number_episodes.toString(),
                                    style: TextStyle(fontFamily: 'Mulish')),
                              ],
                            ),
                            SizedBox(width: 30.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'Director',
                                  style: TextStyle(color: HexColor('#9C9C9C'),fontFamily: 'Mulish'),
                                ),
                                SizedBox(height: 4.h),
                                Container(width:80.w,

                                    child:
                                    Text(model.directedBy ?? 'No Director Available',style: TextStyle(fontFamily: 'Mulish'),maxLines: 2,)),
                              ],
                            ),
                            SizedBox(width: 30.w),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'phase',
                                  style: TextStyle(color: HexColor('#9C9C9C'),fontFamily: 'Mulish'),
                                ),
                                SizedBox(height: 4.h),
                                Text('${model.phase } ',style: TextStyle(fontFamily: 'Mulish'),),
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
