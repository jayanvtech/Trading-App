import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';

import 'package:tradingapp/DashBoard/Screens/DashBoardScreen/dashboard_screen.dart';
// Assuming this is for the Market tab
import 'package:tradingapp/MarketWatch/Screens/MarketWatchScreen/market_watch_screen.dart';
import 'package:tradingapp/Portfolio/Screens/PortfolioScreen/portfolio_screen.dart';
import 'package:tradingapp/Position/Screens/PositionScreen/position_screen.dart';
import 'package:tradingapp/Profile/Screens/ProfileScreen/profilepage_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
 

  @override
  void initState() {
    super.initState();
    init();
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void init() async {
    await ApiService().MarketInstrumentSubscribe(1.toString(), 26000.toString());
    await ApiService().MarketInstrumentSubscribe(1.toString(), 26001.toString());
    await ApiService().MarketInstrumentSubscribe(1.toString(), 26002.toString());
    await ApiService().MarketInstrumentSubscribe(1.toString(), 26003.toString());
    await ApiService().MarketInstrumentSubscribe(1.toString(), 26004.toString());
    await ApiService().MarketInstrumentSubscribe(1.toString(), 26005.toString());
  }

  List<Widget> _buildScreens() {
    return [
      DashboardScreen(),
      PortfolioScreen(),
      MarketWatchScreen(),
      PositionScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentTabConfig> _tabs() {
    return [
      PersistentTabConfig(
        screen: DashboardScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.dashboard_rounded),
          title: "Dashboard",
        ),
      ),
      PersistentTabConfig(
        screen: PortfolioScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.attach_money),
          title: "Portfolio",
        ),
      ),
      PersistentTabConfig(
        screen: MarketWatchScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.watch),
          title: "Market Watch",
        ),
      ),
      PersistentTabConfig(
        screen: PositionScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.podcasts),
          title: "Position",
        ),
      ),
      PersistentTabConfig(
        screen: ProfileScreen(),
        item: ItemConfig(
          icon: const Icon(Icons.person),
          title: "Profile",
        ),
      ),
    ];
  }

  Widget build(BuildContext context) => PersistentTabView(
        tabs: _tabs(),
        navBarBuilder: (navBarConfig) => Style6BottomNavBar(
          navBarConfig: navBarConfig,
        ),
      );
  }


