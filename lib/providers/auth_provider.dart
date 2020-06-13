import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthService with ChangeNotifier {
  String _uid;
  String _email;
  String _name;
  bool _isSignedIn;
  bool _emailSent = false;
  bool _isAuthenticating = false;
  bool _donatedStatus = false;
  Map _userDetails = {};
  String _profileEmail;

  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore db = Firestore.instance;

  //getters
  String get profileEmail => _profileEmail;
  bool get emailSent => _emailSent;
  bool get donatedStatus => _donatedStatus;
  String get name => _name;
  Map get userDetails => _userDetails;
  bool get isAuthenticating => _isAuthenticating;
  bool get isSignedIn => _isSignedIn;
  String get uid => _uid;
  String get email => _email;

  void authenticating() {
    _isAuthenticating = true;
    notifyListeners();
  }

  void checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _profileEmail = prefs.getString('email');
    _isSignedIn = prefs.getBool('signedIn');
    if (_isSignedIn == null) {
      prefs.setBool('signedIn', false);
      _isSignedIn = prefs.getBool('signedIn');
    }
    notifyListeners();
  }

  Future<bool> createUser(String name, String email, String password) async {
    try {
      AuthResult _result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (_result.user != null) {
        _uid = _result.user.uid;
        _email = _result.user.email;
        db
            .collection('users')
            .document(_result.user.uid)
            .setData({
              'full name': name,
              'email': _email,
              'user id': _uid,
              'balance': 0,
              'articles': 0,
            })
            .then((value) => getUserDetails())
            .then((value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', _email);
              prefs.setBool('signedIn', true).then((value) {
                _isSignedIn = true;
                _isAuthenticating = false;
              });
            });
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return _isSignedIn;
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      AuthResult _result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_result.user != null) {
        _uid = _result.user.uid;
        _email = _result.user.email;
        getUserDetails().then((value) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('email', _email).then((value) => _profileEmail = _result.user.email);
          prefs.setBool('signedIn', true).then((value) {
            _isSignedIn = true;
            _isAuthenticating = false;
          });
        });
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return _isSignedIn;
  }

  Future<bool> logOutUser() async {
    try {
      await _auth.signOut().then((value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', 'null');
        prefs.setBool('signedIn', false);
        _isSignedIn = false;
        _isAuthenticating = false;
      });
    } catch (e) {}
    notifyListeners();
    return _isSignedIn;
  }

  Future<void> getUserDetails() async {
    DocumentSnapshot details =
        await db.collection('users').document(_uid).get();
    _name = details['full name'];
    _userDetails = {
      'email': details['email'],
      'uid': details['user id'],
      'balance': details['balance'],
      'articles': details['articles'],
      'full name': details['full name'],
    };
    notifyListeners();
  }

  Future<bool> donate(uid)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final _userId = user.uid;
    DocumentReference details =
     db.collection('users').document(uid);
    DocumentSnapshot check =  await details.get();
    print(uid);
    print(_userId);
    print('balance is ${check['balance']}');
    if(uid != _userId){
      int  balance = check['balance'] + 5;
      print(balance);
      if(balance >= 0){
        details.updateData({'balance': balance});
        _donatedStatus = true;
      }
    }else{
      print('same user id');
       _donatedStatus = false;
    }
    notifyListeners();
    return _donatedStatus;

  }

  void resetPassword(resetEmail)async{
    try{
      await _auth.sendPasswordResetEmail(email: resetEmail).then((value) => _emailSent = true);
    }catch(e){
      print(e);
    }
  }


}
