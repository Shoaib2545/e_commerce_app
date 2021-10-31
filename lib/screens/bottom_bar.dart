import 'package:e_commerce_app/consts/my_icons.dart';
import 'package:e_commerce_app/screens/search.dart';
import 'package:e_commerce_app/screens/user_info.dart';
import 'package:flutter/material.dart';

import 'cart/cart.dart';
import 'feeds.dart';
import 'home.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';

  const BottomBarScreen({Key? key}) : super(key: key);
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List<Map<String, Object>> _pages;
  int _selectedPageIndex = 1;
  late List<Widget> pages;
  @override
  void initState() {
    pages = [
      const Home(),
      const Feeds(),
      const Search(),
      const CartScreen(),
      UserInfo(),
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPageIndex], //_pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        // color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.01,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight * 0.98,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              onTap: _selectPage,
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).textSelectionColor,
              selectedItemColor: Colors.purple,
              currentIndex: _selectedPageIndex,
              // selectedLabelStyle: TextStyle(fontSize: 16),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(MyAppIcons.home),
                  // title: Text('Home'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.rss), label: 'Feeds'),
                const BottomNavigationBarItem(
                    activeIcon: null, icon: Icon(null), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(
                      MyAppIcons.bag,
                    ),
                    label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(MyAppIcons.user), label: 'User'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          hoverElevation: 10,
          splashColor: Colors.grey,
          tooltip: 'Search',
          elevation: 4,
          child: Icon(MyAppIcons.search),
          onPressed: () => setState(() {
            _selectedPageIndex = 2;
          }),
        ),
      ),
    );
  }
}
