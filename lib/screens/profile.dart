import 'package:bloggie/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_in.dart';


class ProfilePage extends StatelessWidget {
  final String email;
  const ProfilePage({this.email});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('users').where('email', isEqualTo: email).snapshots(),
      builder: (context, snapshot) {
        DocumentSnapshot details = snapshot.data.documents[0];
        return Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 12.0,left: 12.0,right: 12.0),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 120.0,
                left: 20.0,
                child: Container(
                  width: 340,
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          color: Colors.grey,
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Full Name:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(details['full name'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 18.0,
                        ),
                        Text('Email Address:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(details['email'],
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 320,
                left: 20.0,
                child: Container(
                  height: 60,
                  width: 340,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 1.5,
                          color: Colors.grey,
                        ),
                      ]),
                  child:  Center(child: Text('Published Articles : ${details['articles']}'),),
                ),
              ),
              Positioned(
                top: 400,
                left: 20.0,
                child: GestureDetector(
                  child: Container(
                    height: 60,
                    width: 340,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.5,
                            color: Colors.grey,
                          ),
                        ]),
                    child:  Center(child: Text('Total Earnings : ${details['balance']}\$'),),
                  ),
                ),
              ),
              Positioned(
                top: 480,
                left: 20.0,
                child: GestureDetector(
                  child: Container(
                    height: 60,
                    width: 340,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.5,
                            color: Colors.grey,
                          ),
                        ]),
                    child: Center(
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  onTap: (){
                    Provider.of<AuthService>(context,listen: false).logOutUser();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage(),));
                  },
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
