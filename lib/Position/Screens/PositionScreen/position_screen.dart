import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/DashBoard/Screens/DashBoardScreen/dashboard_screen.dart';
import 'package:tradingapp/Portfolio/Screens/PortfolioScreen/portfolio_screen.dart';

import 'package:tradingapp/Sockets/market_feed_scoket.dart';
import 'package:tradingapp/Position/Models/TradeOrderModel/tradeOrder_model.dart';
import 'package:tradingapp/Utils/exchangeConverter.dart';

class PositionScreen extends StatefulWidget {
  const PositionScreen({super.key});

  @override
  State<PositionScreen> createState() => _PositionScreenState();
}

class _PositionScreenState extends State<PositionScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokend = prefs.getString('token');
    print('Tokens: $tokend');
    return tokend!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Position'),
        bottom: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          automaticIndicatorColorAdjustment: true,
          controller: _tabController,
          tabs: const [
            Tab(text: 'Position'),
            Tab(text: 'Trade Book'),
            Tab(text: 'Order'),
            Tab(text: 'Order History')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.grey[200]),
            child: Column(
              children: [
                //#################################################### below code is for Order content##################################

                // Replace with your Order content

                //#################################################### below code is for Position content##################################
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      height: 1,
                      backgroundColor: Colors.white,
                    ),
                    decoration: InputDecoration(
                        labelText: "Search",
                        hintText: "Enter search term",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onChanged: (value) {
                      // Perform the search operation
                      print("Search term: $value");
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Open Positions ^"),
                    TextButton(onPressed: () {}, child: Text("Exit")),
                  ],
                ),

                Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: PositionProviderScreen())
              ],
            ),
          ),
          // Replace with your Position content

          //#################################################### below code is for Position content##################################

          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    style: TextStyle(
                      color: Colors.black,
                      height: 1,
                      backgroundColor: Colors.white,
                    ),
                    decoration: InputDecoration(
                        labelText: "Search order",
                        hintText: "Enter order term",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onChanged: (value) {
                      // Perform the search operation
                      print("Search order term: $value");
                    },
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: TradeProviderScreen())
              ],
            ),
          ),

          SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: OrderProviderScreen()),
          OrderHistoryProviderScreen(),
        ],
      ),
    );
  }
}

class OrderProvider with ChangeNotifier {
  List<OrderValues>? _ordervalues;

  String searchTerm = '';

  List<OrderValues>? get ordervalues => _ordervalues;

  Future<void> GetOrder() async {
    final apiService = ApiService();
    final response = await apiService.GetOrder(); // Call your API function here
    _ordervalues = OrderValues.fromJsonList(response);
    print(response);
    notifyListeners();
  }

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }
}

class PositionProvider with ChangeNotifier {
  List<Positions>? _positions;

  String searchTerm = '';

  List<Positions>? get positions => _positions;

  List<Positions>? sortPositionsByAlphabet(bool ascending, List<Positions>? value) {
    if (value != null) {
      print("Sorting positions by alphabet, ascending: $ascending");
      value.sort((a, b) {
        if (ascending) {
          return a.tradingSymbol.compareTo(b.tradingSymbol);
        } else {
          return b.tradingSymbol.compareTo(a.tradingSymbol);
        }
      });
      print("Positions after sorting: ${value.map((e) => e.tradingSymbol).toList()}");
      _positions = value;
      notifyListeners();
    }
    return _positions;
  }

  // void sortByProfitAscending() {
  //   _positions?.sort((a, b) {
  //     double aProfit = (a.quantity ?? 0.0) * (double.parse(a.actualBuyAveragePrice.toString()));
  //     double bProfit = (b.quantity ?? 0.0) * (double.parse(b.actualBuyAveragePrice.toString()));
  //     return aProfit.compareTo(bProfit);
  //   });
  //   notifyListeners();
  // }

  Future<void> getPosition() async {
    final apiService = ApiService();
    final response = await apiService.GetPosition();
    _positions = Positions.fromJsonList(response);
    notifyListeners();
  }

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }

  List<Object> get filteredPositions {
    if (positions == null) {
      return [];
    } else {
      return positions!
          .where((position) => position.tradingSymbol.contains(searchTerm))
          .toList();
    }
  }
}

class TradeProvider with ChangeNotifier {
  List<TradeOrder>? _positions;

  String searchTerm = '';

  List<TradeOrder>? get positions => _positions;

  Future<void> getTrades() async {
    final apiService = ApiService();
    final response =
        await apiService.GetTrades(); // Call your API function here
    _positions = TradeOrder.fromJsonList(response);
    notifyListeners();
  }

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }

  List<Object> get filteredPositions {
    if (positions == null) {
      return [];
    } else {
      return positions!
          .where((position) => position.tradingSymbol.contains(searchTerm))
          .toList();
    }
  }
}

class PositionProviderScreen extends StatefulWidget {
  @override
  _PositionProviderScreenState createState() => _PositionProviderScreenState();
}

class _PositionProviderScreenState extends State<PositionProviderScreen> {
  String search = '';
  @override
  List<TradeOrder> filteredPositions = [];

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PositionProvider()..getPosition(),
      child: Consumer<PositionProvider>(
        builder: (context, positionProvider, child) {
          if (positionProvider.positions == null) {
            return Center(child: CircularProgressIndicator());
          } else if (positionProvider.positions!.isEmpty) {
            return Center(
                child: Text(
              "You have no positions. Place an order to open a new position",
              textAlign: TextAlign.center,
            ));
          } else {
            if (positionProvider.positions != null &&
                positionProvider.positions!.isNotEmpty) {
              for (var position in positionProvider.positions!) {
                var exchangeSegment = position.exchangeSegment;
                var exchangeInstrumentID = position.exchangeInstrumentId;

                ApiService().MarketInstrumentSubscribe(
                    ExchangeConverter().getExchangeSegmentNumber(exchangeSegment).toString(),
                    exchangeInstrumentID.toString());
              }
            }
            return Consumer<MarketFeedSocket>(
                builder: (context, marketFeedSocket, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: positionProvider.positions!.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0), // Add this line
                itemBuilder: (context, index) {
                  var position = positionProvider.positions![index];

                  var quentity = position.quantity;
                  var orderAvglastTradedPrice = position.actualBuyAveragePrice;
                  var exchangeSegment = position.exchangeSegment;
                  var exchangeInstrumentID = position.exchangeInstrumentId;
                  final marketData = marketFeedSocket
                      .getDataById(int.parse(exchangeInstrumentID.toString()));
                  var lastTradedPrice =
                      marketData?.price.toString() ?? 'Loading...';
                  double? TotalBenifits;
                  if (lastTradedPrice != 'Loading...') {
                    TotalBenifits = (double.parse(lastTradedPrice) -
                            double.parse(
                                position.buyAveragePrice.toString() ?? '0')) *
                        (quentity ?? 0.0);
                  }
                  // print(positionProvider.positions![index].exchangeInstrumentID);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.05,
                              offset: Offset(0, 1))
                        ],
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    positionProvider
                                        .positions![index].tradingSymbol,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  TotalBenifits != null
                                      ? TotalBenifits.toStringAsFixed(2)
                                      : 'Loading...',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // Text(
                                      //   positionProvider
                                      //       .positions![index].orderSide,
                                      //   style: TextStyle(
                                      //     color: positionProvider
                                      //                 .positions![index]
                                      //                 .orderSide
                                      //                 .toString() ==
                                      //             'BUY'
                                      //         ? Colors.green
                                      //         : Colors.red,
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("DEL"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        marketData != null
                                            ? marketData.price.toString()
                                            : 'Loading...',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          '(${marketData != null ? marketData.percentChange.toString() : 'Loading...'}%)'),
                                    ],
                                  )
                                ]),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Qty: ${positionProvider.positions![index].quantity.toString()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(positionProvider
                                        .positions![index].exchangeSegment
                                        .toString())
                                  ],
                                ),
                                Text(
                                  "Avg: ${positionProvider.positions![index].buyAveragePrice.toString()}",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}

class TradeProviderScreen extends StatefulWidget {
  @override
  _TradeProviderScreenState createState() => _TradeProviderScreenState();
}

class _TradeProviderScreenState extends State<TradeProviderScreen> {
  String search = '';
  @override
  List<TradeOrder> filteredPositions = [];

  int getExchangeSegmentNumber(String exchangeSegment) {
    switch (exchangeSegment) {
      case 'NSECM':
        return 1;
      case 'NSEFO':
        return 2;
      case 'NSECD':
        return 3;
      case 'BSECM':
        return 11;
      case 'BSEFO':
        return 12;
      case 'BSECD':
        return 13;
      default:
        return 0; // Return 0 or any other number for 'Unknown'
    }
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TradeProvider()..getTrades(),
      child: Consumer<TradeProvider>(
        builder: (context, positionProvider, child) {
          if (positionProvider.positions == null) {
            return Center(child: CircularProgressIndicator());
          } else if (positionProvider.positions!.isEmpty) {
            return Center(
                child: Text(
              "You have no positions. Place an order to open a new position",
              textAlign: TextAlign.center,
            ));
          } else {
            if (positionProvider.positions != null &&
                positionProvider.positions!.isNotEmpty) {
              for (var position in positionProvider.positions!) {
                print("=========================${positionProvider.positions!.length}");
                var exchangeSegment = position.exchangeSegment;
                var exchangeInstrumentID = position.exchangeInstrumentID;

                ApiService().MarketInstrumentSubscribe(
                    getExchangeSegmentNumber(exchangeSegment).toString(),
                    exchangeInstrumentID.toString());
              }
            }
            return Consumer<MarketFeedSocket>(
                builder: (context, marketFeedSocket, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: positionProvider.positions!.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0), // Add this line
                itemBuilder: (context, index) {
                  var position = positionProvider.positions![index];
                  var quentity = position.lastTradedQuantity;
                  var orderAvglastTradedPrice =
                      position.orderAverageTradedPrice;
                  var exchangeSegment = position.exchangeSegment;
                  var exchangeInstrumentID = position.exchangeInstrumentID;
                  final marketData = marketFeedSocket
                      .getDataById(int.parse(exchangeInstrumentID.toString()));
                  var lastTradedPrice =
                      marketData?.price.toString() ?? 'Loading...';
                  double? TotalBenifits;
                  if (lastTradedPrice != 'Loading...') {
                    TotalBenifits = (double.parse(lastTradedPrice) -
                            double.parse(orderAvglastTradedPrice ?? '0')) *
                        (quentity ?? 0.0);
                  }
                  // print(positionProvider.positions![index].exchangeInstrumentID);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.05,
                              offset: Offset(0, 1))
                        ],
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    positionProvider
                                        .positions![index].tradingSymbol,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  TotalBenifits != null
                                      ? TotalBenifits.toStringAsFixed(2)
                                      : 'Loading...',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        positionProvider
                                            .positions![index].orderSide,
                                        style: TextStyle(
                                          color: positionProvider
                                                      .positions![index]
                                                      .orderSide
                                                      .toString() ==
                                                  'BUY'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("DEL"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        marketData != null
                                            ? marketData.price.toString()
                                            : 'Loading...',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          '(${marketData != null ? marketData.percentChange.toString() : 'Loading...'}%)'),
                                    ],
                                  )
                                ]),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Qty: ${positionProvider.positions![index].lastTradedQuantity.toString()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(positionProvider
                                        .positions![index].exchangeSegment
                                        .toString())
                                  ],
                                ),
                                Text(
                                  "Avg: ${positionProvider.positions![index].orderAverageTradedPrice.toString()}",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}

class OrderProviderScreen extends StatefulWidget {
  @override
  _OrderProviderScreenState createState() => _OrderProviderScreenState();
}

class _OrderProviderScreenState extends State<OrderProviderScreen> {
  String search = '';
  List<OrderProvider> filteredPositions = [];

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderProvider()..GetOrder(),
      child: Consumer<OrderProvider>(
        builder: (context, OrderProvider, child) {
          if (OrderProvider.ordervalues == null) {
            return Center(child: CircularProgressIndicator());
          } else if (OrderProvider.ordervalues!.isEmpty) {
            return Center(
                child: Text(
                    style: TextStyle(),
                    "No Orders found. Place an order to view here."));
          } else {
            return Consumer<MarketFeedSocket>(
                builder: (context, marketFeedSocket, child) {
              var reversedOrderValues =
                  OrderProvider.ordervalues!.reversed.toList();
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: reversedOrderValues.length,
                padding: const EdgeInsets.symmetric(vertical: 8.0)
                    .copyWith(bottom: 100.0),
                itemBuilder: (context, index) {
                  var ordervalues = reversedOrderValues[index];

                  var orderAvglastTradedPrice =
                      ordervalues.orderAverageTradedPrice;

                  var exchangeInstrumentID = ordervalues.exchangeInstrumentID;
                  final marketData = marketFeedSocket
                      .getDataById(int.parse(exchangeInstrumentID.toString()));
                  var lastTradedPrice =
                      marketData?.price.toString() ?? 'Loading...';

                  // print(positionProvider.positions![index].exchangeInstrumentID);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.05,
                              offset: Offset(0, 1))
                        ],
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    OrderProvider
                                        .ordervalues![index].tradingSymbol,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      OrderProvider.ordervalues![index].orderStatus,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.info_outline,
                                        color: Colors.black,
                                        size: 17,
                                      ),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                OrderProvider
                                                    .ordervalues![index]
                                                    .orderStatus,
                                              ),
                                              content: Text(
                                                OrderProvider
                                                    .ordervalues![index]
                                                    .cancelRejectReason,
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Close'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        OrderProvider
                                            .ordervalues![index].orderSide,
                                        style: TextStyle(
                                          color: OrderProvider
                                                      .ordervalues![index]
                                                      .orderSide
                                                      .toString() ==
                                                  'BUY'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("DEL"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(OrderProvider
                                          .ordervalues![index].exchangeSegment
                                          .toString())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        marketData != null
                                            ? marketData.price.toString()
                                            : 'Loading...',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      Text(
                                          '(${marketData != null ? marketData.percentChange.toString() : 'Loading...'}%)'),
                                    ],
                                  )
                                ]),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Qty: ${OrderProvider.ordervalues![index].orderQuantity.toString()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(OrderProvider
                                        .ordervalues![index].orderSide
                                        .toString())
                                  ],
                                ),
                                Text(
                                  "Avg: ${OrderProvider.ordervalues![index].orderAverageTradedPrice.toString()}",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}

class OrderHistoryProvider with ChangeNotifier {
  List<OrderHistory>? _orderHistory;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  String searchTerm = '';

  List<OrderHistory>? get orderhistory => _orderHistory;

  Future<void> GetOrderHistroy() async {
    final apiService = ApiService();
    final response = await apiService.GetOrderHistroy(); // Call your API function here
    _orderHistory = OrderHistory.fromJsonList(response);
    print(response);
    notifyListeners();
    if (!_disposed) {
      notifyListeners();
    }
  }

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }
}

class OrderHistoryProviderScreen extends StatefulWidget {
  @override
  _OrderHistoryProviderScreenState createState() =>
      _OrderHistoryProviderScreenState();
}

class _OrderHistoryProviderScreenState
    extends State<OrderHistoryProviderScreen> {
  String search = '';
  List<OrderHistory> filteredPositions = [];

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderHistoryProvider()..GetOrderHistroy(),
      child: Consumer<OrderHistoryProvider>(
        builder: (context, orderHistoryProvider, child) {
          var orderHistoryProvider = Provider.of<OrderHistoryProvider>(context);

          if (orderHistoryProvider.orderhistory == null) {
            return Center(child: CircularProgressIndicator());
          } else if (orderHistoryProvider.orderhistory!.isEmpty) {
            return Center(
                child: Text(
                    style: TextStyle(),
                    "No Orders found. Place an order to view here."));
          } else {
            return Consumer<MarketFeedSocket>(
                builder: (context, marketFeedSocket, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: orderHistoryProvider.orderhistory?.length ?? 0,

                padding:
                    const EdgeInsets.symmetric(vertical: 8.0), // Add this line
                itemBuilder: (context, index) {
                  var orderhistory = orderHistoryProvider.orderhistory?[index];

                  var orderAvglastTradedPrice =
                      orderhistory?.averagePrice ?? 'Default Value';
                  var exchangeSegment =
                      orderhistory?.exchangeSegment ?? 'Default Value';
                  var buySell = orderhistory?.buySell ?? 'Default Value';
                  var TotalQty = orderhistory?.totalQty ?? 'Default Value';
                  var validity = orderhistory?.validity ?? 'Default Value';

                  var exchangeInstrumentID =
                      orderhistory?.exchangeInstrumentID ?? 'Default Value';
                  final marketData = marketFeedSocket
                      .getDataById(int.parse(exchangeInstrumentID.toString()));
                  var lastTradedPrice =
                      marketData?.price.toString() ?? 'Loading...';

                  // print(positionProvider.positions![index].exchangeInstrumentID);
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                              spreadRadius: 0.05,
                              offset: Offset(0, 1))
                        ],
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    orderhistory?.tradingSymbol ??
                                        'Default Value',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  orderhistory?.status ?? 'Default Value',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        buySell,
                                        style: TextStyle(
                                          color: orderhistory?.buySell
                                                      .toString() ==
                                                  'Buy'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(validity),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(exchangeSegment)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // Text(
                                      //   marketData != null
                                      //       ? marketData.price.toString()
                                      //       : 'Loading...',
                                      //   style: TextStyle(color: Colors.red),
                                      // ),
                                      // Text(
                                      //     '(${marketData != null ? marketData.percentChange.toString() : 'Loading...'}%)'),
                                    ],
                                  )
                                ]),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Qty: ${TotalQty}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(orderhistory!.optionType),
                                  ],
                                ),
                                Text(
                                  "Avg: ${orderAvglastTradedPrice}",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }
        },
      ),
    );
  }
}
