import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:post_planning_app/shared/colors.dart';
import 'package:post_planning_app/shared/components/cardComponent.dart';
import 'package:post_planning_app/shared/remote/dio_helper_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> apiDataFuture;
  @override
  void initState() {
    // TODO: implement initState
    apiDataFuture = getPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder(
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
                    return ListView.separated(
                        padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 90,),
                        itemBuilder: (context, index) {
                          return CardComponet(
                              title: document[index]['title'],
                              date: document[index]['date'],
                              description: document[index]['description'],
                              image: document[index]['image']
                          );

                        }, separatorBuilder: (context, index) {
                      return SizedBox(height: 20,);

                    }, itemCount: document!.length);
                  }

                }
            ),
          ),
        ],
      )
    );
  }
  Future<List<Map<String,dynamic>>> getPosts() async {

    try {

      final response = await DioHelperApi.getData(url: 'getAllPosts',

      ); // Replace with your API endpoint
      if (response.statusCode == 200) {
        print("done");
        final List<dynamic> data = response.data['data'];


        List<Map<String,dynamic>> result = [];
        DateTime now = DateTime.now();
        print(now);


        data.map((item) {
          DateTime originalDatetime = DateTime.parse(item['date']);
          if(originalDatetime.isBefore(now)){
            String formattedDatetime = DateFormat('yyyy/MM/dd HH:mm').format(originalDatetime);

            Map<String, dynamic> combinedData = {
              'title': item['title'],
              'description': item['description'] ?? '',
              'date': formattedDatetime,
              'image': item['imageUrl'] ,



            };
            result.add(combinedData);
          }


        }).toList();

        return result;
      }  else {
        throw Exception('Failed to load data');
      }
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
