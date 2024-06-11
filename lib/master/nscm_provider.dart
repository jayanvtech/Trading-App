import 'package:flutter/material.dart';
import 'package:tradingapp/master/apiservice.dart';
import 'package:tradingapp/master/nscm.dart';
import 'package:tradingapp/master/nscm_database.dart';

class NscmDataProvider with ChangeNotifier {
  List<NscmData> _niftyData = [];

  List<NscmData> get niftyData => _niftyData;

  Future<void> fetchAndStoreData() async {
    try {
      final data = await fetchNiftyData();
      await NscmDatabase().insertNscmData(data);
      _niftyData = data;
     print(data);
      notifyListeners();
    } catch (e) {
      print('Error fetching and storing data: $e');
    }
  }

  Future<void> updateData() async {
    try {
      final data = await fetchNiftyData();
      await NscmDatabase().updateNscmData(data);
      _niftyData = data;
      notifyListeners();
    } catch (e) {

        print('Error updating data: $e');
      }
    }
  }