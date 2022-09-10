import 'package:drop_weather/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:lottie/lottie.dart';

import '/dependency_container.dart' as di;
import '../../../../const/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return BlocProvider(
      create: (BuildContext context) =>
          di.sl<WeatherCubit>()..locationService(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          var cubit = WeatherCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.lightBackground,
            drawer: const Drawer(),
            body: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  delegate:
                      AppBarDelegate(maximumExtent: 300, minimumExtent: 220),
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Column(children: [
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            await PlacesAutocomplete.show(
                              context: context,
                              apiKey: 'AIzaSyCKXxBgp-klEuTn3T2h7JIsfF5GIN940bM',
                              radius: 10000000000,
                              types: ['(cities)'],
                              strictbounds: false,
                              mode: Mode.overlay,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              components: [],
                            ).then((value) async {
                              String cityName =
                                  value!.description!.split(' ')[0];
                              cubit.getCityName(cityName);
                              await cubit.getInfoByCity();
                            });
                          } catch (e) {
                            rethrow;
                          }
                        },
                        child: const Text('search'))
                  ]),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AppBarDelegate extends SliverPersistentHeaderDelegate {
  final double maximumExtent;
  final double? minimumExtent;

  AppBarDelegate({required this.maximumExtent, this.minimumExtent});
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
                title: AnimatedOpacity(
                    opacity: percentage,
                    duration: const Duration(milliseconds: 200),
                    child: const Text('cairo')),
                elevation: 0,
                backgroundColor: AppColors.lightBackground,
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedPositioned(
                        top: (percentage.ceil() * 100),
                        left: ((1 - percentage.ceil()) * 80) + 20,
                        duration: const Duration(milliseconds: 200),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: percentage == 0 ? 1 : percentage,
                          child: Text(
                            'data',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 35),
                          ),
                        )),
                    AnimatedPositioned(
                      right: ((1 - percentage.ceil()) * 80) + 20,
                      bottom: ((1 - percentage.ceil()) * 80) + 20,
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
