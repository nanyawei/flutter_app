import 'package:flutter/material.dart';
import 'package:flutter_console/model/account.dart';
import 'package:flutter_console/page/index.dart';
import 'package:flutter_console/router/application.dart';
import 'package:flutter_console/services/index.dart';
import 'package:provider/provider.dart';
import '../provider/index.dart';
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState () => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // homekit页面
  HomeKitPage homeKitPage;
  // mine页面
  MinePage minePage;
  // notFound页面
  NotFoundPage notFoundPage;

  @override
  void initState () {
    super.initState();
  }

  BottomNavigationBarItem bottomItem (String title, IconData iconData) {
    return BottomNavigationBarItem(
      icon: Icon(iconData, color: Color.fromRGBO( 100, 100, 100, 0.8)),
      activeIcon: Icon(iconData, color: Color.fromRGBO( 0, 0, 0, 1)),
      title: Text(title)
    );
  }

  currentPage () {
    int currentIndex = Provider.of<CurrentIndexProvider>(context, listen: false).currentIndex;
    switch(currentIndex) {
      case 0: 
        if (homeKitPage == null) {
          homeKitPage = HomeKitPage();
        }
        return homeKitPage;
      case 1: 
        if (minePage == null) {
          minePage = MinePage();
        }
        return minePage;
      default:
        if (notFoundPage == null) {
          notFoundPage = NotFoundPage();
        }
        return notFoundPage;
    }
  }

  @override
  Widget build (BuildContext context) {
    MyModel my = Provider.of<AccountProvider>(context, listen: false).my;
    int currentIndex = Provider.of<CurrentIndexProvider>(context, listen: false).currentIndex;

    if (my == null) {
      return Scaffold(
        body: Center(
          child: Text('loading...')
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Console'),
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () => Provider.of<CurrentIndexProvider>(context, listen: false).saveCurrentIndex(0),
        )
      ),
      body: Consumer<CurrentIndexProvider>(
        builder: (BuildContext context, CurrentIndexProvider currentIndexProvider, Widget build) => currentPage()
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: ((index) => Provider.of<CurrentIndexProvider>(context, listen: false).saveCurrentIndex(index)),
        items: [
          bottomItem('KomeKit', Icons.wb_incandescent),
          bottomItem('我的', Icons.account_circle),
        ]
      ),
    );
  }
}