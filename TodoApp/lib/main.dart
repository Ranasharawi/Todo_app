import 'package:bloc/bloc.dart';
import 'package:data_base/Counter/counter.dart';
import 'package:data_base/Shared/cubit/cubit.dart';
import 'package:data_base/Shared/cubit/states.dart';
import 'package:data_base/network/local/cache_helper.dart';
import 'package:data_base/network/remote/dio_helper.dart';
import 'package:data_base/news%20app/cubit/cubit.dart';
import 'package:data_base/news%20app/news_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Shared/bloc_observer.dart';
import 'home_layout.dart';
import 'login.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  blocObserver: MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();
   bool isDark = CacheHelper.getBoolean(key: 'isDark');




  runApp(MyApp(isDark));
}




//stateless
//stateful
//class My app
class MyApp extends StatelessWidget
{
  final bool isDark;
  MyApp (this.isDark);
  @override
  Widget build(BuildContext context)
  {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(create:(BuildContext context)=>AppCubit()..changeAppMode(
  fromShared: isDark,
  ),)
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner:false,
            theme: ThemeData(
                primarySwatch:Colors.deepOrange ,
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: AppBarTheme(
                  titleSpacing: 20,

                    backgroundColor: Colors.white,
                    elevation: 0.0,
                    backwardsCompatibility:false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                    ),
                    titleTextStyle:TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ) ,
                    iconTheme: IconThemeData(
                        color: Colors.black
                    )



                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: Colors.deepOrange
                ),

                bottomNavigationBarTheme:
                BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor:Colors.deepOrange,
                    unselectedItemColor:Colors.grey,
                    elevation: 20,
                    backgroundColor: Colors.white
                ),
                textTheme:TextTheme(
                    bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                    )

                )
            ),
            darkTheme: ThemeData(
              primarySwatch:Colors.deepOrange ,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                  backgroundColor:  HexColor('333739'),
                  elevation: 0.0,
                  backwardsCompatibility:false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light
                  ),
                  titleTextStyle:TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ) ,
                  iconTheme: IconThemeData(
                      color: Colors.white
                  )



              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.deepOrange
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor:Colors.deepOrange,
                unselectedItemColor:Colors.grey,
                elevation: 20,
                backgroundColor: HexColor('333739'),
              ),
              textTheme:TextTheme(
                  bodyText1: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )

              ),




            ),

            themeMode: AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
            home: NewsLayout (),
          );
        },
      ),
    );

  }


}
