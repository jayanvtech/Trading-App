import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/Authentication/auth_services.dart';

// Make sure this import is correct
class MarketData {
  final String price;
  final String percentChange;
  String close;
  final List<Bid> bids;
  final List<Asks> asks;
  final String totalBuyQuantity;
  final String totalSellQuantity;
  final String Open; 
  final String High;
  final String Low; 

  MarketData({
    required this.price,
    required this.percentChange,
    required this.close,
    required this.bids,
    required this.asks,
    required this.totalBuyQuantity,
    required this.totalSellQuantity,
    required this.Open,
    required this.High,
    required this.Low,

  });

  factory MarketData.fromJson(Map<String, dynamic> json) {
    var bidsJson = json['Bids'] as List;
    var AsksJson = json['Asks'] as List;
    List<Bid> bidsList = bidsJson.map((i) => Bid.fromJson(i)).toList();
    List<Asks> AsksList = AsksJson.map((i) => Asks.fromJson(i)).toList();

    return MarketData(
      price: json['Touchline']['LastTradedPrice'].toString() ?? '0',
      percentChange:
          json['Touchline']['PercentChange'].toStringAsFixed(2) ?? '0',
      close: json['Touchline']['Close'].toString() ?? '0',
      totalBuyQuantity: json['Touchline']['TotalBuyQuantity'].toString() ?? '0',
      totalSellQuantity: json['Touchline']['TotalSellQuantity'].toString() ?? '0',
      Open: json['Touchline']['Open'].toString() ?? '0',
      High: json['Touchline']['High'].toString() ?? '0',
      Low: json['Touchline']['Low'].toString() ?? '0',

      bids: bidsList,
      asks: AsksList,
    );
  }
}

class Bid {
  final double size;
  final double price;
  final int totalOrders;
  final int buyBackMarketMaker;

  Bid({
    required this.size,
    required this.price,
    required this.totalOrders,
    required this.buyBackMarketMaker,
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      size: json['Size'].toDouble(),
      price: json['Price'].toDouble(),
      totalOrders: json['TotalOrders'],
      buyBackMarketMaker: json['BuyBackMarketMaker'],
    );
  }
}

class Asks {
  final double size;
  final double price;
  final int totalOrders;
  final int buyBackMarketMaker;

  Asks({
    required this.size,
    required this.price,
    required this.totalOrders,
    required this.buyBackMarketMaker,
  });

  factory Asks.fromJson(Map<String, dynamic> json) {
    return Asks(
      size: json['Size'].toDouble(),
      price: json['Price'].toDouble(),
      totalOrders: json['TotalOrders'],
      buyBackMarketMaker: json['BuyBackMarketMaker'],
    );
  }
}

class InstrumentMarketData {
  final String price;
  final String percentChange;
  String timestamp;

  InstrumentMarketData(
      {required this.price,
      required this.timestamp,
      required this.percentChange});

  factory InstrumentMarketData.fromJson(Map<String, dynamic> json) {
    return InstrumentMarketData(
      price: json['Touchline']['LastTradedPrice'].toString() ?? '0',
      percentChange: json['Touchline']['PercentChange'].toString() ?? '0',
      timestamp: json['Touchline']['PercentChange'].toString() ?? '0',
    );
  }
}

class MarketFeedSocket extends ChangeNotifier {
  IO.Socket? _socket;
  final marketSubscribedDataStreamController =
      StreamController<MarketData>.broadcast();

  Stream<MarketData> get marketDataStream =>
      marketSubscribedDataStreamController.stream;

  Map<int, MarketData> bankmarketData = {};

  Map<int, MarketData> marketDataMap = {};
  Map<int, MarketData> SubscribedmarketData = {}; //// Define the property here
  Map<int, InstrumentMarketData> instrumentmarketData = {};
  IO.Socket get socket {
    if (_socket == null) {
      print("object");
      throw Exception("Socket has not been initialized. Call connect first.");
    }
    return _socket!;
  }

  Future<void> connect() async {
    print("Connecting to MarketData...");
    String? token = await getToken();

    String url =
        'http://14.97.72.10:3000/?token=$token&userID=A0031&publishFormat=JSON&broadcastMode=Full&apiType=APIMARKETDATA';

    _socket = IO.io(
      url,
      IO.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .setQuery({
            'token': token,
            'userID': 'A0031',
            'publishFormat': 'JSON',
            'broadcastMode': 'Full',
          })
          .setPath('/apimarketdata/socket.io')
          // .enableAutoConnect() // disable auto-connection
          .build(),
    );

    socket.onConnect((_) {
      print('Connected to MarketData ' '');
      try {
        //      ApiService().MarketInstrumentSubscribe(1.toString(), 26000.toString());
        // ApiService().MarketInstrumentSubscribe(1.toString(), 26001.toString());
        // ApiService().MarketInstrumentSubscribe(1.toString(), 26002.toString());
        // ApiService().MarketInstrumentSubscribe(1.toString(), 26003.toString());
        // ApiService().MarketInstrumentSubscribe(1.toString(), 26004.toString());
        // ApiService().MarketInstrumentSubscribe(1.toString(), 26005.toString());
        print("succesdded");
      } catch (e) {}
      ; // Dispatch MarketDataSubscribed event
    });

    socket.on('error', (data) => print('Socket Error: $data'));

    socket.on('disconnect', (error) {
      print('Disconnected from socket: $error');
      // Add error handling here (e.g., display error message, retry)
    });

    void handle501Data(data) {
      final jsonData = jsonDecode(data);
      print(jsonData);
      final id =
          jsonData['ExchangeInstrumentID'] as int; // Assumed to be present
      final newData = MarketData.fromJson(jsonData);
      bankmarketData[id] = newData;
      marketDataMap[id] = newData;

      //print(jsonData);
      if (id == 16000) {
        SubscribedmarketData[id] = newData;
      }
      // final newsData = InstrumentMarketData.fromJson(jsonData);
      // instrumentmarketData[id] = newsData ;
      // print(instrumentmarketData);
      marketSubscribedDataStreamController.add(newData);

      notifyListeners();
    }

    void handleData(data) {
      final jsonData = jsonDecode(data);
      //print(jsonData);
      final id =
          jsonData['ExchangeInstrumentID'] as int; // Assumed to be present
      final newData = MarketData.fromJson(jsonData);
      bankmarketData[id] = newData;
      marketDataMap[id] = newData;

      //print(jsonData);
      if (id == 16000) {
        SubscribedmarketData[id] = newData;
      }
      // final newsData = InstrumentMarketData.fromJson(jsonData);
      // instrumentmarketData[id] = newsData ;
      // print(instrumentmarketData);
      marketSubscribedDataStreamController.add(newData);

      notifyListeners();
    }

    MarketData? getDataById(int id) {
      return marketDataMap[id];
    }

    void dispose() {
      marketSubscribedDataStreamController.close();
    }

    _socket?.on('1502-json-full', handleData);
    _socket?.on('1501-json-full', handle501Data);
  }

  void dispose() {
    _socket?.disconnect();
    super.dispose();
  }

  MarketData? getDataById(int id) {
    return marketDataMap[id];
  }
}
