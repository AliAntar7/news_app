import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/home.dart';
import 'package:news_app/shared/bloc/bloc_observer.dart';
import 'package:news_app/shared/bloc/cubit.dart';
import 'package:news_app/shared/bloc/states.dart';
import 'package:news_app/shared/network/cache_helper.dart';
import 'package:news_app/shared/network/dio_helper.dart';


//https://newsapi.org/v2/everything?q=tesla&apiKey=c6b3413a671f4f99baaf601734f9d62a



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');

  BlocOverrides.runZoned(()
    {
      runApp(MyApp(isDark!));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget
{
  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
    create: (context) => NewsCubit()..getBusiness()..changeMode(fromShared: isDark,),
     child: BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state)
      {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.white,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: HexColor('333739'),
            appBarTheme: AppBarTheme(
              titleSpacing: 20.0,
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: HexColor('333739'),
              elevation: 0.0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: HexColor('333739'),
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: Home(),
        ) ;
      },
     ),
    );
  }
}