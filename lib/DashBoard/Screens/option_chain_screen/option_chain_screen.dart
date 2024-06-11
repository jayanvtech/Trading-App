import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OptionChainScreen extends StatefulWidget {
  const OptionChainScreen({super.key});

  @override
  State<OptionChainScreen> createState() => _OptionChainScreenState();
}

class _OptionChainScreenState extends State<OptionChainScreen> {
  bool isAppBarValueSelected = false;
  String text = "LTP";

  var items = [
    '28 Aug 2024',
    '27 Aug 2024',
    '26 Aug 2024',
    '25 Aug 2024',
    '24 Aug 2024',
    '23 Aug 2024',
    '22 Aug 2024',
    '21 Aug 2024',
    '20 Aug 2024',
  ];

  String dropdownValue = '29 Aug 2024';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bar_chart,
                          color: Colors.blue,
                        ),
                        Text(
                          "CHARTS",
                          style: GoogleFonts.inter(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add_rounded,
                          color: Colors.blue,
                        ),
                        Text(
                          "ORDERS",
                          style: GoogleFonts.inter(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
      appBar: AppBar(
        leadingWidth: 35,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_rounded,
                color: Colors.black,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Container(
                      height: 30,
                      width: 166.33,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.shade800.withOpacity(0.3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                text = "";
                                text = "LTP";
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 53.33,
                              decoration: BoxDecoration(
                                  color: text == "LTP"
                                      ? Colors.blue
                                      : Colors.transparent),
                              child: Center(
                                child: Text(
                                  "LTP",
                                  style: GoogleFonts.inter(
                                      color: text == "LTP"
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: text != "LTP" && text != "OI",
                            child: Text(
                              "|",
                              style: GoogleFonts.inter(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                text = "";
                                text = "OI";
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 53.33,
                              decoration: BoxDecoration(
                                  color: text == "OI"
                                      ? Colors.blue
                                      : Colors.transparent),
                              child: Center(
                                child: Text(
                                  "OI",
                                  style: GoogleFonts.inter(
                                      color: text == "OI"
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: text != "OI" && text != "Greeks",
                            child: Text(
                              "|",
                              style: GoogleFonts.inter(
                                  color: Colors.black, fontSize: 12),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                text = "";
                                text = "Greeks";
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 53.33,
                              decoration: BoxDecoration(
                                  color: text == "Greeks"
                                      ? Colors.blue
                                      : Colors.transparent),
                              child: Center(
                                child: Text(
                                  "Greeks",
                                  style: GoogleFonts.inter(
                                      color: text == "Greeks"
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTapDown: (TapDownDetails details) {
                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject()! as RenderBox;
                        final RelativeRect position = RelativeRect.fromRect(
                          Rect.fromPoints(
                              details.globalPosition, details.globalPosition),
                          Offset.zero & overlay.size,
                        );
                        showMenu(
                            context: context,
                            position: position,
                            items: items.map((String item) {
                              return PopupMenuItem<String>(
                                value: item,
                                onTap: () {
                                  setState(() {
                                    dropdownValue = '';
                                    dropdownValue = item;
                                  });
                                },
                                child: Text(item),
                              );
                            }).toList());
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade800.withOpacity(0.3))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                dropdownValue,
                                style: GoogleFonts.inter(
                                    color: Colors.black, fontSize: 10),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 18,
                                width: 16,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.blueAccent.withOpacity(0.3)),
                                child: Center(
                                  child: Text(
                                    "M",
                                    style: GoogleFonts.inter(
                                        color: Colors.blueGrey, fontSize: 9),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              PopupMenuButton<String>(
                                onSelected: (String newValue) {
                                  setState(() {
                                    dropdownValue = '';
                                    dropdownValue = newValue;
                                  });
                                },
                                itemBuilder: (BuildContext context) {
                                  return items.map((String item) {
                                    return PopupMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    );
                                  }).toList();
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 0.5,
              )
            ],
          ),
        ),
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  "NIFTY",
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "21000.00",
                  style: GoogleFonts.inter(color: Colors.green, fontSize: 14),
                ),
                Icon(
                  Icons.arrow_drop_up,
                  color: Colors.green,
                  size: 15,
                ),
                Text(
                  "+1379.40(+5.93%)",
                  style: GoogleFonts.inter(color: Colors.black, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Call LTP",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Strike Price",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "Put LTP",
                style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Divider(
            thickness: 0.5,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "₹50.60",
                                style: GoogleFonts.inter(
                                    color: Colors.red, fontSize: 11),
                              ),
                              Text(
                                "-51.81%",
                                style: GoogleFonts.inter(
                                    color: Colors.red.shade800, fontSize: 10),
                              ),
                            ],
                          ),
                          SizedBox(),
                          Text(
                            "380",
                            style: GoogleFonts.inter(
                                color: Colors.black, fontSize: 11),
                          ),
                          SizedBox(),
                          Column(
                            children: [
                              Text(
                                "₹5.80",
                                style: GoogleFonts.inter(
                                    color: Colors.green, fontSize: 11),
                              ),
                              Text(
                                "+1557.14%",
                                style: GoogleFonts.inter(
                                    color: Colors.red.shade800, fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider()
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
