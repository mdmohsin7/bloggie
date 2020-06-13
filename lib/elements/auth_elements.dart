import 'package:flutter/material.dart';

class FormTypeField extends StatefulWidget {
  FormTypeFieldState createState() => FormTypeFieldState();

 final TextEditingController controller;
 final String hinttext;
 final bool obstext;
 final IconData icon;
 final String validator;
 const FormTypeField({Key key,@required this.validator, @required this.controller,@required this.hinttext,@required this.obstext, @required this.icon}) : super(key: key);
}

class FormTypeFieldState extends State<FormTypeField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 14.0,
          ),
          Icon(widget.icon),
          SizedBox(
            width: 14.0,
          ),
          Expanded(
              child: TextFormField(
                obscureText: widget.obstext,
                controller: widget.controller,
            decoration: InputDecoration(
                hintText: widget.hinttext, border: InputBorder.none),
          )),
          SizedBox(
            width: 14.0,
          ),
        ],
      ),
    );
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter a valid Email Address';
  else
    return null;
}

String validateName(String value){
  if(value.length < 6)
    return 'Name too short, minimum length is 6';
  else
    return null;
}

String validatePassword(String value){
  if(value.length < 6)
    return 'Password is too short, minimum length is 6';
  else
    return
        null;
}