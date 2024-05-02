

import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_planning_app/view/home_screen.dart';

import '../shared/colors.dart';
import '../shared/components/components.dart';
import '../shared/local/cash_helper.dart';
import '../shared/remote/dio_helper.dart';
import '../shared/remote/dio_helper_api.dart';
import '../shared/strings.dart';


class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {

  String? imageSave ;
  String? username;
  String? credit;
  File? image;
  bool pageVisibale = false;
  late Future<Map<String, dynamic>> apiDataFuture;
  @override
  void initState() {
    apiDataFuture = getProfileData();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<Map<String,dynamic>>(
          future: apiDataFuture,
          builder: (context, snapshot) {
            var document = snapshot.data;

    if (snapshot.hasError) {
    print(snapshot.error);
    if (snapshot.error == 'connection timeout')
    return Center(
    child: Text('connection probleme')
    );
    else {
    return Center(
    child:Text('undifined probleme')
    );
    }
    }
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(
    child: CircularProgressIndicator());
    }
    if (snapshot.data!.isEmpty || snapshot.error == 'Failed to load data') {
    return Center(
    child:Text('ther is no posts')
    );
    }
    else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 95,
                        backgroundColor: mainColor,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          radius: 90,
                          child:ClipOval(
                            child: Image.network(document!['image'],
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
                                  child: Image(image: AssetImage('assets/images/avatar.png'),),
                                );
                              },),
                          ),

            ),
                      ),SizedBox(height: 10,),
                      Text(document!['name'],style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500
                      ),),

                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                // Row(
                //   children: [
                //     Expanded(
                //       child: AchatStats(
                //           icon: Icons.shopping_bag,
                //           firstText: '$credit TND',
                //           secondText: 'In total',),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //       child: AchatStats(
                //         icon: Icons.shopping_bag,
                //         firstText: '0 TND',
                //         secondText: 'Withdraw',),
                //     ),
                //
                //
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                Text( 'Pages',style: TextStyle(
                    fontSize: 25),),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all( 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey,width: 1),

                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment:MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[400],
                            radius: 50,
                            child:ClipOval(
                              child: Image.network(document!['pageImage'],
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
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
                                    child: Image(image: AssetImage('assets/images/avatar.png'),),
                                  );
                                },),
                            ),

                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(document['pageName'],style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('Posts : ',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                  Text(document['posts'],style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Text('Category : ',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w500),),
                                  Text(document['category'],style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400),),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                      SizedBox(height: 10,),
                      Text('App Tasks : ',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w600),),
                      SizedBox(height: 3,),
                      Divider(color: Colors.grey,thickness: 1,endIndent: 5,indent: 5,),
                      SizedBox(height: 3,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              document['tasks'],style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w400,),
                              maxLines: 4,
                            textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),




              ],
            );
    }
          }
        ),
      ),
    );
  }
  Future<Map<String,dynamic>> getProfileData() async {

    try {

      final response = await DioHelper.postData(url: 'me?',
        data: {
          "access_token": userAccesToken,

        },
        query: {
          "fields": "id,name,picture,gender,birthday,age_range,accounts"
          //accounts
        }

          // ,picture,gender,accounts,birthday,age_range

      );
      final response1 = await DioHelper.getData(url: '307155022475306?',
          query: {
            "access_token": PageaccesToken,
            "fields": "id,name,posts,picture,category"

          },//
      );// Replace with your API endpoint
      Map<String, dynamic> data1 = json.decode(response1.data);
      print(data1['posts']['data']);
      List<dynamic> l = data1['posts']['data'];
      String posts = l.length.toString();

        print("done");
        print("this is data : ${response.data} ----------------------------------------------------------");
      Map<String, dynamic> data = json.decode(response.data);
      List<dynamic> t = data['accounts']['data'][0]['tasks'];
      String tasks = t.join(', ');



        Map<String,dynamic> result = {
          'name': data['name'],
          'image': data['picture']['data']['url'],
          'pageName': data1['name'],
          'pageImage': data1['picture']['data']['url'],
          'posts': posts,
          'category': data1['category'] ?? 'no category',
          'tasks': tasks


        };
        // DateTime now = DateTime.now();
        // print(now);


        print(result);

        return result;

    } catch (error) {
      print(error);
      if (error is DioException && (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.connectionError)){
        // Handle connection timeout error
        return Future.error('connection timeout');
      }
      else if (error is DioException) {
        return Future.error('connection other');
      }


      // print(error.response);
      // print('Error message: ${error.error}');
      // print('Error description: ${error.message}');
      else {
        return Future.error('connection other');
      }
    }
  }

}
