import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/article_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/feed_provider.dart';
import 'providers/navigation_provider.dart';
import 'screens/homepage.dart';
import 'screens/sign_up.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FirestoreService _db = FirestoreService();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        StreamProvider(
          create: (_) => _db.getArticles(),
        ),
        ChangeNotifierProvider(
          create: (_) => ArticleProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor:Color(0xff44337b),
          accentColor:Color(0xffebeafd),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isInit = true;
  bool isLoggedIn;



  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if(isInit){
      Provider.of<AuthService>(context).checkAuth();
    }
    print(isLoggedIn);
    isInit = false;
  }


  @override
  Widget build(BuildContext context) {
    isLoggedIn = Provider.of<AuthService>(context).isSignedIn;
    print(isLoggedIn);
    return isLoggedIn ? HomePage() : SignUpPage();
  }
}

