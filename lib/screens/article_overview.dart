import 'package:bloggie/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleOverView extends StatefulWidget {
  final String title;
  final String description;
  final String category;
  final String date;
  final String imgUrl;
  final String author;
  final String uid;

  const ArticleOverView(
      {@required this.title,
      @required this.category,
      @required this.description,@required this.date, @required this.imgUrl,@required this.author, @required this.uid});

  @override
  _ArticleOverViewState createState() => _ArticleOverViewState();
}

class _ArticleOverViewState extends State<ArticleOverView> {
  bool donatedStatus;
  @override
  Widget build(BuildContext context) {
    donatedStatus = Provider.of<AuthService>(context).donatedStatus;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[],
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                child: Text(
                  widget.category,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Container(
              height: 160,
              width: 340,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                image: DecorationImage(image: NetworkImage(widget.imgUrl),fit: BoxFit.fill),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
            ),
            Text(widget.description),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Written by: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.author),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('Published on: ',style: TextStyle(fontWeight: FontWeight.bold),),
                        Text(widget.date),
                      ],
                    ),
                  ],
                ),
                RaisedButton(
                  child: donatedStatus ? Text(
                    'Donated',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ) : Text(
                    'Donate',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                    color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    Provider.of<AuthService>(context,listen: false).donate(widget.uid);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
