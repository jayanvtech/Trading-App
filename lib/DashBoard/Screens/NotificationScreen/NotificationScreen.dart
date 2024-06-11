import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =   TabController(length: 2, vsync: this);

  List<dynamic> marketUpdates = [];

  @override
  void initState() {
    super.initState();
    _fetchMarketUpdates();
  }

  Future<void> _fetchMarketUpdates() async {
    try {
      final response = await http.get(
          Uri.parse('http://14.97.72.10:3000/enterprise/common/holidaylist'));

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);

        List<dynamic> extractedData = [];

        if (data.containsKey('result')) {
          dynamic result = data['result'];

          result.forEach((key, value) {
            List<String> holidays = List<String>.from(value['holiday']);
            List<String> workingDays = List<String>.from(value['working']);

            extractedData.add({
              'stockExchange': key,
              'holidays': holidays,
              'workingDays': workingDays,
            });
          });

          setState(() {
            marketUpdates = extractedData;
          });
        } else {
          throw Exception('Invalid data format: missing "result" key');
        }
      } else {
        throw Exception('Failed to load market updates');
      }
    } catch (e) {
      print('Error fetching market updates: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          "Notification Center",
          style: GoogleFonts.inter(color: Colors.black, fontSize: 20),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TabBar(
              indicatorColor: Colors.blue,
              controller: _tabController,
              isScrollable: true,
              splashFactory: InkRipple.splashFactory,
              labelStyle: GoogleFonts.inter(
                color: Colors.blue,
                fontSize: 14,
              ),
              tabAlignment: TabAlignment.startOffset,
              tabs: [
                Tab(text: 'Notifications'),
                Tab(text: 'Market Updates'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          notificationsTab(),
          marketUpdatesTab(),
        ],
      ),
    );
  }

  Widget notificationsTab() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: index == 0 || index == 4,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Today",
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage("assets/AppIcon/AppIcon.png"),
                          height: 20,
                          width: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "IRFC-EQ",
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 14),
                        ),
                        Spacer(),
                        Container(
                          height: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green.shade800.withOpacity(0.5)),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                "TRANSACTIONAL",
                                style: GoogleFonts.inter(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Buy IRFC-EQ open",
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 11),
                        ),
                        Spacer(),
                        Text(
                          "1 hrs",
                          style: GoogleFonts.inter(
                              color: Colors.black, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider()
            ],
          );
        },
      ),
    );
  }

  Widget marketUpdatesTab() {
    return ListView.builder(
      itemCount: marketUpdates.length,
      itemBuilder: (context, index) {
        final stockExchangeData = marketUpdates[index];
        final stockExchange = stockExchangeData['stockExchange'];
        final List<String> holidays =
            List<String>.from(stockExchangeData['holidays']);
        final List<String> workingDays =
            List<String>.from(stockExchangeData['workingDays']);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                stockExchange ?? 'Stock Exchange Name Missing',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Holidays:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: holidays.map((holiday) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 2.0),
                  child: Text(holiday),
                );
              }).toList(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Working Days:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: workingDays.map(
                (workingDay) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 2.0),
                    child: Text(workingDay),
                  );
                },
              ).toList(),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
