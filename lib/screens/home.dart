import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'article_overview.dart';
import '../models/articles.dart';
import 'package:animations/animations.dart';



class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    var articles = Provider.of<List<Articles>>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 8.0, top: 12.0),
            child: Text(
              'Featured Articles',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: 200,
            child: StreamBuilder(
              stream: Firestore.instance.collection('featured articles').snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DocumentSnapshot fa = snapshot.data.documents[index];
                        return GestureDetector(
                          child: Container(
                            margin: EdgeInsets.all(8.0),
                            height: 200,
                            width: 160,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(color: Colors.grey,blurRadius: 1.0)
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 160,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(fa['image url']),fit: BoxFit.fill),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(fa['title'],style: TextStyle(fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleOverView(
                                    uid: fa['user id'],
                                    date: fa['date'],
                                    author: fa['author name'],
                                    imgUrl: fa['image url'],
                                      title: fa['title'],
                                      category: fa['category'],
                                      description: fa['description'])));
                          },
                        );
                      },
                      itemCount: snapshot.data.documents.length);
                }
                return CircularProgressIndicator();
              }
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, bottom: 8.0, top: 10.0),
            child: Text(
              'Articles For You',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                Articles newarticles = articles[index];
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
                              image: DecorationImage(image: NetworkImage(newarticles.imgUrl),fit: BoxFit.fill),
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
                                Container(width: 235,child: Text(newarticles.title,style: TextStyle(fontWeight: FontWeight.bold),)),
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
                                    newarticles.category,
                                    style: TextStyle(color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Text(newarticles.date),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  openBuilder: (context, action) {
                    return ArticleOverView(
                        author: newarticles.author,
                        date: newarticles.date,
                        imgUrl: newarticles.imgUrl,
                        title: newarticles.title,
                        description: newarticles.description,
                        category: newarticles.category,uid: newarticles.uid);
                  },
                );
              },
              separatorBuilder: (context, int) => SizedBox(
                    height: 6.0,
                  ),
              itemCount: articles.length),
        ],
      ),
    );
  }
}
