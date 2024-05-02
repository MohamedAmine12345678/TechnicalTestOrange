

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

Widget CardComponet ({

  required String title,
  required String description,
  required String date,
  required String image

})=>Container(
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 2,
        blurRadius: 3,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],
  ),


  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Container(
          height: 200,
          width: double.infinity,
          child: Image.network(image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: mainColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
            errorBuilder: (context, error, stackTrace) {
              return  Center(
                child: Text('probleme in image',style: GoogleFonts.ibmPlexSansArabic(
                    color: Colors.black,
                    fontSize: 20
                ),),
              );
            },),
        ),
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: null,
                  style: GoogleFonts.roboto(
                      fontSize:16 ,
                      fontWeight:FontWeight.w600 ,
                      color: Colors.black
                  ),
                ),
                Visibility(
                  visible: description.isNotEmpty,
                  child: Text(
                    description,
                    maxLines: null,
                    style: GoogleFonts.ibmPlexSansArabic(
                        fontSize:14 ,
                        fontWeight:FontWeight.w400 ,
                        color: Color(0xff4D4D4D)
                    ),
                  ),
                ),


              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 10),
            decoration: BoxDecoration(
              color: purpleOp,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Text('published in : ',
                  style: GoogleFonts.ibmPlexSansArabic(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),),

                Text(date ,
                  style: GoogleFonts.ibmPlexSansArabic(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                  ),),
              ],
            ),
          ),
        ],
      ),


    ],
  ),
);