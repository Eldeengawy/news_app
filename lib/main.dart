import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app_cubit/cubit.dart';
import 'package:news_app/app_cubit/states.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/layout/news_layout.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(
      // Bloc.observer = MyBlocObserver();

      MyApp(
    isDark: isDark ?? false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isDark}) : super(key: key);
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()),
        BlocProvider(
          create: (BuildContext context) =>
              AppCubit()..changeMode(fromShared: isDark),
        )
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News app',
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  elevation: 20.0),
            ),
            darkTheme: ThemeData(
              inputDecorationTheme: const InputDecorationTheme(
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIconColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white))),
              scaffoldBackgroundColor: const Color(0xff333739),
              primarySwatch: Colors.deepOrange,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xff333739),
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Color(0xff333739),
                    statusBarIconBrightness: Brightness.light),
                elevation: 0.0,
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.grey,
                  backgroundColor: Color(0xff333739),
                  elevation: 20.0),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
