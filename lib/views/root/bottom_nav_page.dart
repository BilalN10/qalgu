// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qalgu/constants/colors.dart';
import 'package:qalgu/constants/icons.dart';
import 'package:qalgu/views/root/tabs/sleep/sleep_page.dart';

class BottomNavbar extends StatefulWidget {
  final BuildContext menuScreenContext;
  const BottomNavbar({Key? key, required this.menuScreenContext})
      : super(key: key);

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<BottomNavbar> {
  PersistentTabController? _controller;
  bool? _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      const SleepPage(),
      Container(),
      Container(),
      Container(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(IconsClass.sleep),
        title: "Sleep",
        activeColorPrimary: ColorsClass.primaryColor,
        inactiveColorPrimary: const Color(0xff848A92),
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(IconsClass.stats),
        title: ("Stats"),
        activeColorPrimary: ColorsClass.primaryColor,
        inactiveColorPrimary: const Color(0xff848A92),
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            // initialRoute: '/',
            // routes: {
            //   '/first': (context) => LoginPage(),
            //   '/second': (context) => RegisterScreen(),
            // },
            ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(IconsClass.inbox),
        title: ("Inbox"),
        activeColorPrimary: ColorsClass.primaryColor,
        inactiveColorPrimary: const Color(0xff848A92),
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
          initialRoute: '/',
          // routes: {
          //   '/first': (context) => LoginPage(),
          //   '/second': (context) => RegisterScreen(),
          // },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(IconsClass.settings),
        title: ("Settings"),
        activeColorPrimary: ColorsClass.primaryColor,
        inactiveColorPrimary: const Color(0xff848A92),
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            // initialRoute: '/',
            // routes: {
            //   '/first': (context) => LoginPage(),
            //   '/second': (context) => RegisterScreen(),
            // },
            ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: Get.height * 0.07,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        selectedTabScreenContext: (context) {},
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            colorBehindNavBar: ColorsClass.primaryColor,
            borderRadius: BorderRadius.circular(0.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style3,
      ),
    );
  }
}
