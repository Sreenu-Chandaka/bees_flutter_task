import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../screens/receipts_screen.dart';
import '../screens/transport_management_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final _controller = NotchBottomBarController(index: 0);

  final List<Widget> _screens = [
    const TransportManagementScreen(),
    ReceiptsScreen(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _controller.index,
        children: _screens,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        kIconSize: 30,
        removeMargins: true,
        color: Colors.white,
        showLabel: true,
        notchColor: Colors.blue,
        notchBottomBarController: _controller,
        kBottomRadius: 20,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.local_shipping, color: Colors.black54),
            activeItem:
                Icon(Icons.local_shipping, color: Colors.white, size: 30),
            itemLabel: 'Transport Management',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.list_alt, color: Colors.black54),
            activeItem: Icon(Icons.list_alt, color: Colors.white, size: 30),
            itemLabel: 'Receipts',
          ),
        ],
        onTap: (index) {
          _controller.index = index;
          setState(() {});
        },
      ),
    );
  }
}
