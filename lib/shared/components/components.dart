import 'package:flutter/material.dart';

import '../colors.dart';

PreferredSizeWidget AppBarComponent({
  required String text,
  Function? pressed,
  bool pop = false,
  bool center = false,
  Color color = Colors.white,
  List<Widget>? action,


})=>
    AppBar(
      automaticallyImplyLeading: false,

      backgroundColor: color,
      elevation: 0,
      centerTitle: center,
      title: Text( text),
      leading:pop ?IconButton(
        onPressed: (){
          pressed!();
        },
        icon: Icon(Icons.arrow_back_ios_new,
          color: mainColor,),
      ):null,
      actions: action,

    );

Widget AchatStats({
  required IconData icon,
  required String firstText,
  required String secondText,


})=>
    Column(

      children: [

        Icon(icon,color: secondTextColor, size: 30,),

        Padding(

          padding: const EdgeInsets.all(10.0),

          child:   Text(firstText,style: TextStyle(



            color: mainColor,



            fontWeight: FontWeight.bold,



            fontSize: 20,







          ),),

        ),

        Text(secondText,style: TextStyle(

          color: secondTextColor,

          fontWeight: FontWeight.bold,

          fontSize: 18,



        ),),

      ],


    );
