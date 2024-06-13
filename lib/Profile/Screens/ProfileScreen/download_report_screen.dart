import 'dart:convert';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DownloadReportsScreen extends StatefulWidget {
  const DownloadReportsScreen({super.key});

  @override
  State<DownloadReportsScreen> createState() => _DownloadReportsScreenState();
}


class _DownloadReportsScreenState extends State<DownloadReportsScreen> {
  String? selectedItem = 'PnL Summary';
  bool isLoading = false;
  bool isVisible = false;
  final List<String> items = [
    'PnL Summary',
    'Ledger',
    'F&O',
    'Equity',
  ];
  DateTime fromDate = DateTime.now().subtract(Duration(days: 4));
  DateTime toDate = DateTime.now();


  String? selectedYear = "Apr 2024 - March 2025";
  List<String> financialYears = [
    "Apr 2024 - March 2025",
    "Apr 2023 - March 2024",
    "Apr 2022 - March 2023",
    "Apr 2021 - March 2022",
    "Apr 2020 - March 2021"
  ];
  TextEditingController financialYearsController = TextEditingController();


  @override
  void initState() {
    super.initState();
    financialYearsController.text = selectedYear.toString();
  }


  Future<void> selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? fromDate : toDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isFromDate ? fromDate : toDate))
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Download Reports'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(selectedItem!),
                  trailing: isVisible
                      ? Icon(Icons.arrow_drop_down)
                      : Icon(Icons.arrow_drop_up),
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                )),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: isVisible,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GestureDetector(
                        child: Text(items[index]),
                        onTap: () {
                          setState(() {
                            selectedItem = items[index];
                            isVisible = false;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // TextFormField(
            //   readOnly: true,
            //   controller: TextEditingController(
            //       text: DateFormat('yyyy-MM-dd').format(fromDate)),
            //   decoration: InputDecoration(
            //     suffixIcon: Icon(Icons.calendar_month_outlined),
            //     labelText: 'From Date',
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            //   onTap: () => selectDate(context, true),
            // ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: true,
              controller: TextEditingController(
                text: financialYearsController.text,
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.calendar_month_outlined),
                labelText: 'Financial Year',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () => _showBottomSheet(context, updateYear),
            ),
            SizedBox(
              height: 10,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    downloadFile();
                  },
                  child: isLoading
                      ? Container(
                      height: 20,
                      width: 20,
                      child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          )))
                      : Text('Download'),
                ),
                // ElevatedButton(style: ButtonStyle(
                //   backgroundColor: MaterialStateProperty.all(Colors.blue),
                // ),
                //   onPressed: () {},
                //   child: Text('Download'),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Future<File> downloadFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      var headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      };
      var request = http.Request(
          'POST',
          Uri.parse(
              'http://192.168.130.43:1818/v1/user/report/pnl?source=trading_app'));
      request.body = json.encode({
        "download_type": "PDF",
        "type": GetReportType(selectedItem),
        "client_code": "A0044",
        "year": int.parse(GetFinacialYear(selectedYear)),
      });
      request.headers.addAll(headers);


      http.StreamedResponse response = await request.send();


      if (response.statusCode == 200) {
        var bytes = await response.stream.toBytes();
        Directory dir = (await getApplicationDocumentsDirectory());
        String newPath = '';
        if (Platform.isAndroid) {
          newPath = '${dir.path}/Download';
        } else if (Platform.isIOS) {
          newPath = '${dir.path}';
        }
        File file = new File('$newPath/report.pdf');
        setState(() {
          isLoading = false;
        });
        OpenFile.open(file.path);
        await file.writeAsBytes(bytes);
        print('File downloaded to $newPath');


        return file;
      } else if (response.statusCode == 404) {
        setState(() {
          isLoading = false;
        });


        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No data found for the selected year'),
          ),
        );


        return File('404');
      } else {
        throw Exception('Failed to load file');
      }
    } catch (e) {
      print(e);
      return File(e.toString());
    }
  }


  String GetReportType(selectedItem) {
    switch (selectedItem) {
      case "PnL Summary":
        return 'pnl';
      case "Ledger":
        return 'ledger';
      case "F&O":
        return 'fno';
      case "Equity":
        return 'eq';


      default:
        return 'Unknown';
    }
  }


  String GetFinacialYear(selectedYear) {
    switch (selectedYear) {
      case "Apr 2024 - March 2025":
        return '2024';
      case "Apr 2023 - March 2024":
        return '2023';
      case "Apr 2022 - March 2023":
        return '2022';
      case "Apr 2021 - March 2022":
        return '2021';
      case "Apr 2020 - March 2021":
        return '2020';


      default:
        return 'Unknown';
    }
  }


  void _showBottomSheet(BuildContext context, Function(String) updateYear) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 400,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(0),
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: financialYears.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ListTile(
                            trailing: selectedYear == financialYears[index]
                                ? Icon(Icons.check)
                                : null,
                            title: Text(financialYears[index]),
                            onTap: () {
                              setState(() {
                                selectedYear = financialYears[index];
                              });
                              updateYear(financialYears[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        foregroundColor:
                        MaterialStateProperty.all(Colors.white),
                      ),
                      child: Text('Done'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }


  void updateYear(String year) {
    setState(() {
      financialYearsController.text = year;
    });
  }
}

