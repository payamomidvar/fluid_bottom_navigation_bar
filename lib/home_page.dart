import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'screens/favourite.dart';
import 'screens/home.dart';
import 'screens/menu.dart';
import 'screens/order.dart';
import 'screens/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Widget page;
  late Color primaryColor;
  late Color iconColor;

  @override
  void initState() {
    page = const Home();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    primaryColor = Theme.of(context).primaryColor;
    iconColor = Theme.of(context).iconTheme.color ?? Colors.white;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: page,
        bottomNavigationBar: FluidNavBar(
          icons: [
            fluidNavBarIconBuilder(Icons.home, "Home"),
            fluidNavBarIconBuilder(Icons.restaurant_menu, "Menu"),
            fluidNavBarIconBuilder(Icons.shopping_cart, "Order"),
            fluidNavBarIconBuilder(Icons.favorite, "Favourite"),
            fluidNavBarIconBuilder(Icons.person, "Profile"),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
            iconSelectedForegroundColor: iconColor,
            iconUnselectedForegroundColor: iconColor,
            barBackgroundColor: primaryColor,
          ),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  FluidNavBarIcon fluidNavBarIconBuilder(
    final IconData icon,
    final String title,
  ) {
    return FluidNavBarIcon(
      icon: icon,
      backgroundColor: primaryColor,
      extras: {"label": title},
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          page = const Home();
          break;
        case 1:
          page = const Menu();
          break;
        case 2:
          page = const Order();
          break;
        case 3:
          page = const Favourite();
          break;
        case 4:
          page = const Profile();
          break;
      }
      page = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: page,
      );
    });
  }
}
