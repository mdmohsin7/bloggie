import 'package:bloggie/elements/fade_indexed_stack.dart';
import 'package:bloggie/elements/home_elements.dart';
import 'package:bloggie/providers/article_provider.dart';
import 'package:bloggie/providers/auth_provider.dart';
import 'package:bloggie/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';

import 'add_article.dart';
import 'explore.dart';
import 'home.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name;
  final List<String> categories = [ 'All','Business', 'DIY','Fashion', 'Food', 'Finance','Fitness', 'Gaming', 'LifeStyle','Movie','Music', 'Politics','Sports', 'Travel'];

  @override
  Widget build(BuildContext context) {
    final index = Provider.of<NavigationProvider>(context).navIndex;
    final email = Provider.of<AuthService>(context).profileEmail;
     name = Provider.of<AuthService>(context).name;
    final String selectedCategory = Provider.of<ArticleProvider>(context,listen: true).selectedCategory;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${Provider.of<NavigationProvider>(context).appBarTitle}',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          index == 0 ?
          Row(
            children: <Widget>[
              SizedBox(
                width: 8.0,
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ) : index == 1 ?
          Row(
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              GestureDetector(
                child: Icon(
                  Icons.category,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: (){
                  SelectDialog.showModal<String>(context,
                    label: 'Select a Category',
                    titleStyle: TextStyle(color: Color(0xff3f38dd)),
                    showSearchBox: false,
                    items: categories,
                    selectedValue: selectedCategory,
                    onChange: (String selected){
                    Provider.of<ArticleProvider>(context,listen: false).changeCategory(selected);
                    print(selectedCategory);
                    }
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
            ],
          ) : index == 2 ?
          Row(
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
            ],
          ):  Row(
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
            ],
          )
        ],
      ),
      body: FadeIndexedStack(
        index: index,
        children: <Widget>[
          HomeBody(),
          ExplorePage(),
          AddArticlePage(name: name),
          ProfilePage(email: email),
        ],
      ),
      backgroundColor: Colors.white,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

//      body: PageTransitionSwitcher(
//        child: _screens[index],
//        transitionBuilder: (child,primaryAnimation,secondaryAnimation){
//          return FadeThroughTransition(
//            animation: primaryAnimation,
//            secondaryAnimation: secondaryAnimation,
//            child: child,
//          );
//        },
//      ),
