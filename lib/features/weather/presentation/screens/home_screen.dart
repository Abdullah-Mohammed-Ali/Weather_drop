import 'package:drop_weather/features/weather/presentation/bloc/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/dependency_container.dart' as di;
import '../../../../const/colors.dart';
import '../components/title_delegate.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    return BlocProvider(
      create: (BuildContext context) => di.sl<WeatherCubit>()
        ..locationService()
        ..getInfoByCity(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          var cubit = WeatherCubit.get(context);
          return Scaffold(
            backgroundColor: AppColors.lightBackground,
            drawer: const Drawer(),
            body: state is WeatherGetInfoLoading
                ? const Center(child: SingleChildScrollView())
                : CustomScrollView(
                    slivers: [
                      SliverPersistentHeader(
                        delegate: AppBarDelegate(
                            maximumExtent: 300,
                            minimumExtent: 220,
                            cubit: cubit),
                        pinned: true,
                      ),
                      SliverToBoxAdapter(
                        child: Column(children: [
                          Container(
                              child: Container(
                            child: Column(
                              children: [
                                Text(cubit.myCityInfo?.dateText ?? ''),
                                Image.network(
                                  cubit.myCityInfo?.weather![0].icon ?? '',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                    '${cubit.myCityInfo?.main?.temp?.toString()}°' ??
                                        '')
                              ],
                            ),
                          )),
                          Container(
                              child: Container(
                            child: Column(
                              children: [
                                Text(cubit.myCityInfo?.dateText ?? ''),
                                Image.network(
                                  cubit.myCityInfo?.weather![0].icon ?? '',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                    '${cubit.myCityInfo?.main?.temp?.toString()}°' ??
                                        '')
                              ],
                            ),
                          )),
                          Container(
                              child: Container(
                            child: Column(
                              children: [
                                Text(cubit.myCityInfo?.dateText ?? ''),
                                Image.network(
                                  cubit.myCityInfo?.weather![0].icon ?? '',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                    '${cubit.myCityInfo?.main?.temp?.toString()}°' ??
                                        '')
                              ],
                            ),
                          )),
                          Container(
                              child: Container(
                            child: Column(
                              children: [
                                Text(cubit.myCityInfo?.dateText ?? ''),
                                Image.network(
                                  cubit.myCityInfo?.weather![0].icon ?? '',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                    '${cubit.myCityInfo?.main?.temp?.toString()}°' ??
                                        '')
                              ],
                            ),
                          )),
                          Container(
                              child: Container(
                            child: Column(
                              children: [
                                Text(cubit.myCityInfo?.dateText ?? ''),
                                Image.network(
                                  cubit.myCityInfo?.weather![0].icon ?? '',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                    '${cubit.myCityInfo?.main?.temp?.toString()}°' ??
                                        '')
                              ],
                            ),
                          )),
                          Container(
                              child: Container(
                            child: Column(
                              children: [
                                Text(cubit.myCityInfo?.dateText ?? ''),
                                Image.network(
                                  cubit.myCityInfo?.weather![0].icon ?? '',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                                Text(
                                    '${cubit.myCityInfo?.main?.temp?.toString()}°' ??
                                        '')
                              ],
                            ),
                          )),
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
