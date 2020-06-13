import 'package:bloggie/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NavBarItems(
              icon: Icons.home,
              title: Text('Home',style: TextStyle(color:Provider.of<NavigationProvider>(context).text1),),
              color: Provider.of<NavigationProvider>(context).color1,
              func: () {Provider.of<NavigationProvider>(context, listen: false).option1();},
            ),
            NavBarItems(
              icon: Icons.explore,
              title: Text('Explore',style: TextStyle(color:Provider.of<NavigationProvider>(context).text2),),
              color: Provider.of<NavigationProvider>(context).color2,
              func: () {Provider.of<NavigationProvider>(context, listen: false).option2();},
            ),
            NavBarItems(
              icon: Icons.add_circle,
              title: Text('Upload',style: TextStyle(color:Provider.of<NavigationProvider>(context).text3),),
              color: Provider.of<NavigationProvider>(context).color3,
              func: () {Provider.of<NavigationProvider>(context, listen: false).option3();},
            ),
            NavBarItems(
              icon: Icons.person,
              title: Text('Profile',style: TextStyle(color:Provider.of<NavigationProvider>(context).text4),),
              color: Provider.of<NavigationProvider>(context).color4,
              func: () {Provider.of<NavigationProvider>(context, listen: false).option4();},
            ),
          ],
        ),
      ),
    );
  }
}


class NavBarItems extends StatefulWidget {
  NavBarItemsState createState() => NavBarItemsState();
  final IconData icon;
  final Text title;
  final Color color;
  final Function func;
  const NavBarItems({Key key, this.icon, this.title, this.color, this.func})
      : super(key: key);
}

class NavBarItemsState extends State<NavBarItems> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)),
      child: Column(
        children: <Widget>[
          Icon(widget.icon,color: Theme.of(context).primaryColor,),
          widget.title,
        ],
      ),
      onPressed: () {
        widget.func();
      },
    );
  }
}


