import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectorInFocusScreen extends StatefulWidget {
  final String sectorValue;
  SectorInFocusScreen({required this.sectorValue});

  @override
  State<SectorInFocusScreen> createState() => _SectorInFocusScreenState(
      sectorValue); // Pass the selected sector to the state class

}

class _SectorInFocusScreenState extends State<SectorInFocusScreen> {
  final items = [
    'IT-softwares',
    'Finance/NBFC',
    'Textile',
    'Chemicals',
    'Pharma',
    'FMCG',
    'Iron and Steel',
    'Capital Goods',
    'Cement',
    'Power',
    'Oil Exploration/Refineries',
    'Private Banks',
    'Consumer Durables',
    'Others',
  ];
 
 String selectedItem;

  _SectorInFocusScreenState(this.selectedItem);

  @override
  Widget build(BuildContext context) {
  void setState(VoidCallback fn) {
selectedItem = widget.sectorValue;
    
  }
    return Scaffold(
      appBar: AppBar(
        title: Text('Sector In Focus'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: items.map((item) {
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                         super.setState(() {
                            selectedItem = item;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: selectedItem == item
                                ? Colors.blue
                                : Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                            child: Text(
                              item,
                              style: TextStyle(
                                  color: selectedItem == item
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 7), // Add space between items
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'IRCTC',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '674.45',
                      style: TextStyle(color: Colors.green),
                    ),
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Indian Railway Ctrng nd Trsm Corp Ltd", style: TextStyle(color: Colors.black54)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '+4.45(+2.32%)',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PAYTM',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    Text(
                      '674.45',
                      style: TextStyle(color: Colors.red),
                    ),
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Paytm Ltd", style: TextStyle(color: Colors.black54)),
                Row(
                  children: [
                    Text(
                      '-4.45(+2.32%)',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NBCC',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    Text(
                      '64.45',
                      style: TextStyle(color: Colors.green),
                    ),
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('NBCC (India) Ltd', style: TextStyle(color: Colors.black54)),
                Row(
                  children: [
                    Text(
                      '+4.45(+2.32%)',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TATA MOTORS',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    Text(
                      '237',
                      style: TextStyle(color: Colors.red),
                    ),
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tata Motors Ltd Fully Paid Ord. Shrs', style: TextStyle(color: Colors.black54)),
                Row(
                  children: [
                    Text(
                      '-4.45(-2.32%)',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'IRFC',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    Text(
                      '789.45',
                      style: TextStyle(color: Colors.green),
                    ),
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Indian Railway Finance Corp Ltd",
                  style: TextStyle(color: Colors.black54),
                ),
                Row(
                  children: [
                    Text(
                      '+56(+6.32%)',
                      style: TextStyle(color: Colors.green),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
