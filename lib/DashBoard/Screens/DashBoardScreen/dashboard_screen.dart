import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tradingapp/DashBoard/Screens/FII/DII/fii_dii_screen.dart';
import 'package:tradingapp/DashBoard/Screens/GlobalScreen/GlobalScreen.dart';
import 'package:tradingapp/DashBoard/Screens/IPOsScreen/IPOsScreen.dart';
import 'package:tradingapp/DashBoard/Screens/HighestReturnScreens/Sectoral_themes_screen.dart';
import 'package:tradingapp/DashBoard/Screens/HighestReturnScreens/highest_return_screen.dart';
import 'package:tradingapp/DashBoard/Screens/NotificationScreen/NotificationScreen.dart';
import 'package:tradingapp/DashBoard/Screens/SectorScreen/SectorScreen.dart';
import 'package:tradingapp/Profile/Screens/ProfileScreen/profilepage_screen.dart';
import 'package:tradingapp/Sockets/market_feed_scoket.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

late TabController _tabController;
final marketFeedSocket = MarketFeedSocket();

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late Stream<String> stream;
  @override
  void initState() {
    super.initState();
  }

  final marketFeedSocket = MarketFeedSocket();

  late final TabController _tabController = TabController(length: 3, vsync: this);
  final List<Map<String, dynamic>> mostBought = [
    {
      'name': 'YESBANK',
      'price': 26.13,
      'percentage': '(0.5%)',
      'change': '+90.42',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4J8MeDDrrHwWYm1g30-HGSzdaIQcA2PPQDA2tMc_A4Q&s'
              .toString(),
    },
    {
      'name': 'IRFC',
      'price': 158,
      'percentage': '(7.5%)',
      'change': '+7.80',
      'image': 'https://www.psuconnect.in/sdsdsd/irfc4.jpg'.toString(),
    },
    {
      'name': 'TATASTEEL',
      'price': 165.80,
      'percentage': '(-1.5%)',
      'change': '-1.90',
      'image': 'https://lobbymap.org/site//data/001/361/1361477.png'.toString(),
    },
    {
      'name': 'IDEA',
      'price': 14.00,
      'percentage': '(0.75%)',
      'change': '+14.42',
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/72/Vodafone_Idea_logo.svg/1200px-Vodafone_Idea_logo.svg.png'
              .toString(),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        scrolledUnderElevation: 0.0,
        foregroundColor: Colors.black,
        title: Text("Market"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: InkWell(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                ),
                child: Center(
                  child: Icon(Icons.notifications_active_outlined,color: Colors.black,size: 20,),
                ),
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: TabBar(
              indicatorColor: Colors.blue,
              controller: _tabController,
              isScrollable: true,
              splashFactory: InkRipple.splashFactory,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(text: 'Stocks'),
                Tab(text: 'F&O'),
                Tab(text: 'Mutual Funds'),
              ],
            ),
          ),
        ),
      ),
      body: Consumer<MarketFeedSocket>(builder: (context, feed, child) {
        return feed.bankmarketData.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 2000,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            Container(
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          MarketDataWidget(feed.bankmarketData),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.person_fill,
                                                color: Colors.blue,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.to(
                                                        () => FiiDiiScreen());
                                                  },
                                                  child: Text(
                                                    "Fll/Dll",
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ))
                                            ],
                                          ),
                                          VerticalDivider(
                                            color: Colors.grey,
                                            indent: 10,
                                            endIndent: 10,
                                          ), // Add a vertical divider
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.globe,
                                                color: Colors.blue,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.to(() => Globalscreen());
                                                  },
                                                  child: Text("Global",
                                                      style: TextStyle(
                                                          color: Colors.blue)))
                                            ],
                                          ),
                                          VerticalDivider(
                                            color: Colors.grey,
                                            indent: 10,
                                            endIndent: 10,
                                          ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                CupertinoIcons.chart_pie_fill,
                                                color: Colors.blue,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.to(Sectorscreen());
                                                  },
                                                  child: Text("Sectors",
                                                      style: TextStyle(
                                                          color: Colors.blue)))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 300,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Most Bought",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GridView.builder(
                                              padding: EdgeInsets.all(15),
                                              physics:
                                                  NeverScrollableScrollPhysics(), // Disable scrolling

                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      mainAxisExtent: 100,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Get.to(
                                                        () => ProfileScreen());
                                                  },
                                                  child: Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey[300]!),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                width: 50,
                                                                child: Image
                                                                    .network(
                                                                  mostBought[index]
                                                                          [
                                                                          'image']
                                                                      .toString(),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                              Text(
                                                                mostBought[index]
                                                                        ['name']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  mostBought[index]
                                                                          [
                                                                          'price']
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(mostBought[index]
                                                                            [
                                                                            'change']
                                                                        .toString()),
                                                                    Text(mostBought[index]
                                                                            [
                                                                            'percentage']
                                                                        .toString()),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: mostBought.length,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap:(){
                                                Get.to(() => IPOsScreen());
                                              },
                                              child: Card(
                                                  color: Colors.white,
                                                  child: Container(
                                                    width: 80,
                                                    height: 80,
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height: 40,
                                                                    width: 40,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Colors
                                                                          .blue
                                                                          .withOpacity(
                                                                              0.1),
                                                                    ),
                                                                  ),
                                                                  IconButton(
                                                                      onPressed:
                                                                          () {},
                                                                      icon: Icon(
                                                                        Icons
                                                                            .speaker_notes_outlined,
                                                                        semanticLabel:
                                                                            'Trxt',
                                                                        color: Colors
                                                                            .blue,
                                                                      )),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Text("IPO"),
                                                        ]),
                                                  )),
                                            ),
                                          ),
                                          // Expanded(
                                          //   child: Card(
                                          //       color: Colors.white,
                                          //       child: Container(
                                          //         width: 80,
                                          //         height: 80,
                                          //         child: Column(
                                          //             mainAxisAlignment:
                                          //                 MainAxisAlignment
                                          //                     .center,
                                          //             crossAxisAlignment:
                                          //                 CrossAxisAlignment
                                          //                     .center,
                                          //             children: [
                                          //               Row(
                                          //                 mainAxisAlignment:
                                          //                     MainAxisAlignment
                                          //                         .center,
                                          //                 crossAxisAlignment:
                                          //                     CrossAxisAlignment
                                          //                         .center,
                                          //                 children: [
                                          //                   Stack(
                                          //                     alignment:
                                          //                         Alignment
                                          //                             .center,
                                          //                     children: [
                                          //                       Container(
                                          //                         height: 40,
                                          //                         width: 40,
                                          //                         decoration:
                                          //                             BoxDecoration(
                                          //                           shape: BoxShape
                                          //                               .circle,
                                          //                           color: Colors
                                          //                               .blue
                                          //                               .withOpacity(
                                          //                                   0.1),
                                          //                         ),
                                          //                       ),
                                          //                       IconButton(
                                          //                           onPressed:
                                          //                               () {},
                                          //                           icon: Icon(
                                          //                             Icons
                                          //                                 .star_border_outlined,
                                          //                             semanticLabel:
                                          //                                 'Trxt',
                                          //                             color: Colors
                                          //                                 .blue,
                                          //                           )),
                                          //                     ],
                                          //                   ),
                                          //                 ],
                                          //               ),
                                          //               Text("ETF"),
                                          //             ]),
                                          //       )),
                                          // ),
                                          Expanded(
                                            child: Card(
                                                color: Colors.white,
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.1),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {},
                                                                    icon: Icon(
                                                                      Icons
                                                                          .push_pin_rounded,
                                                                      semanticLabel:
                                                                          'Trxt',
                                                                      color: Colors
                                                                          .blue,
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Text("Stock SIP"),
                                                      ]),
                                                )),
                                          ),
                                          Expanded(
                                            child: Card(
                                                color: Colors.white,
                                                child: Container(
                                                  width: 80,
                                                  height: 80,
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.1),
                                                                  ),
                                                                ),
                                                                IconButton(
                                                                    onPressed:
                                                                        () {},
                                                                    icon: Icon(
                                                                      Icons
                                                                          .trending_up_outlined,
                                                                      semanticLabel:
                                                                          'Trxt',
                                                                      color: Colors
                                                                          .blue,
                                                                    )),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Text("MTF"),
                                                      ]),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      color: Colors.white,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() =>
                                                    HighestReturnScreen());
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey[300]!),
                                                ),
                                                height: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.1),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.wallet_giftcard,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                    Text("Highest Return")
                                                  ],
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() =>
                                                    SectoralThemesScreen());
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.grey[300]!),
                                                ),
                                                height: 100,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          height: 40,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.blue
                                                                .withOpacity(
                                                                    0.1),
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .health_and_safety_rounded,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                    Text("Sectoral Themes")
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Card(
                                      color: Colors.white,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey[300]!),
                                              ),
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue
                                                              .withOpacity(0.1),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.wallet_giftcard,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                  Text("Offers & Rewards")
                                                ],
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.grey[300]!),
                                              ),
                                              height: 100,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue
                                                              .withOpacity(0.1),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .health_and_safety_rounded,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                  Text("Refer & Earn")
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text("data"),
                                  ],
                                ),
                              ),
                            ),

                            // TAB 2 .........................................................  ....  ... ... ... ... ... ....  ..  ...q..  . ..  ... ... ... ... ... ..  . ..  . . . .

                            Container(
                                child: Container(
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: MarketDataWidget(
                                            feed.bankmarketData)),
                                    Text("")
                                  ],
                                ),
                              ),
                            )),
                            Container(
                              height: 500,
                              child: Column(
                                children: [
                                  Center(
                                    child: Text('Tab 3'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('Welcome to Dashboard Screen'),
                    ],
                  ),
                ),
              ));
      }),
    );
  }
}

class MarketDataWidget extends StatefulWidget {
  final Map<int, MarketData> marketData;

  MarketDataWidget(this.marketData);

  @override
  _MarketDataWidgetState createState() => _MarketDataWidgetState();
}

class _MarketDataWidgetState extends State<MarketDataWidget> {
  List<Map<String, dynamic>> getFormattedMarketData() {
    return widget.marketData.entries.where((entry) {
      var name = IndexData.getIndexName(entry.key);
      return name != null && name != "Unknown Index";
    }).map((entry) {
      var name = IndexData.getIndexName(entry.key);
      var data = entry.value;
      return {
        'name': name,
        'price': data.price,
        'percentage': '(${data.percentChange}%)',
        'change': data.percentChange,
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> stocks = getFormattedMarketData();
    final filteredStocks =
        stocks.where((stock) => stock != "Unknown Index").toList();
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Market Data",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // TextButton(
              //   onPressed: () {
              //     showModalBottomSheet(
              //       context: context,
              //       builder: (context) {
              //         return StatefulBuilder(
              //           builder:
              //               (BuildContext context, StateSetter modalSetState) {
              //             return ReorderableListView.builder(
              //               itemCount: stocks.length,
              //               onReorder: (oldIndex, newIndex) {
              //                 modalSetState(() {
              //                   if (newIndex > oldIndex) {
              //                     newIndex -= 1;
              //                   }
              //                   final Map<String, dynamic> item =
              //                       stocks.removeAt(oldIndex);
              //                   stocks.insert(newIndex, item);
              //                 });
              //                 setState(() {});
              //               },
              //               itemBuilder: (context, index) {
              //                 return Dismissible(
              //                   key: Key(stocks[index]['name']),
              //                   onDismissed: (direction) {
              //                     setState(() {
              //                       stocks.removeAt(index);
              //                     });
              //                     setState(() {});
              //                   },
              //                   child: ListTile(
              //                     title: Text(stocks[index]['name']),
              //                     trailing: Icon(Icons.menu),
              //                   ),
              //                 );
              //               },
              //             );
              //           },
              //         );
              //       },
              //     );
              //   },
              //   child: Text('Edit Stocks'),
              // ),
              Container(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredStocks.length,
                  itemBuilder: (context, index) {
                    if (stocks[index] != "Unknown Index") {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProfileScreen());
                        },
                        child: Container(
                          width: 140,
                          child: Container(
                              child: Card(
                            borderOnForeground: true,
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stocks[index]['name'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(stocks[index]['price'].toString(),
                                      style: TextStyle(color: Colors.green)),
                                  Row(
                                    children: [
                                      Text(stocks[index]['change'].toString()),
                                      Text(stocks[index]['percentage']
                                          .toString()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                        ),
                      );
                    }
                  },
                ),
              ),
              // Container(
              //   height: double.maxFinite,
              //   child: ListView.builder(
              //     itemCount: stocks.length,
              //     itemBuilder: (context, index) {
              //       return InkWell(
              //         onTap: () {
              //           // Implement navigation or other interaction
              //         },
              //         child: Container(
              //           width: 140,
              //           child: Card(
              //             color: Colors.white,
              //             child: Container(
              //               padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                     stocks[index]['name'],
              //                     style: TextStyle(fontWeight: FontWeight.w600),
              //                   ),
              //                   Text(
              //                     stocks[index]['price'].toString(),
              //                     style: TextStyle(color: Colors.green),
              //                   ),
              //                   Row(
              //                     children: [
              //                       Text(stocks[index]['change'].toString()),
              //                       Text(stocks[index]['percentage'].toString()),

              //                     ],
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
// class MarketDataWidget extends StatelessWidget {
//   final Map<int, MarketData> marketData;

//   MarketDataWidget(this.marketData);

//   List<Map<String, dynamic>> getFormattedMarketData() {
//     return marketData.entries.map((entry) {
//       var name = IndexData.getIndexName(entry.key) ?? "Unknown Index";
//       var data = entry.value;
//       return {
//         'name': name,
//         'price': data.price,
//         'percentage': '(${data.percentChange}%)',
//         'TimeStamp': data.timestamp,
//       };
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> stocks = getFormattedMarketData();

//     return SingleChildScrollView(
//       child: Container(
//         color: Colors.grey[200],
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 1000,
//                 child: ListView.builder(
//                   itemCount: stocks.length,
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         // Implement navigation or other interaction
//                       },
//                       child: Container(
//                         width: 140,
//                         child: Card(
//                           color: Colors.white,
//                           child: Container(
//                             padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   stocks[index]['name'],
//                                   style: TextStyle(fontWeight: FontWeight.w600),
//                                 ),
//                                 Text(
//                                   stocks[index]['price'].toString(),
//                                   style: TextStyle(color: Colors.green),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(stocks[index]['Timestamp'].toString()),
//                                     Text(stocks[index]['percentage'].toString()),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class IndexData {
  static final Map<String, int> indexMap = {
    // Your mappings here
    "NIFTY 50": 26000,
    "NIFTY BANK": 26001,
    "INDIA VIX": 26002,
    "NIFTY IT": 26003,
    "NIFTY 100": 26004,
    "NIFTY MIDCAP 50": 26005,
    "NIFTY GS 11 15YR": 26006,
    "NIFTY INFRA": 26007,
    "NIFTY100 LIQ 15": 26008,
    "NIFTY REALTY": 26009,
    "NIFTY CPSE": 26010,
    "NIFTY GS COMPSITE": 26011,
    "NIFTY OIL AND GAS": 26012,
    "NIFTY50 TR 1X INV": 26013,
    "NIFTY PHARMA": 26014,
    "NIFTY PSE": 26015,
    "NIFTY MIDCAP 150": 26016,
    "NIFTY MIDCAP 100": 26017,
    "NIFTY SERV SECTOR": 26018,
    "NIFTY 500": 26019,
    "NIFTY ALPHA 50": 26020,
    "NIFTY50 VALUE 20": 26021,
    "NIFTY200 QUALTY30": 26022,
    "NIFTY SMLCAP 250": 26023,
    "NIFTY GROWSECT 15": 26024,
    "NIFTY50 PR 1X INV": 26025,
    "NIFTY50 EQL WGT": 26026,
    "NIFTY PSU BANK": 26027,
    "NIFTY SMLCAP 100": 26028,
    "NIFTY LARGEMID250": 26029,
    "NIFTY100 EQL WGT": 26030,
    "NIFTY SMLCAP 50": 26031,
    "NIFTY ENERGY": 26032,
    "NIFTY GS 10YR": 26033,
    "NIFTY FIN SERVICE": 26034,
    "NIFTY MIDSML 400": 26035,
    "NIFTY METAL": 26036,
    "NIFTY CONSR DURBL": 26037,
    "NIFTY DIV OPPS 50": 26038,
    "NIFTY GS 15YRPLUS": 26039,
    "NIFTY MEDIA": 26040,
    "NIFTY FMCG": 26041,
    "NIFTY PVT BANK": 26042,
    "NIFTY200MOMENTM30": 26043,
    "HANGSENG BEES-NAV": 26044,
    "NIFTY100 LOWVOL30": 26045,
    "NIFTY50 TR 2X LEV": 26046,
    "NIFTY CONSUMPTION": 26047,
    "NIFTY GS 8 13YR": 26048,
    "NIFTY100ESGSECLDR": 26049,
    "NIFTY GS 10YR CLN": 26050,
    "NIFTY GS 4 8YR": 26051,
    "NIFTY AUTO": 26052,
    "NIFTY COMMODITIES": 26053,
    "NIFTY NEXT 50": 26054,
    "NIFTY MNC": 26055,
    "NIFTY MID LIQ 15": 26056,
    "NIFTY HEALTHCARE": 26057,
    "NIFTY500 MULTICAP": 26058,
    "NIFTY ALPHALOWVOL": 26059,
    "NIFTY FINSRV25 50": 26060,
    "NIFTY50 PR 2X LEV": 26061,
    "NIFTY100 QUALTY30": 26062,
    "NIFTY50 DIV POINT": 26063,
    "NIFTY 200": 26064,
    "NIFTY MID SELECT": 26121,

    // Add other indices as needed
  };

  // A static method to get index name by ID
  static String getIndexName(int id) {
    var entry = indexMap.entries.firstWhere((entry) => entry.value == id,
        orElse: () =>
            MapEntry("Unknown Index", -1) // Provide a default MapEntry
        );
    return entry.key; // Return the name or "Unknown Index"
  }

  // Optionally, another static method if you need to find index by name
  static int getIndexValue(String indexName) {
    return indexMap[indexName] ?? -1; // Return -1 if index not found
  }
  // Existing code...
}
