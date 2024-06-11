import 'package:flutter/material.dart';

class MarketWatchManager extends ChangeNotifier {
  // Any state that needs to be shared or updated
  void refreshMarketWatch() {
    // Implement your refresh logic here, for example, fetching new data
    notifyListeners(); // Notify all listeners about the change.
  }
}