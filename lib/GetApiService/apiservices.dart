import 'dart:convert';
import 'dart:math';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tradingapp/Authentication/auth_services.dart';
import 'package:tradingapp/Screens/Mainscreens/Dashboard/FII/DII/fii_dii_screen.dart';
import 'package:tradingapp/model/profile_model.dart';
import 'package:tradingapp/model/trade_balance_model.dart';
import 'package:tradingapp/model/userProfile_model.dart';

class ApiService {
  final String baseUrl = "http://14.97.72.10:3000";

  Future<List<dynamic>> searchInstruments(String query) async {
    print("Search called with query: $query");

    // Return early if the search query is too short
    if (query.length < 2) {
      print("Query too short");
      return [];
    }

    // Obtain the token
    final String? apiToken = await getToken();
    if (apiToken == null) {
      print("API Token is null");
      throw Exception('Authentication token is not available.');
    }

    try {
      final response = await http.get(
          Uri.parse(
              '$baseUrl/apimarketdata/search/instruments?searchString=$query'),
          headers: {
            'Authorization':
                '$apiToken', // Correctly format the authorization header
            'Content-Type': 'application/json'
          });

      // print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          return data['result'];
        } else {
          print("Data retrieval success but no results");
          return [];
        }
      } else if (response.statusCode == 401) {
        throw Exception(
            'Unauthorized: Please check your credentials or token validity.');
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found: Please check the URL.');
      } else {
        throw Exception(
            'Failed to load instruments with status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception caught: $e");
      rethrow;
    }
  }

  Future<dynamic> GetBhavCopy(
      String exchangeInstrumentID, String exchangeSegment) async {
    final String? apiToken = await getToken();
    if (apiToken == null) {
      throw Exception('Authentication token is not available.');
    }

    try {
      var headers = {
        'Authorization': apiToken,
        'Content-Type': 'application/json'
      };
      var body = json.encode({
        "source": "WebAPI",
        "instruments": [
          {
            "exchangeSegment": exchangeSegment,
            "exchangeInstrumentID": exchangeInstrumentID
          }
        ]
      });

      var response = await http.post(
        Uri.parse(
            'http://14.97.72.10:3000/apimarketdata/search/instrumentsbyid'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          final closeValue = data['result'][0]['Bhavcopy']['Close'];

          return closeValue.toString();
        } else {
          print("Data retrieval success but no resultsin Bhavcopy");
          return "0";
        }
      } else if (response.statusCode == 401) {
        throw Exception(
            'Unauthorized: Please check your credentials or token validity.');
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found: Please check the URL.');
      } else {
        throw Exception(
            'Failed to load instruments with status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception caught: $e");
      rethrow;
    }
  }

  Future<dynamic> MarketInstrumentSubscribe(
      String exchangeSegment, String exchangeInstrumentID) async {
    String? apiToken = await getToken();
    try {
      final body = json.encode({
        "instruments": [
          {
            "exchangeSegment": exchangeSegment,
            "exchangeInstrumentID": exchangeInstrumentID
          }
        ],
        "xtsMessageCode": 1502
      });

      final response = await http.post(
        Uri.parse('$baseUrl/apimarketdata/instruments/subscription'),
        body: body,
        headers: {
          'Authorization': '$apiToken',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        print("Data retrieval success but no  results In Subscribe API");
        return "0";
      }
    } catch (e) {
      print("Exception caught In Subscribe API : $e");
      rethrow;
    }
  }

  Future<dynamic> UnsubscribeMarketInstrument(
      String exchangeSegment, String exchangeInstrumentID) async {
    String? apiToken = await getToken();
    try {
      final body = json.encode({
        "instruments": [
          {
            "exchangeSegment": exchangeSegment,
            "exchangeInstrumentID": exchangeInstrumentID
          }
        ],
        "xtsMessageCode": 1502
      });
      final response = await http.put(
        Uri.parse('$baseUrl/apimarketdata/instruments/subscription'),
        body: body,
        headers: {
          'Authorization': '$apiToken',
          'Content-Type': 'application/json'
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("Unsubscribed");
        return true;
      } else {
        print("Data retrieval success but no results");
        return "0";
      }
    } catch (e) {
      print("Exception caught: $e");
      rethrow;
    }
  }

  Future<Map<String, Map<String, double>>> fetchFiiDiiDetails() async {
    try {
      print("fetchFiiDiiDetails called");
      final response = await http.post(Uri.parse(
              // 'https://api.sensibull.com/v1/fii_dii_details_v2?year_month=2024-May'
              'http://192.168.130.48:9010/v1/get_fii_history_data/'),
          body: jsonEncode(
            {},
          ),
          headers: {
            'Content-Type': 'application/json',
            'accept': 'application/json',
          });
//  'http://192.168.130.48:9010/v1/get_fii_history_data/'
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        Map<String, Map<String, double>> result = {};
        final jsonData = jsonDecode(response.body);
        final successData = jsonData['success'];
        final data = successData['data'];

        data.forEach((key, value) {
          final cashFii = value['cash']['fii'];
          final cashDii = value['cash']['dii'];
          final fnoFiiquantitywise = value['future']['fii'];
          final fnoDiiAmountwise = value['future']['fii']['amount-wise'];
          final fiiBuySellDifference = cashFii['buy_sell_difference'];
          final diiBuySellDifference = cashDii['buy_sell_difference'];

// print('Date: $date');

          result[key] = {
            'fii_buy_sell_difference': fiiBuySellDifference,
            'dii_buy_sell_difference': diiBuySellDifference,
          };
        });

        return result;
      } else
        return throw Exception('Failed to load data IN FII DII');
    } catch (e) {
      throw Exception('Failed to load data IN FII DII');
      // print("Exception caught in FII DII API: $e");
    }
  }

  Future<Map<String, dynamic>> fetchFiiDiiDetailsMonthly() async {
    final response = await http.get(Uri.parse(
        'http://192.168.130.48:9010/v1/get_fii_data_cash_fo_index_stocks/?type=cash'));
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load FII/DII data');
    }
  }

  Future<dynamic> GetNSCEMMaster() async {
    String? apiToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiamF5M2NoYXVoYW4iLCJleHAiOjE3MTU3ODM4NjB9.YxaJvTtjvMf_cNr9yYg1g16M7TYEb7onWae4b8IH37M";
    try {
      final response = await http.post(
        Uri.parse('http://192.168.102.251:5001/v1/dbcontractEQ'),
        headers: {'AuthToken': '$apiToken', 'Content-Type': 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['type'] == 'success' && data['data'] != null) {
          print("Datagotit");

          return data['data'];
        } else {
          print("Data retrieval success but no results");
          return "0";
        }
      } else {
        print("Data retrieval success but no results");
        return "0";
      }
    } catch (e) {
      print("Exception caught: $e");
      rethrow;
    }
  }

  Future<dynamic> GetPosition() async {
    String? apiToken = await getToken();
    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/portfolio/positions?dayOrNet=dayWise&clientID=A0031&userID=A0031'),
        headers: {
          'Authorization': '$apiToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          for (var item in data['result']['positionList']) {}
          return data['result']['positionList'];
        } else {
          print("Data retrieval success but no results in GetPosition");
          return [];
        }
      } else {
        print("Data retrieval success but no results in GetPosition");
        return [];
      }
    } catch (e) {
      print("Exception caughdddt: $e");
      return [];
    }
  }

  Future<dynamic> GetTrades() async {
    String? apiToken = await getToken();
    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/orders/trades?clientID=A0031&userID=A0031'),
        headers: {
          'Authorization': '$apiToken',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          for (var item in data['result']) {}
          return data['result'];
        } else {
          print("Data retrieval success but no results in GetPosition");
          return [];
        }
      } else {
        print("Data retrieval success but no results in GetPosition");
        return [];
      }
    } catch (e) {
      print("Exception caught: $e");
      return [];
    }
  }

  Future<dynamic> GetOrder() async {
    String? apiToken = await getToken();

    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/orders?clientID=A0031&userID=A0031'),
        headers: {
          'Authorization': '$apiToken',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          for (var item in data['result']) {}
          return data['result'];
        } else {
          print("Data retrieval success but no results in GetOrder");
          return [];
        }
      } else {
        print("Data retrieval success but no results in GetOrder");
        return [];
      }
    } catch (e) {
      print("Exception caught: $e");
      return [];
    }
  }

  Future<dynamic> GetOrderHistroy() async {
    String? apiToken = await getToken();

    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/reports/trade?clientID=A0031&userID=A0031&exchangeSegment=NSEFO&fromDate=2024-05-21&toDate=2024-05-31'),
        headers: {
          'Authorization': '$apiToken',
          'Content-Type': 'application/json'
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          for (var item in data['result']['tradeReportList']) {}
          return data['result']['tradeReportList'];
        } else {
          print("Data retrieval success but no results in GetOrderHistroy");
          return [];
        }
      } else {
        print("Data retrieval success but no results in GetOrderHistroy");
        return [];
      }
    } catch (e) {
      print("Exception caught: $e");
      return [];
    }
  }

  Future<dynamic> GetHoldings() async {
    String? apiToken = await getToken();
    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/portfolio/holdings?userID=A0031&clientID=A0031'),
        headers: {
          'Authorization': '$apiToken',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          for (var item in data['result']['holdingsList']) {}
          return data['result']['holdingsList'];
        } else {
          print("Data retrieval success but no results in holdingsList");
          return [];
        }
      } else {
        print("Data retrieval success but no results in ");
        return [];
      }
    } catch (e) {
      print("Exception caught: $e");
      return [];
    }
  }

  Future<dynamic> GetInstrumentByID(
      String exchangeInstrumentID, String exchangeSegment) async {
    final String? apiToken = await getToken();
    if (apiToken == null) {
      throw Exception('Authentication token is not available.');
    }

    try {
      var headers = {
        'Authorization': apiToken,
        'Content-Type': 'application/json'
      };
      var body = json.encode({
        "source": "WebAPI",
        "instruments": [
          {
            "exchangeSegment": exchangeSegment,
            "exchangeInstrumentID": exchangeInstrumentID
          }
        ]
      });

      var response = await http.post(
        Uri.parse(
            'http://14.97.72.10:3000/apimarketdata/search/instrumentsbyid'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['type'] == 'success' && data['result'] != null) {
          return data['result'][0]["DisplayName"].toString();
        } else {
          print(
              "Data retrieval success but no resultsin SerachInsturmentBYId in portfolio");
          return "0";
        }
      } else if (response.statusCode == 401) {
        throw Exception(
            'Unauthorized: Please check your credentials or token validity.');
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint not found: Please check the URL.');
      } else {
        throw Exception(
            'Failed to load instruments with status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Exception caught in SerachInsturmentBYId: $e");
      rethrow;
    }
  }

  Future<void> placeOrder(Map<String, dynamic> orderDetails) async {
    try {
      print("tryis calling");
      final String? apiToken = await getToken();
      final response = await http.post(
        Uri.parse('http://14.97.72.10:3000/enterprise/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': apiToken.toString(),
        },
        body: jsonEncode(orderDetails),
      );
      print(response.body);
      if (response.statusCode != 200) {
        throw Exception('Failed to place order');
      } else {
        Get.snackbar('Order Placed', 'Order placed successfully');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserProfile> fetchUserProfile() async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('User is not logged in');
    }

    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/user/profile?clientID=A0031&userID=A0031'),
        headers: {
          'Authorization': token,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        return UserProfile.fromJson(jsonDecode(response.body));
      } else {
        if (response.statusCode == 401) {
          // Handle unauthorized error
          throw Exception('Unauthorized');
        }
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      // This will catch any exceptions thrown from the try block
      print('Caught error: $e');
      throw Exception('Failed to load user profile due to an error: $e');
    }
  }

  Future<Balance> GetBalance() async {
    String? token = await getToken();
    if (token == null) {
      throw Exception('User is not logged in');
    }

    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/user/balance?clientID=A0031&userID=A0031'),
        headers: {
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final balanceList = responseData['result']['BalanceList'];
        final filteredBalances = Balance.filterBalances(balanceList);
        if (filteredBalances.isEmpty) {
          throw Exception('No balance with limitHeader "ALL|ALL|ALL" found');
        }
        print("3456789876545678${filteredBalances.first}");
        return filteredBalances.first;
      } else {
        if (response.statusCode == 401) {
          throw Exception('Unauthorized');
        }
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Caught error: $e');
      throw Exception('Failed to load user profile due to an error: $e');
    }
  }

  Future<UserProfile?> fetchDUserProfile(String clientID, String userID) async {
    final String apiUrl =
        'http://14.97.72.10:3000/enterprise/user/profile?clientID=$clientID&userID=$userID';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the JSON data
        final jsonData = json.decode(response.body);
        if (jsonData['type'] == 'success') {
          // Convert JSON data to UserProfile object
          return UserProfile.fromJson(jsonData);
        } else {
          print('Error: ${jsonData['description']}');
          return null;
        }
      } else {
        print(
            'Error: Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<dynamic> GetUserProfile(String clientID, String userID) async {
    String? Token = await getToken();
    print('Token: $Token');

    try {
      final response = await http.get(
        Uri.parse(
            'http://14.97.72.10:3000/enterprise/user/profile?clientID=A0032&userID=A0032'),
        headers: {
          'Authorization': Token.toString(),
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
       if (jsonData['type'] == 'success') {
  return jsonData['result'];

     
        } else {
          final error = 'Error: ${jsonData['description']}';
          return error;
        }
      } else {
        return 'Error: Failed to fetch data. Status code: ${response.statusCode}';
      }
    } catch (error) {
      return 'Error: $error';
      
    }throw Exception('Failed to get user profile');
  }
}
