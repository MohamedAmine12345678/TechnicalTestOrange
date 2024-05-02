


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../shared/colors.dart';
import '../shared/local/cash_helper.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  String gender = "0";
  String? imageSave ;
  File? image = null;
  @override
  void initState() {
    CashHelper.getData(key: 'account').then((value) {
      setState(() {
        nameController.text = value![0];
      });
    });
    CashHelper.getData(key: "profile").then((value) {
      print(value);
      setState(() {
        imageSave = value![0];
        image = File(imageSave!);
        Image.file(image!);

        gender = value[2];
        ageController.text = value[3];
        emailController.text = value[4];
      });

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: mainColor,
                ),
                child: IconButton(
                  onPressed: () {
                    List<String> donne = [imageSave!,nameController.text,gender,ageController.text,emailController.text];
                    CashHelper.getData(key: 'account').then((value) {
                      List<String>? account = value;
                      account![0] = nameController.text;
                      CashHelper.putData(key: "account", value: account);
                    });


                    CashHelper.putData(key: "profile", value: donne).then((value) {
                      Navigator.pop(context);


                    });
                  },
                  icon: const Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ),
            ),],

        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Account",style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          backgroundImage: image != null ?FileImage(image!) : null,
                          radius: 70,
                          child: image == null ? Icon(Icons.person,
                            size: 70,
                            color: Colors.grey,): null,
                        ),
                        SizedBox(height: 20,),
                        TextButton(
                          onPressed: (){
                            cameraImage();
                          },
                          child: Text("Uplode Photo",style: TextStyle(
                              color: mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                          ),),
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Name",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),

                    SizedBox(
                      width: 240,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder( //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 20,),

                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Gender",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: 50,),
                    CircleAvatar(
                      backgroundColor: gender == "0" ? mainColor : Colors.grey[200],
                      radius: 30,
                      child: IconButton(onPressed: (){
                        setState(() {
                          gender = "0";
                        });

                      },
                          icon: Icon(Icons.male,
                          size: 30,
                          color: gender == "0" ?Colors.white : Colors.grey,),),
                    ),
                    SizedBox(width: 20,),
                    CircleAvatar(
                      backgroundColor: gender == "1" ? mainColor : Colors.grey[200],
                      radius: 30,
                      child: IconButton(onPressed: (){
                        setState(() {
                          gender = "1";
                        });
                      },
                        icon: Icon(Icons.female,
                          size: 30,
                        color: gender =="1" ?Colors.white : Colors.grey,),),
                    ),
                  ],

                ),
                SizedBox(height: 20,),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Age",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),

                    SizedBox(
                      width: 240,
                      child: TextField(
                        controller: ageController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder( //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 20,),

                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Emali",style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),),

                    SizedBox(
                      width: 240,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder( //<-- SEE HERE
                            borderSide: BorderSide(
                                width: 1, color: Colors.grey),
                          ),
                        ),
                      ),
                    )

                  ],
                ),


                SizedBox(height: 20,),







              ],
            ),
          ),
        ),


    );
  }
  Future cameraImage() async {
    final saveimg = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (saveimg == null) return null;

    setState(() {

      imageSave = saveimg.path;
      image = File(imageSave!);
    });
    Image.file(image!);

  }
}
