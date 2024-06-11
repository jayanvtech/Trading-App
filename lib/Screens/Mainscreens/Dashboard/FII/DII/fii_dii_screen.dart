import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/Screens/Mainscreens/Dashboard/FII/DII/Model/fiidiimonthlydetails_model.dart';

class FiiDiiScreen extends StatefulWidget {
  const FiiDiiScreen({Key? key}) : super(key: key);

  @override
  State<FiiDiiScreen> createState() => _FiiDiiScreenState();
}

class _FiiDiiScreenState extends State<FiiDiiScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: AppBar(
        title: Text('Fii Dii Screen'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cash'),
            Tab(text: 'F&O'),
            Tab(text: 'Third Tab'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CashFiiDII(),
          FnOFiiDII(),
          // Center(child: Text('F&O Tab Content')),
          Center(child: Text('Third Tab Content')),
        ],
      ),
    );
  }
  
}

class CashFiiDII extends StatefulWidget {
  const CashFiiDII({super.key});

  @override
  State<CashFiiDII> createState() => _CashFiiDIIState();
}

class _CashFiiDIIState extends State<CashFiiDII> {
  bool _isDailySelected = true;

  // Future<Map<String, dynamic>> _fetchData() async {
  //   if (_isDailySelected) {
  //     // Fetch daily data
  //     final data = ApiService().fetchFiiDiiDetails();
  //     return data;
  //   } else {
  //     final data = ApiService().fetchFiiDiiDetails();
  //     return data;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.blue : Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.white : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _isDailySelected = true;
                        });
                      },
                      child: Text('Daily'),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.grey : Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.black : Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _isDailySelected = false;
                        });
                      },
                      child: Text('Monthly'),
                    ),
                  ),
                ],
              ),
            ),
            _isDailySelected
                ? Expanded(
                    child: FutureBuilder<Map<String, dynamic>>(
                        future: ApiService().fetchFiiDiiDetails(),
                        builder: (BuildContext context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            if (snapshot.hasError)
                              return Text('Error: ${snapshot.error}');
                            else {
                              var data = snapshot.data!.entries.toList();
                              print(data);
                              data.sort((a, b) => b.key.compareTo(
                                  a.key)); // sort in descending order

                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.separated(
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    print("$data");
                                    if (index == 0) {
                                      // This is the header
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Date',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('FII',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('DII',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      );
                                    } else {
                                      var itemIndex = index - 1;

                                      var date = data[itemIndex].key;
                                      // var cahs_date =
                                      //     data[itemIndex].value['cash_date'];

                                      var inputFormat =
                                          DateFormat('yyyy-MM-dd');
                                      var inputDate = inputFormat.parse(date);

                                      var outputFormat =
                                          DateFormat('dd MMM yyyy');
                                      var outputDate =
                                          outputFormat.format(inputDate);
                                      var fiiDifference = data[itemIndex]
                                          .value['fii_buy_sell_difference'];
                                      var diiDifference = data[itemIndex]
                                          .value['dii_buy_sell_difference'];

                                      bool isNegative = fiiDifference
                                          .toString()
                                          .startsWith('-');
                                      bool isNegative2 = diiDifference
                                          .toString()
                                          .startsWith('-');

                                      return Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      _isDailySelected
                                                          ? outputDate
                                                          : date,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      fiiDifference
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                        color: isNegative
                                                            ? Colors.red
                                                            : Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      fiiDifference
                                                          .toStringAsFixed(2),
                                                      style: TextStyle(
                                                        color: isNegative2
                                                            ? Colors.red
                                                            : Colors.green,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider();
                                  },
                                ),
                              );
                            }
                          }
                        }))
                : FutureBuilder<List<FiiDiiDetails>>(
                    future:
                        ApiService().fetchFiiDiiDetailsMonthly().then((data) {
                      // Parse the JSON data here
                      final parsedData = (data
                          as Map<String, dynamic>)['result'] as List<dynamic>;
                      return parsedData
                          .map((item) => FiiDiiDetails.fromJson(item))
                          .toList();
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final fiiDiiDetails = snapshot.data!;
        
                        
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.separated(

                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider();
                            },
                            itemCount: fiiDiiDetails.length +
                                1, // Add 1 for the header
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                // This is the header
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text('FII',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text('DII',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                );
                              } else {
                                // This is the data
                                final detail = fiiDiiDetails[index - 1];
                                final nagativalue = detail
                                    .cashFiiNetPurchaseSales
                                    .startsWith('-');
                                final nagativalue2 = detail
                                    .cashDiiNetPurchaseSales
                                    .startsWith('-');

                                return Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 130,
                                              child: Text(
                                                detail.cashDate,
                                              ),
                                            ),
                                          ]),
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 110,
                                              child: Text(
                                                detail.cashFiiNetPurchaseSales,
                                                style: TextStyle(
                                                  color: nagativalue
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                              ),
                                            ),
                                          ]),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 70,
                                              child: Text(
                                                detail.cashDiiNetPurchaseSales,
                                                style: TextStyle(
                                                  color: nagativalue2
                                                      ? Colors.red
                                                      : Colors.green,
                                                ),
                                              ),
                                            ),
                                          ]),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

class FnOFiiDII extends StatefulWidget {
  const FnOFiiDII({super.key});

  @override
  State<FnOFiiDII> createState() => _FnOFiiDIIState();
}

class _FnOFiiDIIState extends State<FnOFiiDII> {
  bool _isDailySelected = true;

  // Future<Map<String, dynamic>> _fetchData() async {
  //   if (_isDailySelected) {
  //     // Fetch daily data
  //     final data = ApiService().fetchFiiDiiDetails();
  //     return data;
  //   } else {
  //     final data = ApiService().fetchFiiDiiDetails();
  //     return data;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        alignment: Alignment.center,
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.blue : Colors.grey),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.white : Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _isDailySelected = true;
                        });
                      },
                      child: Text('Daily'),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.grey : Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            _isDailySelected ? Colors.black : Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _isDailySelected = false;
                        });
                      },
                      child: Text('Monthly'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _isDailySelected
                    ? ApiService().fetchFiiDiiDetails()
                    : ApiService().fetchFiiDiiDetails(),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else {
                      var data = snapshot.data!.entries.toList();
                      data.sort((a, b) =>
                          b.key.compareTo(a.key)); // sort in descending order

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              // This is the header
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('FII',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('DII',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              );
                            } else {
                              var itemIndex = index - 1;

                              var date = data[itemIndex].key;
                              var inputFormat = DateFormat('yyyy-MM-dd');
                              var inputDate = inputFormat.parse(date);

                              var outputFormat = DateFormat('dd MMM yyyy');
                              var outputDate = outputFormat.format(inputDate);
                              var fiiDifference = data[itemIndex]
                                  .value['fii_buy_sell_difference'];
                              var diiDifference = data[itemIndex]
                                  .value['dii_buy_sell_difference'];
                              bool isNegative =
                                  fiiDifference.toString().startsWith('-');
                              bool isNegative2 =
                                  diiDifference.toString().startsWith('-');

                              return Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(outputDate),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              fiiDifference.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: isNegative
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              diiDifference.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: isNegative2
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider();
                          },
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
