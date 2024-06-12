// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tradingapp/DashBoard/Screens/option_chain_screen/option_chain_screen.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/DashBoard/Screens/DashBoardScreen/dashboard_screen.dart';
import 'package:tradingapp/DashBoard/Screens/BuyOrSellScreen/buy_sell_screen.dart';
import 'package:tradingapp/MarketWatch/Screens/InstrumentDetailScreen/instrument_details_screen.dart';
import 'package:tradingapp/MarketWatch/Screens/SearchScreen/search_screen.dart';
import 'package:tradingapp/Authentication/auth_services.dart';
import 'package:tradingapp/MarketWatch/Screens/WishListInstrumentDetailScreen/wishlist_instrument_details_screen.dart';
import 'package:tradingapp/Sockets/market_feed_scoket.dart';
import 'package:tradingapp/sqlite_database/dbhelper.dart';
import 'package:tradingapp/master/nscm_database.dart';
import 'package:tradingapp/master/nscm_provider.dart';

class MarketWatchScreen extends StatefulWidget {
  @override
  _MarketWatchScreenState createState() => _MarketWatchScreenState();
}

class _MarketWatchScreenState extends State<MarketWatchScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  List<Map<String, dynamic>> _watchlistItems = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _watchlistItems.length, vsync: this);
    WidgetsBinding.instance.addObserver(this);
    initializeDatabase();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      initializeDatabase();
    }
  }

  Future<void> initializeDatabase() async {
    _watchlistItems = await DatabaseHelper.instance.fetchWatchlists();
    setState(() {
      _tabController =
          TabController(length: _watchlistItems.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MarketFeedSocket>(builder: (context, feed, child) {
      return feed.bankmarketData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(
                            onReturn: () => initializeDatabase(),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
                title: Text('Watchlist'),
                bottom: _tabController != null
                    ? PreferredSize(
                        preferredSize: Size.fromHeight(170),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: GestureDetector(
                                    onLongPress: () async {},
                                    child: TabBar(
                                      tabAlignment: TabAlignment.start,
                                      dividerColor: Colors.white,
                                      controller: _tabController,
                                      isScrollable: true,
                                      tabs: _watchlistItems.map((item) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.delete),
                                                      title: Text('Delete'),
                                                      onTap: () {
                                                        _dbHelper
                                                            .deleteWatchlist(_watchlistItems[
                                                                    _tabController
                                                                        .index]
                                                                ['id'] as int)
                                                            .then((value) =>
                                                                initializeDatabase())
                                                            .catchError(
                                                                (error) =>
                                                                    print(
                                                                        error));
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading:
                                                          Icon(Icons.delete),
                                                      title: Text('Delete'),
                                                      onTap: () {
                                                        // Handle delete
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child:
                                              Tab(text: item['name'] as String),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  child: IconButton(
                                    onPressed: () async {
                                      String? itemName = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddWatchlistDialog();
                                        },
                                      );
                                      initializeDatabase();

                                      if (itemName != null) {
                                        await DatabaseHelper.instance
                                            .addWatchlist(itemName);
                                        initializeDatabase();
                                        setState(() {
                                          // _tabController =
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                            MarketDataWidget(feed.bankmarketData),
                          ],
                        ),
                      )
                    : PreferredSize(
                        preferredSize: Size.fromHeight(0),
                        child: Container(),
                      ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: _watchlistItems
                    .map(
                      (item) => WatchlistTab(
                        watchlistId: item['id'] as int,
                      ),
                    )
                    .toList(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                        onReturn: () => initializeDatabase(),
                      ),
                    ),
                  );
                  // String? itemName = await showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return AddWatchlistDialog();
                  //   },
                  // );
                  // initializeDatabase();

                  // if (itemName != null) {
                  //   await DatabaseHelper.instance.addWatchlist(itemName);
                  //   initializeDatabase();
                  // }
                },
                child: Icon(Icons.add),
              ),
            );
    });
  }
}

class WatchlistTab extends StatefulWidget {
  final int watchlistId;

  const WatchlistTab({required this.watchlistId});

  @override
  _WatchlistTabState createState() => _WatchlistTabState();
}

class _WatchlistTabState extends State<WatchlistTab>
    with WidgetsBindingObserver {
  List<Map<String, dynamic>> _instruments = [];
  String close = "";
  late Timer _timer;
  bool _isReordering = false;
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
// void dispose() {
//     String exchangeSegments = _instruments.map((e) => e['exchangeSegment'].toString()).join(',');
//   String exchangeInstrumentIds = _instruments.map((e) => e['exchange_instrument_id'].toString()).join(',');
//     // Call your function here
//   ApiService().UnsubscribeMarketInstrument(exchangeSegments.toString(), exchangeInstrumentIds.toString());

//     super.dispose();
//   }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    fetchInstruments();
    SubscribedmarketData();

    DatabaseHelper.instance.updateAllCloseValues();
    _timer =
        Timer.periodic(Duration(seconds: 4), (timer) => fetchInstruments());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      fetchInstruments();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(WatchlistTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    fetchInstruments();
  }

  Future<void> SubscribedmarketData() async {
    //final marketSocket = Provider.of<MarketFeedSocket>(context);
    final instruments = await DatabaseHelper.instance
        .fetchInstrumentsByWatchlist(widget.watchlistId);
    _instruments = List<Map<String, dynamic>>.from(instruments);
    for (var instrument in _instruments) {
      final exchangeInstrumentID =
          instrument['exchange_instrument_id'] as String;
      final exchangeSegment = instrument['exchangeSegment'].toString();

      ApiService().MarketInstrumentSubscribe(exchangeSegment.toString(), exchangeInstrumentID.toString());
    }
  }

  Future<void> fetchInstruments() async {
    final instruments = await DatabaseHelper.instance
        .fetchInstrumentsByWatchlist(widget.watchlistId);
    if (_instruments.length != instruments.length) {
      SubscribedmarketData();
    }

    if (mounted) {
      // Check if the widget is still in the tree
      setState(() {
        _instruments = List<Map<String, dynamic>>.from(instruments);
      });
    }
  }

  Stream<String> streamInstrumentDetails(
      String exchangeInstrumentID, String ExchangeSegment) async* {
    while (true) {
      final instrumentDetails =
          await fetchInstrumentDetails(exchangeInstrumentID, ExchangeSegment);
      yield jsonEncode(instrumentDetails);
    }
  }

  Future<List<String>> fetchAllCloseValues(
      List<Map<String, dynamic>> instruments) async {
    var closeValues = <String>[];
    for (var instrument in instruments) {
      var token = instrument['exchange_instrument_id'];
      var closeValue = await NscmDatabase().getCloseValue(token);
      closeValues.add(closeValue);
    }
    return closeValues;
  }

  String getExchangeSegmentName(int exchangeSegment) {
    switch (exchangeSegment) {
      case 1:
        return 'NSECM';
      case 2:
        return 'NSEFO';
      case 3:
        return 'NSECD';
      case 11:
        return 'BSECM';
      case 12:
        return 'BSEFO';
      case 13:
        return 'BSECD';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    final marketSocket = Provider.of<MarketFeedSocket>(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return ReorderableListView.builder(
                itemCount: _instruments.length,
                itemBuilder: (context, index) {
                  final instrument = _instruments[index];
                  return ListTile(
                    key: ValueKey(instrument['id']),
                    title: Text(instrument['display_name']),
                    leading: Icon(Icons.drag_handle),
                  );
                },
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }
                    final Map<String, dynamic> item =
                        _instruments.removeAt(oldIndex);
                    _instruments.insert(newIndex, item);
                    _dbHelper.updateOrderIndex(item['id'], newIndex);
                  });
                },
              );
            },
          );
        },
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemCount: _instruments.length,
          itemBuilder: (context, index) {
            final instrument = _instruments[index];
            final exchangeInstrumentID =
                instrument['exchange_instrument_id'] as String;

            final exchangeSegment = instrument['exchangeSegment'].toString();
            final displayName = instrument['display_name'] as String;

            final closevalue1 = instrument['close'].toString();
            return Consumer<MarketFeedSocket>(
              builder: (context, data, child) {
                final marketData =
                    data.getDataById(int.parse(exchangeInstrumentID));
                final priceChange = marketData != null
                    ? double.parse(marketData.price) - double.parse(closevalue1)
                    : 0;
                final priceChangeColor =
                    priceChange > 0 ? Colors.green : Colors.red;
                if (marketData != null) {
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => InstrumentDetailsScreen(

                      //     ),
                      //   ),
                      // );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => BuySellScreen(
                      //       exchangeInstrumentId: exchangeInstrumentID,exchangeSegment: exchangeSegment,lastTradedPrice: marketData.price, close: closevalue1,displayName: displayName,
                      //     ),
                      //   ),
                      // );
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return Consumer<MarketFeedSocket>(
                                builder: (context, data, child) {
                                  final marketData = data.getDataById(
                                      int.parse(exchangeInstrumentID));
                                  final priceChange = marketData != null
                                      ? double.parse(marketData.price) -
                                          double.parse(closevalue1)
                                      : 0;
                                  final priceChangeColor = priceChange > 0
                                      ? Colors.green
                                      : Colors.red;

                                  if (marketData != null) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(displayName,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 18)),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      getExchangeSegmentName(
                                                          int.parse(
                                                              exchangeSegment)),
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "₹${marketData.price.toString()}",
                                                          style: TextStyle(
                                                              color:
                                                                  priceChangeColor,
                                                              fontSize: 18),
                                                        ),
                                                        Icon(
                                                          priceChange > 0
                                                              ? Icons
                                                                  .arrow_drop_up
                                                              : Icons
                                                                  .arrow_drop_down,
                                                          color:
                                                              priceChangeColor,
                                                          size: 30,
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          priceChange
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                        Text(
                                                          "(${marketData.percentChange.toString()}%)",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "OPEN",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          Text(marketData.Open),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "HIGH",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          Text(marketData.High),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "LOW",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          Text(marketData.Low),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "PREV. CLOSE",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black54),
                                                          ),
                                                          Text(marketData.close
                                                              .toString()),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                                Container(
                                                  width: double.infinity,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text('QTY',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .black87,
                                                                      )),
                                                                  Text(
                                                                      'BUY PRICE',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.normal)),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Expanded(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                      'BUY PRICE',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .black87,
                                                                      )),
                                                                  Text('QTY',
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .black87,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        thickness: 0.5,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            height: 200,
                                                            width: 180,
                                                            child: ListView
                                                                .builder(
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  marketData
                                                                      .bids
                                                                      .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var bid =
                                                                    marketData
                                                                            .bids[
                                                                        index];
                                                                return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                          '${bid.size}'),
                                                                      Text(
                                                                        '${bid.price}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.green),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: 200,
                                                              // width: 180,
                                                              child: ListView
                                                                  .builder(
                                                                shrinkWrap:
                                                                    true,
                                                                itemCount:
                                                                    marketData
                                                                        .asks
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  var asks =
                                                                      marketData
                                                                              .asks[
                                                                          index];
                                                                  return Container(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            10),
                                                                    child: Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                              '${asks.price}',
                                                                              style: TextStyle(color: Colors.red)),
                                                                          Text(
                                                                              '${asks.size}'),
                                                                        ]),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        thickness: 0.5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(marketData
                                                                .totalBuyQuantity),
                                                            Text(
                                                                "TOTAL QUANTITY"),
                                                            Text(marketData
                                                                .totalSellQuantity)
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton(onPressed: () {
                                                  Get.to(OptionChainScreen());
                                                }, child: Text("Option Chain")),
                                                VerticalDivider(),
                                                Text("Charts"),
                                                VerticalDivider(),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ViewMoreInstrumentDetailScreen(
                                                            exchangeInstrumentId:
                                                                exchangeInstrumentID,
                                                            exchangeSegment:
                                                                exchangeSegment,
                                                            lastTradedPrice:
                                                                marketData
                                                                    .price,
                                                            close: closevalue1,
                                                            displayName:
                                                                displayName,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child:
                                                        Text("Stock Details"))
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 60,
                                            width: double.infinity,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              BuySellScreen(
                                                            exchangeInstrumentId:
                                                                exchangeInstrumentID,
                                                            exchangeSegment:
                                                                exchangeSegment,
                                                            lastTradedPrice:
                                                                marketData
                                                                    .price,
                                                            close: closevalue1,
                                                            displayName:
                                                                displayName,
                                                            isBuy: true,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.green,
                                                      ),
                                                      child: Center(
                                                          child: Text("BUY",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18))),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              BuySellScreen(
                                                            exchangeInstrumentId:
                                                                exchangeInstrumentID,
                                                            exchangeSegment:
                                                                exchangeSegment,
                                                            lastTradedPrice:
                                                                marketData
                                                                    .price,
                                                            close: closevalue1,
                                                            displayName:
                                                                displayName,
                                                            isBuy: false,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.red,
                                                      ),
                                                      child: Center(
                                                          child: Text("SELL",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18))),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return ReorderableListView.builder(
                            itemCount: _instruments.length,
                            itemBuilder: (context, index) {
                              final instrument = _instruments[index];
                              return ListTile(
                                key: ValueKey(instrument['id']),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(instrument['display_name']),
                                    IconButton(
                                        onPressed: () {
                                          _dbHelper
                                              .deleteInstrumentByExchangeInstrumentId(
                                                  widget.watchlistId,
                                                  exchangeInstrumentID);
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                ),
                                leading: Icon(Icons.drag_handle),
                              );
                            },
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final Map<String, dynamic> item =
                                    _instruments.removeAt(oldIndex);
                                _instruments.insert(newIndex, item);
                                _dbHelper.updateOrderIndex(
                                    item['id'], newIndex);

                                //MarketWatchScreen.initializeDatabase();
                              });
                            },
                          );
                        },
                      );
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(displayName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400)),
                                Row(
                                  children: [
                                    Text(
                                      marketData.price.toString(),
                                      style: TextStyle(color: priceChangeColor),
                                    ),
                                    // Icon(
                                    //   priceChangeIcon,
                                    //   color: priceChangeColor,
                                    //   size: 12,
                                    // ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '$displayName:  - ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      getExchangeSegmentName(
                                          int.parse(exchangeSegment)),
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(priceChange.toStringAsFixed(2),
                                        style:
                                            TextStyle(color: priceChangeColor)),
                                    Text(
                                      "(${marketData.percentChange}%)",
                                      style: TextStyle(color: priceChangeColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
      ),
    );
  }
}

Future<Map<String, String>> fetchInstrumentDetails(
    String exchangeInstrumentID, String exchangeSegment) async {
  try {
    String? token = await getToken();
    final url = 'http://14.97.72.10:3000/apimarketdata/instruments/quotes';
    final payload = jsonEncode({
      "instruments": [
        {
          "exchangeSegment": exchangeSegment,
          "exchangeInstrumentID": exchangeInstrumentID
        }
      ],
      "xtsMessageCode": 1501,
      "publishFormat": "JSON"
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '$token',
      },
      body: payload,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data != null && data.containsKey('result')) {
        final listQuotesJson = data['result']['listQuotes'][0];
        final listQuotes = jsonDecode(listQuotesJson);
        final lastTradedPrice = listQuotes['Touchline']['LastTradedPrice'];

        final openPrice = listQuotes['Touchline']['Open'];
        final highPrice = listQuotes['Touchline']['High'];
        final lowPrice = listQuotes['Touchline']['Low'];
        final closePrice = listQuotes['Touchline']['Close'];
        final percentChange = listQuotes['Touchline']['PercentChange'];
        return {
          'LastTradedPrice': lastTradedPrice.toString(),
          'Open': openPrice.toString(),
          'High': highPrice.toString(),
          'Low': lowPrice.toString(),
          'Close': closePrice.toString(),
          'PercentChange': percentChange.toString(),
        };
      } else {
        print('Invalid data received from the server');
        throw Exception('Invalid data received from the server');
      }
    } else {
      print('Failed to fetch instrument details');
      throw Exception('Failed to fetch instrument details');
    }
  } on SocketException {
    print('No Internet connection');
    throw 'No Internet connection';
  } on HttpException {
    print('Could not find the service');
    throw 'Could not find the service';
  } on FormatException {
    print('Bad response format');
    throw 'Bad response format';
  } catch (e) {
    print("Exception caught: $e");
    rethrow;
  }
}

class AddWatchlistDialog extends StatefulWidget {
  @override
  _AddWatchlistDialogState createState() => _AddWatchlistDialogState();
}

class _AddWatchlistDialogState extends State<AddWatchlistDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Watchlist'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: 'Name'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_controller.text.trim());
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
