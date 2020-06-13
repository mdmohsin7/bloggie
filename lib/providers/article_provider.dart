import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:image_picker/image_picker.dart';

class ArticleProvider with ChangeNotifier {
  bool _isImageSelected = false;
  File _selectedImage;
  String _selectedCategory = 'All';
  bool _isUploaded = false;
  String _imgUrl;
  StorageUploadTask _uploadTask;
  final picker = ImagePicker();

  //getters
  bool get isUploaded => _isUploaded;
  String get imgUrl => _imgUrl;
  String get selectedCategory => _selectedCategory;
  bool get isImageSelected => _isImageSelected;
  File get selectedImage => _selectedImage;

  Firestore db = Firestore.instance;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://bloggie-app.appspot.com');

  void imageSelected() {
    _isImageSelected = true;
  }

  void selectImage() async {
    final image = await picker.getImage(source: ImageSource.gallery);
    _selectedImage = File(image.path);
    notifyListeners();
  }

  void changeCategory(selected) {
    _selectedCategory = selected;
    notifyListeners();
  }

  void startUpload(title, description, category, name, uploadTime) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final _userId = user.uid;
    print(_userId);
    if (_userId != null) {
      String filePath = 'images/$selectedCategory/$title.png';
      _uploadTask = _storage.ref().child(filePath).putFile(_selectedImage);
      (await _uploadTask.onComplete)
          .ref
          .getDownloadURL()
          .then((imageUrl) async =>
              await Firestore.instance.collection('articles').add({
                'title': title,
                'author name': name,
                'description': description,
                'category': category,
                'date': uploadTime,
                'image url': imageUrl,
                'user id': _userId,
              }))
          .then((value) async {
        DocumentReference ref =
            Firestore.instance.collection('users').document(_userId);
        DocumentSnapshot userDetails = await ref.get();
        int userArticles = userDetails['articles'] + 1;
        ref.updateData({'articles': userArticles}).then(
            (value) => _isUploaded = false);
      });
    }
    notifyListeners();
  }
}
