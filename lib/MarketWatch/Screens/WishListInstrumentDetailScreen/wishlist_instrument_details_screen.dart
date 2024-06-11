import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tradingapp/DashBoard/Screens/option_chain_screen/option_chain_screen.dart';
import 'package:tradingapp/Utils/exchangeConverter.dart';
import 'package:tradingapp/DashBoard/Screens/BuyOrSellScreen/buy_sell_screen.dart';
import 'package:tradingapp/MarketWatch/Screens/InstrumentDetailScreen/instrument_details_screen.dart';
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
                    "${priceChange.toStringAsFixed(2)}(${marketData.percentChange}%)",
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
  List<String> PerformanceTitles = [
    "Today's High",
    "Today's Low",
    "52W High",
    "52W Low",
    "Opening Price",
    "Prev. Price",
    "Volume",
    "Lower circuit",
    "Upper circuit"
  ];

  List<String> PerformanceSubTitles = [
    "Today's high represents the peak trading price of the stock for the day.",
    "Today's low represents the lowest trading price of the stock for the day.",
    "The 52-week high is the peak trading price of the stock over the past 52 weeks.",
    "The 52-week low is the minimum trading price of the stock over the past 52 weeks.",
    "The opening price is the initial trading price of the stock when the exchange begins.",
    "The prev. price is the closing price of the stock when the exchange concludes trading. It reflects the previous session's closing value.",
    "Volume, or trading volume, is the aggregate number of shares traded, encompassing both purchases and sales, on the exchange throughout the day.",
    "A lower circuit is the minimum price level that a stock can decline to on a specific trading day.",
    "The upper circuit represents the highest price limit to which a stock can ascend during a particular trading session."
  ];

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
            final marketData = data.getDataById(int.parse(exchangeInstrumentId));
            final priceChange = marketData != null ? double.parse(marketData.price) - double.parse(close) : 0;
            final priceChangeColor = priceChange > 0 ? Colors.green : Colors.red;

            if (marketData != null) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          "OPEN",
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                          style:
                                              TextStyle(color: Colors.black54),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('QTY',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('BUY PRICE',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black87,
                                                    )),
                                                Text('QTY',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                var asks =
                                                    marketData.asks[index];
                                                return Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('${asks.price}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)),
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
                                      padding: EdgeInsets.all(10.0),
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
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Performance",
                                    style: GoogleFonts.inter(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: 40,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .blueAccent
                                                                  .shade100
                                                                  .withOpacity(
                                                                      0.4)),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .event_note_outlined,
                                                              color: Colors
                                                                  .blueAccent,
                                                              size: 20,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Performance",
                                                        style:
                                                            GoogleFonts.inter(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          "Metrics provide data illustrating the company's stock performance, with these figures fluctuating daily.",
                                                          style:
                                                              GoogleFonts.inter(
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    child: ListView.builder(
                                                      itemCount: PerformanceTitles.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      4.0),
                                                          child: Container(
                                                            child: ListTile(
                                                              title: Text(
                                                                PerformanceTitles[
                                                                    index],
                                                                style: GoogleFonts.inter(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                              subtitle: Text(
                                                                PerformanceSubTitles[index],
                                                                style: GoogleFonts.inter(
                                                                    color: Colors.black,
                                                                    fontSize: 10,
                                                                ),
                                                                textAlign: TextAlign.start,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.info,
                                        color: Colors.grey,
                                        size: 20,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Today's Low",
                                    style: GoogleFonts.inter(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                  Text(
                                    "Today's High",
                                    style: GoogleFonts.inter(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ],
                              ),
                              RangeChart(
                                low: double.parse(marketData.Low),
                                high: double.parse(marketData.High),
                                current: double.parse(marketData.price),
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
                                              InstrumentDetailsScreen(
                                                ExchangeInstrumentID:
                                                    exchangeInstrumentId,
                                                ExchangeInstrumentName:
                                                    displayName,
                                              )),
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
                  ),
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

class RangeChart extends StatelessWidget {
  final double low;
  final double high;
  final double current;

  const RangeChart({
    Key? key,
    required this.low,
    required this.high,
    required this.current,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, 60),
      painter: RangeChartPainter(low: low, high: high, current: current),
    );
  }
}

class RangeChartPainter extends CustomPainter {
  final double low;
  final double high;
  final double current;

  RangeChartPainter({
    required this.low,
    required this.high,
    required this.current,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    final double rangeWidth = size.width;
    final double rangeHeight = 4.0;
    final double rangeTop = size.height / 2 - rangeHeight / 2;
    final double markerSize = 10.0;

    final Rect rangeRect = Rect.fromLTWH(0, rangeTop, rangeWidth, rangeHeight);
    canvas.drawRect(rangeRect, paint);

    final double markerPosition = ((current - low) / (high - low)) * rangeWidth;
    final Path markerPath = Path()
      ..moveTo(markerPosition, rangeTop - markerSize / 2)
      ..lineTo(markerPosition - markerSize / 2,
          rangeTop + rangeHeight + markerSize / 2)
      ..lineTo(markerPosition + markerSize / 2,
          rangeTop + rangeHeight + markerSize / 2)
      ..close();
    paint.color = Colors.blueGrey;
    canvas.drawPath(markerPath, paint);

    final TextPainter lowTextPainter = TextPainter(
      text: TextSpan(
        text: low.toStringAsFixed(2),
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    lowTextPainter.layout(minWidth: 0, maxWidth: size.width);
    lowTextPainter.paint(canvas, Offset(0, rangeTop - 20));

    final TextPainter highTextPainter = TextPainter(
      text: TextSpan(
        text: high.toStringAsFixed(2),
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    highTextPainter.layout(minWidth: 0, maxWidth: size.width);
    highTextPainter.paint(
        canvas, Offset(size.width - highTextPainter.width, rangeTop - 20));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
