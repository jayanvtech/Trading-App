import 'dart:math';

import 'package:tradingapp/master/nscm.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
Future<List<NscmData>> fetchNiftyData() async {
  // Replace with your actual API endpoint and headers
  final response = await http.post(
    Uri.parse('http://192.168.102.251:5001/v1/dbcontractEQ'),
    headers: {
      'AuthToken': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiamF5M2NoYXVoYW4iLCJleHAiOjE3MTYwNDIzNTh9.hyK8qwA7MJhTj58WKLG7WkZmXjkNNSDgza-CtHOiO4I',
      'Content-Type': 'application/json',
    },
  );
  print(response.statusCode);
print(response.body);

  if (response.statusCode == 200) {
    var data = json.decode(response.body);

    if (response.statusCode==200) {
   
     final dafa=( data['data'] as List).map((item) => NscmData.fromJson(item)).toList();

      return dafa;
    } else {
       print("Data retrieval $e success but no results");
      throw Exception(e);
      return [];
    }
  } else {
    print("Data retrieval failed: ${response.statusCode}");
    throw Exception('Failed to load data');
  }
}
