import 'package:conditional_builder/conditional_builder.dart';
import 'package:data_base/Shared/cubit/cubit.dart';
import 'package:data_base/modules/web_view/web_view_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity ,
 Color background = Colors.blue,
  double radius= 0.0,
 @required Function function,
 @required String text,
  bool isUpperCase = true

})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child:
  Container(
    decoration: BoxDecoration(
        color: background ,
        borderRadius: BorderRadius.circular(radius)
    ),
       width:width,
       height: 40 ,
    child:
    MaterialButton(
      onPressed:function,

      child: Text(
        isUpperCase? text.toUpperCase():text ,
        style: TextStyle(color: Colors.white),),),
  ),
);


Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true
})=> TextFormField(
keyboardType: type,
obscureText: isPassword,
enabled:isClickable ,
onFieldSubmitted: onSubmit,
onChanged: onChange,
onTap: onTap,
validator: validate,
controller: controller,
decoration: InputDecoration(
labelText: label,
prefixIcon: Icon(
prefix,
),
    suffixIcon:suffix!=null? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
      ),
    ):null,
border: OutlineInputBorder(
)
),
);
Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),

  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text('${model['time']}'),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            mainAxisSize:MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text('${model['title']}'

                ,style: TextStyle(

                  fontSize: 18,

                  fontWeight: FontWeight.bold,

                ),

              ),

              Text(

                '${model['date']}',

                style: TextStyle(

                  color:Colors.grey,

                ),

              )



            ],

          ),

        ),

        SizedBox(

          width: 20,

        ),

        IconButton(icon: Icon(Icons.check_box),

            color: Colors.green,

            onPressed: (){

          AppCubit.get(context).updateData(

              status: 'done', id: model['id']);

            }),

        IconButton(icon: Icon(Icons.archive),

            color: Colors.black45,



            onPressed: (){

              AppCubit.get(context).updateData(

                  status: 'archive', id: model['id']);

            }),



      ],

    ),

  ),
  onDismissed:(direction){

    AppCubit.get(context).deleteData(id:model['id'] );

  } ,
);
Widget tasksBuilder({
  @required List<Map> tasks
})=>ConditionalBuilder(
  condition:tasks.length>0 ,
  builder:(context)=>ListView.separated(itemBuilder: (context,index)=> buildTaskItem(tasks[index],context)
      , separatorBuilder: (context,index)=>myDivider()
      , itemCount: tasks.length ),
  fallback: (context)=>Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(
            Icons.menu,
            size: 100.0,
            color: Colors.grey),

        Text('No Tasks Yet ,Please Add Some Tasks',
          style: TextStyle(
              fontSize: 20,
              fontWeight:FontWeight.bold,
              color: Colors.grey
          ) ,)
      ],
    ),
  ),
);
Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 20.0
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
Widget buildArticleItem(article,context)=>InkWell(
  onTap:(){
    
    navigateTo(context, WebViewScreen(article['url']));
  } ,
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 120,
  
          height: 120,
  
          decoration: BoxDecoration(
  
              borderRadius:   BorderRadius.circular(10),
  
              image: DecorationImage(
  
                  image: NetworkImage('${article['urlToImage']}'),
  
                  fit: BoxFit.cover
  
              )
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
          child: Container(
  
            height: 120,
  
            child: Column(
  
                mainAxisSize: MainAxisSize.max,
  
                crossAxisAlignment: CrossAxisAlignment.start,
  
                mainAxisAlignment: MainAxisAlignment.start,
  
                children: [
  
                  Expanded(
  
                    child: Text('${article['title']}',
  
                      style: Theme.of(context).textTheme.bodyText1,
  
                      maxLines: 3,
  
                      overflow: TextOverflow.ellipsis,
  
                    ),
  
  
  
                  ),
  
                  Text(
  
                    '${article['publishedAt']}',
  
                    style: TextStyle(color: Colors.grey),
  
                  )
  
                ]
  
  
  
            ),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);
Widget articleBuilder(list,)=> ConditionalBuilder(
  condition: list.length>0,
  builder:(context)=> ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context,index)=>
          buildArticleItem(list[index],context),
      separatorBuilder: (context,index)=>myDivider(),
      itemCount: 20),
  fallback:(context)=>Center(child: CircularProgressIndicator()),
);
void navigateTo(context,widget)=> Navigator.push(
  context, MaterialPageRoute(
  builder: (context)=>widget,
)
);
