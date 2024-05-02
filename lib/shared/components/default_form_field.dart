import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../colors.dart';

class DefaultFormField extends StatefulWidget {
  final TextEditingController contoller;
  final TextInputType type;
   int maxLine;
       Function? validate;
       Function? onChange;
       Function? tab;
      final String label;
      bool suffix ;
      bool isPassword ;
  IconData? prefix;
  bool read ;




   DefaultFormField({super.key, required this.contoller, required this.type,  this.validate,
     required this.label,  this.suffix = false,this.onChange  ,this.tab,this.prefix,this.read = false,this.maxLine = 0,
     this.isPassword = false});

  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  Function? submited;



  Function? suffixPressed;






  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.read,

      onTapOutside: (event){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      onChanged: (value){

         widget.onChange!(value);
      },


      maxLines: widget.maxLine == 0 ? 1 :null,
      textAlign: TextAlign.start,
      textAlignVertical: TextAlignVertical.center,
      scrollPadding: EdgeInsets.zero,
      cursorHeight: 20,
      controller: widget.contoller ,
      keyboardType: widget.type,
      validator: (String? value){
        return widget.validate!(value);
      },


      onTap: ()
      {
        widget.tab!();
      },

      style: GoogleFonts.ibmPlexSansArabic(
          fontSize: 16,
          color: Colors.black,),



      cursorColor: TextColor ,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: GoogleFonts.ibmPlexSansArabic(
          fontWeight: FontWeight.w500,
          fontSize: 20,
          color: TextColor,
        ),
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 18, 10, 18),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
              color: TextColor,
              width: 1.5
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: redColor,
            width: 1.0,
          ),
        ),

        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(10.0),
        //   borderSide: BorderSide(
        //     color: redColor,
        //     width: 2.0,
        //   ),
        // ),





        prefixIcon: widget.prefix != null ? Icon(widget.prefix,
          color:TextColor,
        ) : null,
        suffixIcon: widget.suffix == true ? IconButton(icon:
        Icon(widget.isPassword == true ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: Colors.black,
        size: 22,),
          onPressed: (){
          setState(() {
            widget.isPassword = !widget.isPassword;
          });
        },
        ) : null,

      ),
    );
  }

}
