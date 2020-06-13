import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/articles.dart';





class FirestoreService {
  Firestore _db = Firestore.instance;

  Stream<List<Articles>> getArticles() {
    return _db
        .collection('articles')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Articles.fromJson(document.data))
            .toList());
  }


}



