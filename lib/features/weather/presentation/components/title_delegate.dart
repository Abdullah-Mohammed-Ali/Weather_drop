import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../const/colors.dart';
import '../../../../const/styles.dart';
import '../bloc/weather_cubit.dart';
import 'delegate_items.dart';

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maximumExtent;
  final double? minimumExtent;
  final WeatherCubit cubit;

  AppBarDelegate(
      {required this.cubit, required this.maximumExtent, this.minimumExtent});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var percentage = (constraints.maxHeight - minimumExtent!) /
            (maximumExtent - minimumExtent!);
        return Container(
          height: constraints.maxHeight,
          color: AppColors.lightBackground,
          child: Column(
            children: [
              AppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                  IconButton(
                    onPressed: () {
                      cubit.searchForCity(context);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
                title: AnimatedOpacity(
                    opacity: 1 - percentage,
                    duration: const Duration(milliseconds: 200),
                    child: Text(cubit.myCityInfo!.name ?? '')),
                elevation: 0,
                backgroundColor: AppColors.lightBackground,
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedPositioned(
                        top: (percentage.ceil() * 100),
                        left: ((1 - percentage.ceil()) * 100) + 20,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: percentage == 0 ? 1 : percentage,
                          child: Row(
                            children: [
                              Text(
                                  '${cubit.myCityInfo!.main!.tempMin} / ${cubit.myCityInfo!.main!.tempMax}' ??
                                      '',
                                  style: mainStyle(context: context, size: 25)),
                            ],
                          ),
                        )),
                    TempTitle(
                      temp: '${cubit.myCityInfo!.main!.temp.toString()}°',
                    ),
                    CityName(
                        percentage: percentage,
                        city: cubit.myCityInfo!.name ?? ''),
                    AnimatedPositioned(
                      right: ((1 - percentage.ceil()) * 10) - 10,
                      bottom: ((1 - percentage.ceil()) * 50) + 15,
                      duration: const Duration(milliseconds: 500),
                      child: SizedBox(
                          height: 50,
                          width: 200,
                          child: Lottie.asset('assets/gifs/sunny.json')),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => maximumExtent;

  @override
  // TODO: implement minExtent
  double get minExtent => minimumExtent!;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
