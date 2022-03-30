import 'package:data_base/Shared/cubit/cubit.dart';
import 'package:data_base/components.dart';
import 'package:data_base/modules/srearch/search_screen.dart';
import 'package:data_base/network/remote/dio_helper.dart';
import 'package:data_base/news%20app/cubit/cubit.dart';
import 'package:data_base/news%20app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context , state){
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('NewsApp'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: (){
                  AppCubit.get(context).changeAppMode();
                },),

            ],
          ),

          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItem,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);

            },
          ),
        );
      },

    );
  }
}