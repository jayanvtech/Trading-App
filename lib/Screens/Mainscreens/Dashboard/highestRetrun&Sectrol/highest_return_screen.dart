import 'package:flutter/material.dart';

class HighestReturnScreen extends StatefulWidget {
  const HighestReturnScreen({super.key});

  @override
  State<HighestReturnScreen> createState() => _HighestReturnScreenState();
}

class _HighestReturnScreenState extends State<HighestReturnScreen> {
  @override
  String? _selectedDuration; // The selected duration

  Widget build(BuildContext context) {
    List<String> durations = ['1 Week', '1 Month', '3 Months', '52 Weeks'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Highest Return'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: durations.map((String value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _selectedDuration == value
                            ? Colors.blue
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: _selectedDuration == value
                              ? Colors.white
                              : Colors.blue,
                          backgroundColor: _selectedDuration == value
                              ? Colors.blue
                              : Colors.grey[200],
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedDuration = value;
                          });
                        },
                        child: Text(value),
                      ),
                    ),
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
                Text('IRCTC',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),),
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
                Text('10.8% Return in $_selectedDuration',
                    style: TextStyle(color: Colors.black54)),
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
                Text('PAYTM',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),),
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
                Text('22.2% Return in $_selectedDuration',
                    style: TextStyle(color: Colors.black54)),
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
                Text('NBCC',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),),
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
                Text('25.9% Return in $_selectedDuration',
                    style: TextStyle(color: Colors.black54)),
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
                Text('TATA MOTORS',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),),
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
                Text('34.1% Return in $_selectedDuration',
                    style: TextStyle(color: Colors.black54)),
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
                Text('IRFC',style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400
                ),),
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
                  '56% Return in $_selectedDuration',
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
