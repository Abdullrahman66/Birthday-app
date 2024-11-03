import 'package:flutter/material.dart';
import 'home_page.dart';
import 'user_list.dart';
import 'birthday_list.dart';
import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0; // Track the selected tab index
  List<User> favorites = [];
  // List of pages to navigate between
  final List<Widget> _pages = [
    HomePage(),
    UserList(),
    BirthdayList(),
  ];

  // Update selected index on tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Birthdays',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber, // Highlight selected item
        // unselectedItemColor: Colors.grey,
        // backgroundColor: Colors.black,
        // showUnselectedLabels: true,
        // type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped, // Handle tab selection
        // unselectedLabelStyle: TextStyle(
        //   fontSize: 12.0,
        // ),
        // unselectedFontSize: 16.0,
      ),
    );
  }
}
