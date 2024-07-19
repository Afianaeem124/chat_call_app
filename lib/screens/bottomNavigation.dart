import 'package:chat_call_app/screens/chat_screen.dart';

import 'package:chat_call_app/screens/home.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ChatScreen(), // Replace with your DialPadScreen widget

    //FavoriteScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 40, 118, 155),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.contact_page_rounded,
                size: 24,
              ),
              label: 'Contacts',
              backgroundColor: Colors.white
              // Use label instead of title
              ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message AI',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'Favorite Contacts',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  void showModal(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: const Text('Example Dialog'),
        actions: <TextButton>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          )
        ],
      ),
    );
  }
}
