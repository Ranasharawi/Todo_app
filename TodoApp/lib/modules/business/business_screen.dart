import 'package:conditional_builder/conditional_builder.dart';
import 'package:data_base/Shared/cubit/cubit.dart';
import 'package:data_base/components.dart';
import 'package:data_base/news%20app/cubit/cubit.dart';
import 'package:data_base/news%20app/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key  key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder:(context,state){
        var list = NewsCubit.get(context).business;
        return articleBuilder(list);
      } ,
    );
  }
}
