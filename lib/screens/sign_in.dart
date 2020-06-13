import 'package:bloggie/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../elements/auth_elements.dart';
import 'homepage.dart';
import 'reset_password.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final isAuthenticating = Provider.of<AuthService>(context).isAuthenticating;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 20.0),
           Padding(
             padding: EdgeInsets.all(10.0),
             child:  Form(
               key: _formKey,
               autovalidate: false,
               child: Column(
                 children: <Widget>[
                   Container(
                     decoration: BoxDecoration(
                       color: Colors.grey[300],
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                     ),
                     child: Row(
                       children: <Widget>[
                         SizedBox(
                           width: 14.0,
                         ),
                         Icon(Icons.email),
                         SizedBox(
                           width: 14.0,
                         ),
                         Expanded(
                             child: TextFormField( validator: validateEmail,
                               controller: _emailController,
                               decoration: InputDecoration(
                                   hintText: 'Email Address', border: InputBorder.none),
                             )),
                         SizedBox(
                           width: 14.0,
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height: 20.0),
                   Container(
                     decoration: BoxDecoration(
                       color: Colors.grey[300],
                       borderRadius: BorderRadius.all(Radius.circular(10)),
                     ),
                     child: Row(
                       children: <Widget>[
                         SizedBox(
                           width: 14.0,
                         ),
                         Icon(Icons.lock),
                         SizedBox(
                           width: 14.0,
                         ),
                         Expanded(
                             child: TextFormField( validator: validatePassword,
                               obscureText: true,
                               controller: _passController,
                               decoration: InputDecoration(
                                   hintText: 'Password', border: InputBorder.none),
                             )),
                         SizedBox(
                           width: 14.0,
                         ),
                       ],
                     ),
                   ),
                   SizedBox(height: 20.0),
                   GestureDetector(
                     onTap: (){
                       Navigator.push(context, CupertinoPageRoute(builder: (context) => ResetPasswordPage()));
                     },
                     child: Center(
                         child: Text(
                           'Forgot Password?',
                           style: TextStyle(color: Theme.of(context).primaryColor),
                         )),
                   ),
                   isAuthenticating ? CircularProgressIndicator() : Container(
                     padding: EdgeInsets.only(bottom: 10, top: 20),
                     width: 150,
                     child: FlatButton(
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(10.0)),
                       textColor: Colors.white,
                       color: Theme.of(context).primaryColor,
                       child: Text('Sign In'),
                       onPressed: () {
                         if(_formKey.currentState.validate()){
                           Provider.of<AuthService>(context,listen: false).authenticating();
                           Provider.of<AuthService>(context,listen: false).loginUser(_emailController.text, _passController.text).then((value) =>
                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) =>
                                           HomePage())));
                         }
                       },
                     ),
                   ),
                 ],
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}
