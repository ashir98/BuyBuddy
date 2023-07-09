// ignore_for_file: library_private_types_in_public_api

import 'package:buy_buddy/utils/app_colors.dart';
import 'package:buy_buddy/screens/account_screen/account_screen.dart';
import 'package:buy_buddy/screens/cart_screen/cart_screen.dart';
import 'package:buy_buddy/screens/favourites_screen/favourites_screen.dart';
import 'package:buy_buddy/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:enefty_icons/enefty_icons.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({final Key? key}) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {


  final PersistentTabController _controller = PersistentTabController();

  ///screens
  List<Widget> _buildScreens() => [
        const HomeScreen(),
        const CartScreen(),
        const FavouritesScreen(),
        const AccountScreen()
      ];

  ///navbar items code here
  List<PersistentBottomNavBarItem> _navBarsItems() => [

        PersistentBottomNavBarItem(
          icon: const Icon(EneftyIcons.home_3_bold),
          title: "Home",
          activeColorPrimary: AppColor.primaryColor,
          inactiveColorPrimary: AppColor.iconColor,
        ),

        PersistentBottomNavBarItem(
          icon: const Icon(EneftyIcons.shopping_cart_bold),
          title: "Cart",
          activeColorPrimary: AppColor.primaryColor,
          inactiveColorPrimary: AppColor.iconColor,
        ),

        PersistentBottomNavBarItem(
          icon: const Icon(EneftyIcons.heart_bold),
          title: "Favourites",
          activeColorPrimary: AppColor.primaryColor,
          inactiveColorPrimary: AppColor.iconColor,
        ),

        PersistentBottomNavBarItem(
          icon: const Icon(EneftyIcons.profile_bold),
          title: "User",
          activeColorPrimary: AppColor.primaryColor,
          inactiveColorPrimary: AppColor.iconColor,
        ),
      ];


  @override
  Widget build(final BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,

        ///navbar view code here
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          hideNavigationBarWhenKeyboardShows: true,
          confineInSafeArea: false,

          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 55,
          backgroundColor: AppColor.cardBgColor,
          hideNavigationBar: false,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(duration: Duration(milliseconds: 400),curve: Curves.ease),
          screenTransitionAnimation: const ScreenTransitionAnimation(animateTabTransition: true,),
          navBarStyle: NavBarStyle.style9,

          // Choose the nav bar style with this property
        ),
      );
}
