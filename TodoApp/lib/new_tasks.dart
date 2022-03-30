import 'package:conditional_builder/conditional_builder.dart';
import 'package:data_base/Shared/cubit/cubit.dart';
import 'package:data_base/Shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components.dart';
import 'constants.dart';

class NewTasksScreenScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context){
    return BlocConsumer<AppCubit,AppStates>(
     listener: (context,state){},
      builder: (context,state){
       var tasks = AppCubit.get(context).newTasks;
       
       return tasksBuilder(tasks: tasks);
      },
    );
  }
}
