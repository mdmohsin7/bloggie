import 'package:bloggie/models/articles.dart';
import 'package:bloggie/providers/article_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'article_overview.dart';
import 'package:animations/animations.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    String _selectedCategory =
        Provider.of<ArticleProvider>(context, listen: false).selectedCategory;
    return StreamBuilder(
        stream: _selectedCategory.length < 4
            ? Firestore.instance
                .collection('articles')
                .orderBy('date')
                .snapshots()
            : Firestore.instance
                .collection('articles')
                .where('category', isEqualTo: _selectedCategory)

                .snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              DocumentSnapshot explore = snapshot.data.documents[index];
              if(snapshot.hasData){
                return OpenContainer(
                  closedElevation: 0,
                  closedBuilder: (context, action) {
                    return Container(
                      height: 130,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.grey,blurRadius: 0.5)
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      margin: EdgeInsets.all(10.0),padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 110,
                            width: 110,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage(explore['image url']),fit: BoxFit.fill),
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(width: 235,child: Text(explore['title'],style: TextStyle(fontWeight: FontWeight.bold),)),
                                Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                  ),
                                  child: Text(
                                    explore['category'],
                                    style: TextStyle(color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Text(explore['date']),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return ArticleOverView(
                      uid: explore['user id'],
                      title: explore['title'],
                      description: explore['description'],
                      category: explore['category'],
                      imgUrl: explore['image url'],
                      author: explore['author name'],
                      date: explore['date'],
                    );
                  },
                );
              }else{
                return Center(child: Text('No articles found'),);
              }
            },
          );
        });
  }
}
