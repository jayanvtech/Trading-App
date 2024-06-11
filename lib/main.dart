import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingapp/Authentication/Login_bloc/login_bloc.dart';
import 'package:tradingapp/Screens/Mainscreens/Dashboard/profile_details_screen.dart';
import 'package:tradingapp/Screens/Mainscreens/profilepage_screen.dart';
import 'package:tradingapp/Utils/changenotifier.dart';
import 'package:tradingapp/Screens/Mainscreens/Dashboard/dashboard_screen.dart';
import 'package:tradingapp/Authentication/login_screen.dart';
import 'package:tradingapp/Utils/Bottom_nav_bar_screen.dart';
import 'package:tradingapp/Screens/Mainscreens/position_screen.dart';
import 'package:tradingapp/Sockets/market_feed_scoket.dart';
import 'package:tradingapp/master/nscm_provider.dart';

import 'GetApiService/apiservices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MarketFeedSocket marketFeedSocket = MarketFeedSocket();
  ChangeNotifierProvider.value(
    value: marketFeedSocket,
    child: MyApp(),
  );
  
  //await ApiService().GetNSCEMMaster();
  // marketFeedSocket.connect();
  // await NscmDataProvider().fetchAndStoreData();

  //MarketFeedSocket marketFeedSocket = MarketFeedSocket();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: marketFeedSocket,
          child: MyApp(),
        ),

        // ChangeNotifierProvider(
        //   create: (context) => NscmDataProvider(),
        // ),
        ChangeNotifierProvider(
          create: (_) => MarketFeedSocket()..connect(),
        ),
        
        BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(),
          
        ),
        ChangeNotifierProvider(
          create: (context) => TradeProvider(),
          child: MyApp(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

Future<bool> isUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token != null;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MarketWatchManager(),
            child: MyApp(),
          ),
          ChangeNotifierProvider(
            create: (context) => NscmDataProvider(),
          ),
          ChangeNotifierProvider(create: (_) => BalanceProvider()),
        ],
        child: ChangeNotifierProvider(
          create: (_) => MarketFeedSocket()..connect(),
          child: FutureBuilder<bool>(
            future: isUserLoggedIn(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if (snapshot.data == true) {
                  return MainScreen();
                } else {
                  return LoginScreen();
                }
              }
            },
          ),
        ),
      ),
    );
  }


  
}
