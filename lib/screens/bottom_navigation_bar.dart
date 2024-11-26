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
  // Controller for the bottom bar
  final _controller = NotchBottomBarController(index: 0);

  // List of screens to navigate between
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
      body: IndexedStack(
        index: _controller.index,
        children: _screens,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        kIconSize: 30,
        removeMargins: true,
        bottomBarWidth: MediaQuery.of(context).size.width * 0.5, // Use 90% of screen width
        color: Colors.white,
        showLabel: true,
        notchColor: Colors.blue,
        notchBottomBarController: _controller,
        kBottomRadius: 20,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.transfer_within_a_station, color: Colors.black54),
            activeItem: Icon(Icons.transfer_within_a_station, color: Colors.white, size: 30),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.receipt_long_outlined, color: Colors.black54),
            activeItem: Icon(Icons.receipt_long_outlined, color: Colors.white, size: 30),
            itemLabel: 'Settings',
          ),
        ],
        onTap: (index) {
          // Update the screen when bottom bar item is tapped
          _controller.index = index;
          setState(() {});
        },
      ),
    );
  }
}