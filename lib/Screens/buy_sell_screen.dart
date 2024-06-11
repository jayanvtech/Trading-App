import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/Utils/exchangeConverter.dart';
import 'package:tradingapp/Sockets/market_feed_scoket.dart';

class BuySellScreen extends StatefulWidget {
  final String exchangeInstrumentId;
  final String exchangeSegment;
  final String lastTradedPrice;
  final String close;
  final String displayName;
  final bool isBuy;
  BuySellScreen(
      {Key? key,
      required this.exchangeInstrumentId,
      required this.exchangeSegment,
      required this.lastTradedPrice,
      required this.close,
      required this.displayName,
      required this.isBuy})
      : super(key: key);

  @override
  State<BuySellScreen> createState() => _BuySellScreenState();
}

class _BuySellScreenState extends State<BuySellScreen> {
  late TextEditingController _controller;
  final TextEditingController QantityController = TextEditingController();
  String _selectedOption = 'Limit';
  String _selectedProductType = 'NRML';
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.lastTradedPrice);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Consumer<MarketFeedSocket>(builder: (context, data, child) {
          final marketData =
              data.getDataById(int.parse(widget.exchangeInstrumentId));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Prodcut Type"),
                  Row(
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: _selectedProductType == 'NRML'
                              ? Colors.white
                              : Colors.black,
                          backgroundColor: _selectedProductType == 'NRML'
                              ? Colors.blue
                              : Colors.grey,
                          disabledForegroundColor:
                              Colors.grey.withOpacity(0.38),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedProductType = 'NRML';
                          });
                        },
                        child: Text('NRML'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: _selectedProductType == 'MIS'
                              ? Colors.white
                              : Colors.black,
                          backgroundColor: _selectedProductType == 'MIS'
                              ? Colors.blue
                              : Colors.grey,
                          disabledForegroundColor:
                              Colors.grey.withOpacity(0.38),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedProductType = 'MIS';
                          });
                        },
                        child: Text('MIS'),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: _selectedProductType == 'CNC'
                              ? Colors.white
                              : Colors.black,
                          backgroundColor: _selectedProductType == 'CNC'
                              ? Colors.blue
                              : Colors.grey,
                          disabledForegroundColor:
                              Colors.grey.withOpacity(0.38),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedProductType = 'CNC';
                          });
                        },
                        child: Text('CNC'),
                      ),
                    ],
                  ),
                  Text("No of Shares"),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: QantityController,
                    decoration: InputDecoration(
                        hintText: "Enter Quantity",
                        labelText: "Quantity",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Price"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                icon: Icon(Icons.remove, color: Colors.white),
                                onPressed: _selectedOption == 'Limit'
                                    ? () {
                                        double currentValue =
                                            double.tryParse(_controller.text) ??
                                                0;
                                        currentValue -=
                                            1; // Decrease the value by 1
                                        _controller.text =
                                            currentValue.toStringAsFixed(
                                                2); // Update the controller
                                      }
                                    : null, // Disable the button when "Market" is selected
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 70, // You can adjust this value as needed
                              child: TextField(
                                controller: _controller,
                                textAlign: TextAlign.center,

                                readOnly: _selectedOption ==
                                    'Market', // Make the TextField read-only when "Market" is selected
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'^\d+\.?\d{0,2}')), // Allow decimal input
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: _selectedOption == 'Limit'
                                    ? () {
                                        double currentValue =
                                            double.tryParse(_controller.text) ??
                                                0;
                                        currentValue +=
                                            1; // Increase the value by 1
                                        _controller.text =
                                            currentValue.toStringAsFixed(
                                                2); // Update the controller
                                      }
                                    : null, // Disable the button when "Market" is selected
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                foregroundColor: _selectedOption == 'Limit'
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: _selectedOption == 'Limit'
                                    ? Colors.blue
                                    : Colors.grey,
                                disabledForegroundColor:
                                    Colors.grey.withOpacity(0.38),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedOption = 'Limit';
                                });
                              },
                              child: Text('Limit'),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                foregroundColor: _selectedOption == 'Market'
                                    ? Colors.white
                                    : Colors.black,
                                backgroundColor: _selectedOption == 'Market'
                                    ? Colors.blue
                                    : Colors.grey,
                                disabledForegroundColor:
                                    Colors.grey.withOpacity(0.38),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedOption = 'Market';
                                  // Provider.of<MarketFeedSocket>(context,
                                  //         listen: false)
                                  //     .addListener(() {
                                  //   _controller.text =
                                  //       Provider.of<MarketFeedSocket>(context,
                                  //               listen: false)
                                  //           .getDataById(int.parse(
                                  //               widget.exchangeInstrumentId))!
                                  //           .price
                                  //           .toString();
                                  // });
                                });
                              },
                              child: Text('Market'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final orderDetails = {
                          "clientID": "A0031",
                          "exchangeSegment": ExchangeConverter()
                              .getExchangeSegmentName(
                                  int.parse(widget.exchangeSegment))
                              .toString(),
                          "exchangeInstrumentID":
                              widget.exchangeInstrumentId.toString(),
                          "productType": "NRML",
                          "orderType":
                              _controller.text == widget.lastTradedPrice
                                  ? "MARKET"
                                  : "LIMIT",
                          "orderSide": widget.isBuy ? "BUY" : "SELL",
                          "timeInForce": "DAY",
                          "disclosedQuantity": 0,
                          "orderQuantity": QantityController.text,
                          "limitPrice": 3200,
                          "stopPrice": 0,
                          "userID": "A0031"
                        };
                        ApiService().placeOrder(orderDetails);
                      },
                      child: Text("Place Buy Order"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  ),
                  _selectedProductType == 'MIS'
                      ? Container(
                          child: Text(marketData!.percentChange.toString()),
                        ) // Display this when 'mis' is selected
                      : SizedBox(
                          height: 20,
                        ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
