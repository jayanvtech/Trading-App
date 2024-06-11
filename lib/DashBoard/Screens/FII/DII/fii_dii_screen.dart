import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tradingapp/DashBoard/Screens/FII/DII/Model/fiiHistoryDataModel.dart';
import 'package:tradingapp/DashBoard/Screens/FII/DII/Model/fiidiimonthlydetails_model.dart';
import 'package:tradingapp/DashBoard/Screens/FII/DII/Model/stocksAndIndexDataModel.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';

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
            Tab(text: 'Future'),
            Tab(text: 'Option'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CashFiiDII(),
          FnOFiiDII(),
          OptionScreen(),
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
      body: SingleChildScrollView(
        child: Container(
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
                              data.sort((a, b) => b.key.compareTo(a.key)); // sort in descending order

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
                        },
                      ),
                    )
                  : Expanded(
                      child: FutureBuilder<List<FiiDiiDetails>>(
                        future: ApiService()
                            .fetchFiiDiiDetailsMonthly(type: "cash")
                            .then((data) {
                          final parsedData = (data)['result'] as List<dynamic>;
                          return parsedData
                              .map((item) => FiiDiiDetails.fromJson(item))
                              .toList();
                        }),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('No data available'));
                          } else {
                            final fiiDiiDetails = snapshot.data!;
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: ListView.separated(
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          Divider(),
                                  itemCount: fiiDiiDetails.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
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
                                      final detail = fiiDiiDetails[index - 1];
                                      final isNegativeFii = detail
                                          .cashFiiNetPurchaseSales
                                          .startsWith('-');
                                      final isNegativeDii = detail
                                          .cashDiiNetPurchaseSales
                                          .startsWith('-');

                                      DateTime inputDate =
                                          DateFormat('MMMM yyyy')
                                              .parse(detail.cashDate);

                                      String formattedDate =
                                          DateFormat('MMM yyyy')
                                              .format(inputDate);

                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(formattedDate),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  detail
                                                      .cashFiiNetPurchaseSales,
                                                  style: TextStyle(
                                                      color: isNegativeFii
                                                          ? Colors.red
                                                          : Colors.green),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  detail
                                                      .cashDiiNetPurchaseSales,
                                                  style: TextStyle(
                                                      color: isNegativeDii
                                                          ? Colors.red
                                                          : Colors.green),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
            ],
          ),
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
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Visibility(
          visible: !_isDailySelected,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    isSelected = 0;
                  });
                },
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(05),
                    color: isSelected == 0 ? Colors.blue : Colors.white,
                  ),
                  child: Center(
                    child: Text("Stock",style: GoogleFonts.inter(
                      color: isSelected == 0 ? Colors.white : Colors.black,
                      fontSize: 15
                    ),),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelected = 1;
                  });
                },
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(05),
                    color: isSelected == 1 ? Colors.blue : Colors.white,
                  ),
                  child: Center(
                    child: Text("Index",style: GoogleFonts.inter(
                      color: isSelected == 1 ? Colors.white : Colors.black,
                      fontSize: 15
                    ),),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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
            _isDailySelected ?
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: ApiService().fetchFiiDiiDetails(),
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
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Net Purchase/Sale',
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

                              var fiiDifference = data[itemIndex].value['fii_buy_sell_difference'];
                              var diiDifference = data[itemIndex].value['dii_buy_sell_difference'];
                              var diiFnOAmountWise = data[itemIndex].value['dii_fnoDii_amount_wise'];

                              bool isNegative = fiiDifference.toString().startsWith('-');
                              bool isNegative2 = diiDifference.toString().startsWith('-');
                              bool isNegative3 = diiFnOAmountWise.toString().startsWith('-');

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
                                              diiFnOAmountWise.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: isNegative3
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
            ) :
            Expanded(
              child: FutureBuilder<List<FiiData>>(
                future: isSelected == 0
                    ? ApiService().fetchStockAndIndexData(type: "fo_stocks")
                    : ApiService().fetchStockAndIndexData(type: "fo_index"),
                builder: (BuildContext context, AsyncSnapshot<List<FiiData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    var data = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                        itemCount: data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Net Purchase/Sale (Fut)', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          } else {
                            var itemIndex = index - 1;
                            var fiiData = data[itemIndex];

                            // var inputFormat = DateFormat('yyyy-MM-dd');
                            // var inputDate = inputFormat.parse(fiiData.foDate);
                            //
                            // var outputFormat = DateFormat('dd MMM yyyy');
                            // var outputDate = outputFormat.format(inputDate);

                            bool isNegative3 = fiiData.fiiNetPurchaseSalesFut.toString().startsWith('-');

                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(fiiData.foDate),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            fiiData.fiiNetPurchaseSalesFut,
                                            style: TextStyle(
                                              color: isNegative3 ? Colors.red : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionScreen extends StatefulWidget {
  const OptionScreen({super.key});

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  bool _isDailySelected = true;
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Visibility(
          visible: !_isDailySelected,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    isSelected = 0;
                  });
                },
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(05),
                    color: isSelected == 0 ? Colors.blue : Colors.white,
                  ),
                  child: Center(
                    child: Text("Stock",style: GoogleFonts.inter(
                        color: isSelected == 0 ? Colors.white : Colors.black,
                        fontSize: 15
                    ),),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isSelected = 1;
                  });
                },
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(05),
                    color: isSelected == 1 ? Colors.blue : Colors.white,
                  ),
                  child: Center(
                    child: Text("Index",style: GoogleFonts.inter(
                        color: isSelected == 1 ? Colors.white : Colors.black,
                        fontSize: 15
                    ),),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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
            _isDailySelected ?
            Expanded(
              child: FutureBuilder<FiiHistoryData>(
                future: ApiService().fetchFiiDiiDetails1(),
                builder: (BuildContext context,
                    AsyncSnapshot<FiiHistoryData> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError)
                      return Text('Error: ${snapshot.error}');
                    else {
                      var data = snapshot.data!.success.data.entries.toList();
                      data.sort((a, b) =>
                          b.key.compareTo(a.key)); // sort in descending order

                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Call',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Put',
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

                              var Call = data[itemIndex].value.option.fii.call.netOiChange;
                              var Put = data[itemIndex].value.option.fii.put.netOiChange;

                              bool isNegative1 = Call.toString().startsWith('-');
                              bool isNegative2 = Put.toString().startsWith('-');

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
                                              Call.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: isNegative1
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              Put.toStringAsFixed(2),
                                              style: TextStyle(
                                                color: isNegative2
                                                    ? Colors.red
                                                    : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
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
            ) :
            Expanded(
              child: FutureBuilder<List<FiiData>>(
                future: isSelected == 0
                    ? ApiService().fetchStockAndIndexData(type: "fo_stocks")
                    : ApiService().fetchStockAndIndexData(type: "fo_index"),
                builder: (BuildContext context, AsyncSnapshot<List<FiiData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    var data = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.separated(
                        itemCount: data.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('Net Purchase/Sale (Fut)', style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            );
                          } else {
                            var itemIndex = index - 1;
                            var fiiData = data[itemIndex];

                            // var inputFormat = DateFormat('yyyy-MM-dd');
                            // var inputDate = inputFormat.parse(fiiData.foDate);
                            //
                            // var outputFormat = DateFormat('dd MMM yyyy');
                            // var outputDate = outputFormat.format(inputDate);

                            bool isNegative3 = fiiData.fiiNetPurchaseSalesFut.toString().startsWith('-');

                            return Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(fiiData.foDate),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            fiiData.fiiNetPurchaseSalesOp,
                                            style: TextStyle(
                                              color: isNegative3 ? Colors.red : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

