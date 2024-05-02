import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_planning_app/shared/colors.dart';
import 'package:post_planning_app/shared/components/default_button.dart';
import 'package:post_planning_app/shared/components/default_form_field.dart';
import 'package:post_planning_app/shared/components/snack_bar.dart';
import 'package:post_planning_app/shared/remote/dio_helper.dart';
import 'package:intl/intl.dart';
import 'package:post_planning_app/shared/remote/dio_helper_api.dart';
import 'package:post_planning_app/shared/strings.dart';

class CreateShudleScreen extends StatefulWidget {
  const CreateShudleScreen({super.key});

  @override
  State<CreateShudleScreen> createState() => _CreateShudleScreenState();
}

class _CreateShudleScreenState extends State<CreateShudleScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _discriptionController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _DateController = TextEditingController();
  File? _imageFile;
  DateTime first = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool loading = false;
  var formKey = GlobalKey<FormState>();

  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Publish Shudle',
        style: GoogleFonts.ibmPlexSansArabic(
          color: TextColor,
          fontSize: 18,
          fontWeight: FontWeight.w600
        ),),
        centerTitle: true,
        backgroundColor: Colors.white,


      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: purpleOp,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          cameraImage();
          
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
          
                          decoration: BoxDecoration(
                            color: Colors.black12,),
                          child: _imageFile == null
                              ? Center(child: Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.white,
                          ))
                              :  Image.file(
                            _imageFile!,
                            fit: BoxFit.cover,
                          ),
          
          
                        ),
                      ),
                    ),
                  ],
          
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DefaultFormField(
                      prefix: Icons.title,
                      contoller: _titleController,
                      type: TextInputType.text,
                      label: 'Title',
                      validate: (String value){
                        if(value.isEmpty){
                          return'Title can t be empty';
                        }
                        return null;
                      },
          
                    ),
                    SizedBox(height: 20,),
                    DefaultFormField(
                      maxLine: 1,
                      prefix: Icons.closed_caption,
                      contoller: _discriptionController,
                      type: TextInputType.text,
                      label: 'Discription',
                      validate: (String value){
                        if(value.isEmpty){
                          return'Title can t be empty';
                        }
                        return null;
                      },

                    ),
                    SizedBox(height: 20,),
                    Visibility(
                      visible: isSwitched,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DefaultFormField(
                          read: true,
                          type: TextInputType.datetime,
                          tab: () async {
                            final TimeOfDay? picked = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );

                            setState(() {
                              if (picked != null && picked != selectedTime) {
                                setState(() {
                                  selectedTime = picked;
                                  _timeController.text = selectedTime.format(context);
                                });
                              }
                            });


                          },
                          validate: (String value){
                            if(value.isEmpty){
                              return'Time can t be empty';
                            }
                            return null;
                          },
                          label: 'Temps',
                          prefix: Icons.watch_later_outlined,
                          contoller: _timeController,
                        ),
                      ),
                    ),

                    Visibility(
                      visible: isSwitched,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DefaultFormField(
                          prefix: Icons.date_range_outlined,
                          read: true,
                            contoller: _DateController,
                            type:  TextInputType.datetime,
                            label: 'Select Publish Date',
                        tab: (){
                          setState(() {
                            _selectDateFirst(context);
                          });
                        },
                          validate: (String value){
                            if(value.isEmpty){
                              return'Select Publish Date';
                            }
                            return null;
                          },),
                      ),
                    ),

                    Row(
                      children: [
                        Text('publish immediately',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 22
                            )),
                        SizedBox(width: 10,),
                        Switch(

                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });


                          },
                          activeTrackColor: purpleOp,
                          activeColor: mainColor,

                        ),

                      ],
                    ),
                    SizedBox(height: 20,),
                    DefaultButton(
                        text: 'Submit',
                        pressed: (){
                          if(loading == false){
                            if(_imageFile != null){
                              if(formKey.currentState!.validate()){
                                if(isSwitched == false){
                                  setState(() {
                                    loading = true;
                                  });
                                  PostImage(context);
                                }
                                else if(checkDateTimeValidity()){
                                  setState(() {
                                    loading = true;
                                  });
                                  PostImage(context);

                                }

                              }
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please select an image'),
                                backgroundColor: Colors.red,
                              ));
                            }


                          }
          
                        },
                        activated: true,
                    loading: loading,)
          
          
          
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future cameraImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    else{
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }



  }
  PostImage(BuildContext context) async {
    // List<String>? info = await CashHelper.getData(key: 'personalInfo');
    // int memberId = int.parse(info![0]);
    // print(data.isFullContract);

    try {

      // prepar form data to post in data base
      FormData formData1 = FormData.fromMap({
        "title":_titleController.text,
        "image":await MultipartFile.fromFile(_imageFile!.path,filename: _imageFile!.path.split('/').last),
      });
      if (_discriptionController.text.isNotEmpty) {
        formData1.fields.add(MapEntry("description",_discriptionController.text));
      }
      if (isSwitched){
        formData1.fields.add(MapEntry("date", formatTimestamp())); // Assuming you want "true" as a string
      }

      // prepare data to post in facebook api
      FormData formData = FormData.fromMap({
        "access_token": PageaccesToken,
        "message": '${_titleController.text} \n ${_discriptionController.text}',
        'source': await MultipartFile.fromFile(_imageFile!.path,),
      });
      if (isSwitched) {
        formData.fields.add(MapEntry("scheduled_publish_time", _combineDateTime().toString()));
        formData.fields.add(MapEntry("published", "false")); // Assuming you want "false" as a string
      }
      else {
        formData.fields.add(MapEntry("published", "true")); // Assuming you want "true" as a string
      }

      // final response = await DioHelper.postData(url: 'me/photos',
      //     data: formData,
      // );
      // print('success');
      // print(response.data);
      final response1 = await DioHelperApi.postData(url: 'createPost',
        data: formData1,
      );
      // Replace with your API endpoint
      print('success1');
      print(response1.data);



      // if (response.statusCode == 201) {
        setState(() {
          loading = false;
        });
        ShowSuccesSnackBar(context, 'Post Published Succufuly');
        Future.delayed(Duration(seconds: 2)).then((value) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.pop(context);
        });
      //
      //   // List<String> contractDates = List<String>.from(json.decode(item['contract_dates']));
      //   // DateTime dateTime = DateTime.parse(item['start_date']);
      //   // String formattedDate = formatArabicDate(dateTime);
      //
      // } else {
      //   setState(() {
      //     loading = false;
      //   });
      //   ShowErrorSnackBar(context, 'حدث خطأ أثناء نشر العقد الخاص بك');
      //   throw Exception('Failed to load data');
      // }
    } catch (error) {
      print(error);
      print(error);
      if (error is DioException && (error.type == DioExceptionType.connectionTimeout || error.type == DioExceptionType.connectionError)){
        // Handle connection timeout error
        setState(() {
          loading = false;
        });
        ShowErrorSnackBar(context, 'connection probleme');
        return Future.error('connection timeout');
      }
      else if (error is DioException) {
        setState(() {
          loading = false;
        });
        ShowErrorSnackBar(context, 'connection probleme');
        return Future.error('connection $error');
      }


      // print(error.response);
      // print('Error message: ${error.error}');
      // print('Error description: ${error.message}');
      else {
        setState(() {
          loading = false;
        });
        ShowErrorSnackBar(context, 'connection probleme');
        return Future.error('connection other');
      }
    }
  }
  Future<void> _selectDateFirst(BuildContext context, ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: first,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            // Customize the date picker theme here
            colorScheme: const ColorScheme.light(
              primary: TextColor, // Change primary color
              onPrimary: Colors.white, // Change text color on primary color

            ),

          ), child: child!,);
      },
    );

    if (picked != null && picked != first) {
      setState(() {
        first = picked;
        _DateController.text = DateFormat('yyyy-MM-dd').format(first);

        print(first);
      });
    }
  }
  int _combineDateTime() {
    // Combine selectedDate and selectedTime into a new DateTime object
    DateTime combinedDateTime = DateTime(
      first.year,
      first.month,
      first.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Convert combinedDateTime to Unix timestamp
    int timestamp = combinedDateTime.millisecondsSinceEpoch ~/ 1000;
    return timestamp;
  }
  bool checkDateTimeValidity() {
    // Get the current time
    DateTime currentTime = DateTime.now();
    DateTime combinedDateTime = DateTime(
      first.year,
      first.month,
      first.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    // Calculate the difference between the combinedDateTime and the current time
    Duration difference = combinedDateTime.difference(currentTime);

    // Check if the difference is more than 10 minutes
    bool isMoreThan10Minutes = difference.inMinutes > 10;

    // Check if the difference is less than 30 days
    bool isLessThan30Days = difference.inDays.abs() < 30;

    // Check if both conditions are met
    if (isMoreThan10Minutes && isLessThan30Days) {

      return true;

    } else {
      ShowErrorSnackBar(context, 'Combined date and time is not valid.');
      return false;
    }
  }



  String formatTimestamp() {
    // Convert the timestamp to DateTime
    DateTime combinedDateTime = DateTime(
      first.year,
      first.month,
      first.day,
      selectedTime.hour,
      selectedTime.minute,
    );
    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(combinedDateTime);

    return formattedDateTime;
  }

}
