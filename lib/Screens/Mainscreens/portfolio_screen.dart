import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tradingapp/Authentication/auth_services.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/Sockets/market_feed_scoket.dart';
import 'package:tradingapp/model/tradeOrder_model.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holdings'),
        actions: [
          IconButton(
              onPressed: () async {
                var token = await getToken();
                print(token);
              },
              icon: Icon(Icons.abc_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                height: 130,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade100.withOpacity(0.1),
                        Colors.blueGrey.shade700.withOpacity(0.4),
                      ],
                    ),
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      "₹45678",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.green,
                          size: 16,
                        ),
                        Text("Overall Gain"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "₹345678",
                          style: TextStyle(color: Colors.green),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("+(10.42%)")
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Invested Value"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "₹345678",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                Text("Today's Gain")
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "₹345678",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text("+(10.42%)"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              HoldingsPortfolioScreen()
            ],
          ),
        ),
      ),
    );
  }
}

class HoldingProvider with ChangeNotifier {
  List<Holdings>? _holdingsvalues;

  String searchTerm = '';
  List<Holdings>? get holdingValues => _holdingsvalues;

  Future<void> GetHoldings() async {
    final apiService = ApiService();
    final response =
        await apiService.GetHoldings(); // Call your API function here
    _holdingsvalues = Holdings.fromJsonList(response);

    notifyListeners();
  }

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }
}

class HoldingsPortfolioScreen extends StatefulWidget {
  @override
  _PHoldingsPortfolioScreenState createState() =>
      _PHoldingsPortfolioScreenState();
}

class _PHoldingsPortfolioScreenState extends State<HoldingsPortfolioScreen> {
  String search = '';
  @override
  List<Holdings> filteredPositions = [];

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HoldingProvider()..GetHoldings(),
      child: Consumer<HoldingProvider>(
        builder: (context, HoldingProvider, child) {
          if (HoldingProvider.holdingValues == null) {
            return Center(child: CircularProgressIndicator());
          } else if (HoldingProvider.holdingValues!.isEmpty) {
            return SizedBox(
              height: 500,
              child: Center(
                  child: Text(
                "You have no Holdings. Place an order to open a new Holding.",
                textAlign: TextAlign.center,
              )),
            );
          } else {
            if (HoldingProvider.holdingValues != null &&
                HoldingProvider.holdingValues!.isNotEmpty) {
              for (var holdingValues in HoldingProvider.holdingValues!) {
                var exchangeSegment = holdingValues.exchangeNSEInstrumentId;
                var exchangeInstrumentID =
                    holdingValues.exchangeBSEInstrumentId;

                void callMarketInstrumentSubscribe(
                    String exchangeNSEInstrumentId,
                    String exchangeBSEInstrumentId) {
                  String exchangeInstrumentId;
                  String exhchangeSegment;

                  if (exchangeNSEInstrumentId != 0) {
                    exchangeInstrumentId = exchangeNSEInstrumentId;
                    exhchangeSegment = "1";
                  } else {
                    exchangeInstrumentId = exchangeBSEInstrumentId;
                    exhchangeSegment = "11";
                  }

                  ApiService().MarketInstrumentSubscribe(
                      exhchangeSegment.toString(),
                      exchangeInstrumentId.toString());
                  // print(
                  //     "Subscribed to market $exhchangeSegment  data for $exchangeInstrumentId");
                }

                callMarketInstrumentSubscribe(
                    holdingValues.exchangeNSEInstrumentId.toString(),
                    holdingValues.exchangeBSEInstrumentId.toString());
              }
            }

            Future<List> checkNSEorBSE() async {
              List<Future> futures = [];

              for (var holdingValue in HoldingProvider.holdingValues!) {
                String exchangeSegment =
                    holdingValue.exchangeNSEInstrumentId != "0" ? "1" : "11";
                futures.add(ApiService().GetInstrumentByID(
                    holdingValue.exchangeNSEInstrumentId.toString(),
                    exchangeSegment));
              }

              List results = await Future.wait(futures);

              return results;
            }

            return FutureBuilder(
                future: checkNSEorBSE(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  var DisplayName = snapshot.data;
                  return Consumer<MarketFeedSocket>(
                    builder: (context, marketFeedSocket, child) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: HoldingProvider.holdingValues!.length,
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0), // Add this line
                          itemBuilder: (BuildContext context, int index) {
                            var holdings =
                                HoldingProvider.holdingValues![index];

                            var quentity = holdings.holdingQuantity.toString();
                            var orderAvglastTradedPrice = holdings.buyAvgPrice;
                            var exchangeSegment =
                                holdings.exchangeNSEInstrumentId;
                            var exchangeInstrumentID =
                                holdings.exchangeNSEInstrumentId;

                            //  checkNSEorBSE(holdings.exchangeNSEInstrumentId.toString(),
                            //             holdings.exchangeBSEInstrumentId.toString());
                            final marketData = marketFeedSocket.getDataById(
                                int.parse(exchangeInstrumentID.toString()));
                            var lastTradedPrice =
                                marketData?.price.toString() ?? 'Loading...';
                            double? TotalBenifits;
                            if (lastTradedPrice != 'Loading...') {
                              TotalBenifits = (double.parse(lastTradedPrice) -
                                      double.parse(
                                          holdings.buyAvgPrice.toString() ??
                                              '0')) *
                                  (double.parse(quentity));
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              DisplayName[index].toString(),
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Text(
                                            TotalBenifits != null
                                                ? TotalBenifits.toStringAsFixed(
                                                    2)
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

                                                Row(
                                                  children: [
                                                    Text(
                                                      "${holdings.holdingQuantity.toString()}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      child: Text(
                                                        " X ",
                                                      ),
                                                    ),
                                                    Text(
                                                        "₹${holdings.buyAvgPrice.toString()}")
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("LTP"),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      marketData != null
                                                          ? "${marketData.price.toString()}"
                                                          : 'Loading...',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
