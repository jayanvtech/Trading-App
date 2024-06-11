import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/sqlite_database/dbhelper.dart';

class SearchScreen extends StatefulWidget {
  final VoidCallback? onReturn;

  SearchScreen({this.onReturn});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
 final ApiService _apiService = ApiService();
  List<dynamic> _searchResults = [];
  String _selectedFilter = 'ALL';
  Timer? _debounce;

  void _onSearch(String value) async {
    
   
      var results = await _apiService.searchInstruments(value);
      setState(() {
        _searchResults = results;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Instruments'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: TextField(
                onChanged: _onSearch,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            _buildFilterRow(),
            _buildResultsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _filterButton('ALL'),
        _filterButton('Cash', filterCode: 'EQ'),
        _filterButton('Future', filterCode: 'FUTIDX'),
        
        _filterButton('Option', filterCode: 'OPTSTK'),
      ],
    );
  }

  Widget _filterButton(String title, {String? filterCode ,String? filterCode1}) {
    return TextButton(
      child: Text(title),
      onPressed: () {
        setState(() {
          _selectedFilter = filterCode ?? 'ALL';
        });
      },
    );
  }

  Widget _buildResultsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          var item = _searchResults[index];
          if (_selectedFilter != 'ALL' && item['Series'] != _selectedFilter) {
            return Container(); // Do not display items that do not match the filter
          }
          return FutureBuilder<Widget>(
            future: _buildListItem(item),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data ?? Container();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }

Future<Widget> _buildListItem(Map<String, dynamic> item)async { {}
  var close = await ApiService().GetBhavCopy(
    item['ExchangeInstrumentID'].toString(),
    item['ExchangeSegment'].toString(),
  );
  
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getColorForSeries(item['Series']),
        child: Text(item['Series'] ?? 'UNK', style: TextStyle(color: Colors.white, fontSize: 10)),
      ),
      title: Text(item['Name'] ?? 'No name'),
      subtitle: Text(item['CompanyName'] ?? 'No company name'),
      trailing: IconButton(
        icon: Icon(Icons.add),
        onPressed: () => _addInstrumentToWatchlist(item['ExchangeInstrumentID'].toString(), item['Name'],item['Series'],item['ExchangeSegment'].toString(),close.toString()),
      ),
     );
  }

  Color _getColorForSeries(String? series) {
    switch (series) {
      case "FUTSTK":
        return Colors.red;
      case "OPTSTK":
        return Colors.green;
      case "EQ":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _addInstrumentToWatchlist(String exchangeInstrumentId,String displayName,String Series ,String exchangeSegment,String close) async {
    final watchlists = await DatabaseHelper.instance.fetchWatchlists();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [SizedBox(
            height: 10,
          ),
            Text("Choose a watchlist to add $displayName ",style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.bold)
                        ),
             
            Expanded(
              child: ListView.builder(
                itemCount: watchlists.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(mainAxisAlignment: MainAxisAlignment.start,
                      children: [Text(watchlists[index]['id'].toString()),
                      SizedBox(width: 10, ),
                        Text(watchlists[index]['name']),
                      ],
                    ),
                    onTap: () async {
                      await DatabaseHelper.instance.addInstrumentToWatchlist(
                        watchlists[index]['id'], exchangeInstrumentId, displayName,Series,exchangeSegment,index,close);
                        await DatabaseHelper.instance.fetchWatchlists();
                      Navigator.pop(context, true); 
                    },
                  );
                },
              ),
            ),
            if (watchlists.length < 10)
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Create new watchlist'),
                onTap: () => _createNewWatchlist(context, exchangeInstrumentId,displayName,Series,exchangeSegment,close),
              ),
          
          ],
        );
      },
    );
  }

  Future<void> _createNewWatchlist(BuildContext context, String exchangeInstrumentId,String displayName,String Series, String exchangeSegment,String close) async {
    TextEditingController _nameController = TextEditingController();
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Watchlist'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Watchlist name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () async {
                if (_nameController.text.isNotEmpty) {
                  int newWatchlistId = await DatabaseHelper.instance.addWatchlist(_nameController.text);
                  await DatabaseHelper.instance.addInstrumentToWatchlist(newWatchlistId, exchangeInstrumentId,displayName,Series,exchangeSegment,0,close);
                   
                  Navigator.of(context).pop();
               
                }
              },
            ),
          ],
        );
      },
    );
  }
}
