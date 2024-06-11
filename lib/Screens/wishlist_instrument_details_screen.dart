import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/Utils/exchangeConverter.dart';
import 'package:tradingapp/Screens/buy_sell_screen.dart';
import 'package:tradingapp/Screens/instrument_details_screen.dart';
import 'package:tradingapp/Sockets/market_feed_scoket.dart';

class ViewMoreInstrumentDetailScreen extends StatefulWidget {
  final String exchangeInstrumentId;
  final String exchangeSegment;
  final String lastTradedPrice;
  final String close;
  final String displayName;

  const ViewMoreInstrumentDetailScreen({
    Key? key,
    required this.exchangeInstrumentId,
    required this.exchangeSegment,
    required this.lastTradedPrice,
    required this.close,
    required this.displayName,
  }) : super(key: key);

  @override
  State<ViewMoreInstrumentDetailScreen> createState() =>
      _ViewMoreInstrumentDetailScreenState();
}

class _ViewMoreInstrumentDetailScreenState
    extends State<ViewMoreInstrumentDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    ApiService().MarketInstrumentSubscribe(
      ExchangeConverter().getExchangeSegmentName(int.parse(widget.exchangeSegment)), widget.exchangeInstrumentId.toString());
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Consumer<MarketFeedSocket>(builder: (context, data, child) {
          final marketData =
              data.getDataById(int.parse(widget.exchangeInstrumentId));

          final priceChange = marketData != null
              ? double.parse(marketData.price) - double.parse(widget.close)
              : 0;
          final priceChangeColor = priceChange > 0 ? Colors.green : Colors.red;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.displayName),
                  Text(
                    ExchangeConverter().getExchangeSegmentName(
                        int.parse(widget.exchangeSegment)),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        "₹" + marketData!.price.toString(),
                        style: TextStyle(color: priceChangeColor, fontSize: 18),
                      ),
                      Icon(
                        Icons.arrow_drop_up,
                        color: priceChangeColor,
                      ),
                    ],
                  ),
                  Text(
                    "${priceChange.toStringAsFixed(2)}(${marketData!.percentChange}%)",
                    style: TextStyle(color: priceChangeColor, fontSize: 15),
                  )
                ],
              ),
            ],
          );
        }),
        bottom: TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          automaticIndicatorColorAdjustment: true,
          controller: _tabController,
          tabs: [
            Tab(text: 'Overview'),
            Tab(text: 'Technical'),
            Tab(text: 'Derivatives'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OverviewTab(
            exchangeInstrumentId: widget.exchangeInstrumentId,
            exchangeSegment: widget.exchangeSegment,
            lastTradedPrice: widget.lastTradedPrice,
            close: widget.close,
            displayName: widget.displayName,
          ),
          Text("data"),
          Text("data"),
        ],
      ),
    );
  }
}

class OverviewTab extends StatefulWidget {
  final String exchangeInstrumentId;
  final String exchangeSegment;
  final String lastTradedPrice;
  final String close;
  final String displayName;

  const OverviewTab({
    Key? key,
    required this.exchangeInstrumentId,
    required this.exchangeSegment,
    required this.lastTradedPrice,
    required this.close,
    required this.displayName,
  }) : super(key: key);

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab> {
  @override
  Widget build(BuildContext context) {
    final exchangeInstrumentId = widget.exchangeInstrumentId;
    final exchangeSegment = widget.exchangeSegment;
    final lastTradedPrice = widget.lastTradedPrice;
    final close = widget.close;
    final displayName = widget.displayName;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Consumer<MarketFeedSocket>(
          builder: (context, data, child) {
            final marketData =
                data.getDataById(int.parse(exchangeInstrumentId));
            final priceChange = marketData != null
                ? double.parse(marketData.price) - double.parse(close)
                : 0;
            final priceChangeColor =
                priceChange > 0 ? Colors.green : Colors.red;

            if (marketData != null) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "OPEN",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Text(marketData.Open),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "HIGH",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Text(marketData.High),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "LOW",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Text(marketData.Low),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      "PREV. CLOSE",
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    Text(marketData.close.toString()),
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
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('QTY',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                )),
                                            Text('BUY PRICE',
                                                style: TextStyle(
                                                    color: Colors.black87,
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('BUY PRICE',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
                                                )),
                                            Text('QTY',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.black87,
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
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 200,
                                      width: 180,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: marketData.bids.length,
                                        itemBuilder: (context, index) {
                                          var bid = marketData.bids[index];
                                          return Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('${bid.size}'),
                                                Text(
                                                  '${bid.price}',
                                                  style: TextStyle(
                                                      color: Colors.green),
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
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: marketData.asks.length,
                                          itemBuilder: (context, index) {
                                            var asks = marketData.asks[index];
                                            return Container(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('${asks.price}',
                                                        style: TextStyle(
                                                            color: Colors.red)),
                                                    Text('${asks.size}'),
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
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(marketData.totalBuyQuantity),
                                      Text("TOTAL QUANTITY"),
                                      Text(marketData.totalSellQuantity)
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
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Option Chain"),
                          VerticalDivider(),
                          Text("Charts"),
                          VerticalDivider(),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        InstrumentDetailsScreen(
                                      ExchangeInstrumentID: exchangeInstrumentId,
                                      ExchangeInstrumentName: displayName,
                                        )
                                  ),
                                );
                              },
                              child: Text("Stock Details"))
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BuySellScreen(
                                      exchangeInstrumentId:
                                          exchangeInstrumentId,
                                      exchangeSegment: exchangeSegment,
                                      lastTradedPrice: marketData.price,
                                      close: close,
                                      displayName: displayName,
                                      isBuy: true,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green,
                                ),
                                child: Center(
                                    child: Text("BUY",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
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
                                    builder: (context) => BuySellScreen(
                                      exchangeInstrumentId:
                                          exchangeInstrumentId,
                                      exchangeSegment: exchangeSegment,
                                      lastTradedPrice: marketData.price,
                                      close: close,
                                      displayName: displayName,
                                      isBuy: false,
                                    ),
                                  ),
                                );
                              },

                              
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.red,
                                ),
                                child: Center(
                                    child: Text("SELL",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18))),
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
  }
}
