import 'package:data_base/modules/business/business_screen.dart';
import 'package:data_base/modules/science/science_screen.dart';
import 'package:data_base/modules/settings/settings_screen.dart';
import 'package:data_base/modules/sports/sports%20screen.dart';
import 'package:data_base/network/remote/dio_helper.dart';
import 'package:data_base/news%20app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());
  static NewsCubit get (context)=>BlocProvider.of(context);

  int currentIndex = 0;
List <BottomNavigationBarItem> bottomItem = [
  BottomNavigationBarItem(
      icon:Icon(Icons.business),
  label:'Business' ),
  BottomNavigationBarItem(
      icon:Icon(Icons.sports),
      label:'Sports' ),
  BottomNavigationBarItem(icon:Icon(Icons.science),
      label:'Science' ),
];
List<Widget> screens =[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),

];
void changeBottomNavBar(int index){

  currentIndex = index;
  if(index==1) getSports();
  if(index==2) getScience();
  emit(NewsBottomNavState());
}
List<dynamic> business =[];
void getBusiness()
{
  emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines',
      query:{
        'country':'us',
        'category':'business',
        'apiKey':'efb7db1bcf0e43569a19b2170d64ac46',

      }
  ).then((value){
    //print(value.data['articles'][1]['title']);
    business = value.data['articles'];
    print(business[0]['title']);
    emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });

}

  List<dynamic> sports =[];
void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:{
            'country':'us',
            'category':'Sports',
            'apiKey':'efb7db1bcf0e43569a19b2170d64ac46',

          }
      ).then((value){
        //print(value.data['articles'][1]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());


    }


  }

  List<dynamic> science =[];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:{
            'country':'us',
            'category':'Science',
            'apiKey':'efb7db1bcf0e43569a19b2170d64ac46',

          }
      ).then((value){
        //print(value.data['articles'][1]['title']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSciencesErrorState(error.toString()));
      });
    }
    else{
      emit(NewsGetScienceSuccessState());

    }


  }

  List<dynamic> search =[];
  void getSearch(String value)
  {

    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
        url: 'v2/everything',
        query:{
          'q':'$value',
          'apiKey':'efb7db1bcf0e43569a19b2170d64ac46',

        }
    ).then((value){
      //print(value.data['articles'][1]['title']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });


  }
}