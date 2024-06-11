import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class IPOsScreen extends StatefulWidget {
  const IPOsScreen({super.key});

  @override
  State<IPOsScreen> createState() => _IPOsScreenState();
}

class _IPOsScreenState extends State<IPOsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "IPOs",
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
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
                Tab(text: 'Open & Upcoming'),
                Tab(text: 'IPO Orders'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: firstTab(),
          ),
          secondTab(),
        ],
      ),
    );
  }

  Widget openIPOsList() {
    return ListView.builder(
      itemCount: 6,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            color: Colors.white,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://media.licdn.com/dms/image/D4D0BAQHrd9iWk6XR0g/company-logo_200_200/0/1662712203438/kronox_lab_sciences_pvt_ltd_logo?e=2147483647&v=beta&t=MRZBBB6zLZOrQYhbLGmv-M55MlKk-K9_ElCTKw-GQxo"),
                                          fit: BoxFit.cover),
                                      border: Border.all(
                                          color: Colors.grey.shade800
                                              .withOpacity(0.1))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Kronox Lab Science Ltd",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        text: 'Closed on ',
                                        style: GoogleFonts.inter(
                                            color: Colors.black, fontSize: 10),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '05 Jun 2024',
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                          TextSpan(
                                            text: ' . ',
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                          TextSpan(
                                            text: 'Min Inv ',
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontSize: 10),
                                          ),
                                          TextSpan(
                                            text: '₹ 14,190.00',
                                            style: GoogleFonts.inter(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          height: 15,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(05),
                                              color: Colors
                                                  .deepPurpleAccent.shade700
                                                  .withOpacity(0.1)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Text(
                                              "MAINBOARD IPO",
                                              style: GoogleFonts.inter(
                                                  color: Colors.deepPurple,
                                                  fontSize: 09),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Visibility(
                                          visible: index == 0,
                                          child: Container(
                                            height: 15,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(05),
                                                color: Colors.redAccent.shade700
                                                    .withOpacity(0.1)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.av_timer_rounded,
                                                    color: Colors.red,
                                                    size: 12,
                                                  ),
                                                  Text(
                                                    "CLOSING TODAY",
                                                    style: GoogleFonts.inter(
                                                        color: Colors.red,
                                                        fontSize: 09),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(05),
                                  color: Colors.grey.shade800.withOpacity(0.1)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(05),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Center(
                                          child: Text(
                                            "DAY 3",
                                            style: GoogleFonts.inter(
                                                color: Colors.blue,
                                                fontSize: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Subscription Status",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.275,
                                    ),
                                    Text(
                                      "24.58x",
                                      style: GoogleFonts.inter(
                                          color: Colors.green, fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget upcomingIPOs() {
    return ListView.builder(
      itemCount: 6,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          child: Card(
            color: Colors.white,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://media.licdn.com/dms/image/D4D0BAQHrd9iWk6XR0g/company-logo_200_200/0/1662712203438/kronox_lab_sciences_pvt_ltd_logo?e=2147483647&v=beta&t=MRZBBB6zLZOrQYhbLGmv-M55MlKk-K9_ElCTKw-GQxo"),
                                          fit: BoxFit.cover),
                                      border: Border.all(
                                          color: Colors.grey.shade800
                                              .withOpacity(0.1))),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "BOAT",
                                      style: GoogleFonts.inter(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Dates to be announced soon",
                                      style: GoogleFonts.inter(
                                        color: Colors.black,
                                        fontSize: 9,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      height: 15,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(05),
                                          color: Colors
                                              .deepPurpleAccent.shade700
                                              .withOpacity(0.1)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Text(
                                          "MAINBOARD IPO",
                                          style: GoogleFonts.inter(
                                              color: Colors.deepPurple,
                                              fontSize: 09),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget firstTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: [
                  Text(
                    "Open IPOs",
                    style: GoogleFonts.inter(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 20,
                    width: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red),
                    child: Center(
                      child: Text(
                        "3",
                        style:
                            GoogleFonts.inter(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "Subscription status updated 15 mins ago",
                  style: GoogleFonts.inter(color: Colors.grey, fontSize: 11),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: openIPOsList()),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming IPOs",
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 20,
                  width: 25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5), color: Colors.red),
                  child: Center(
                    child: Text(
                      "5",
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: upcomingIPOs()),
          ],
        ),
      ),
    );
  }

  Widget secondTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Column(
        children: [
          Image(image: AssetImage("assets/done.png"),height: 150,width: 150,),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You have no IPO orders",style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600
              ),)
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _tabController.index = 0;
                  });
                },
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Colors.blue)
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("CHECK FOR OPEN & UPCOMING IPOs",style: GoogleFonts.inter(
                        color: Colors.blue,
                        fontSize: 13,
                        fontWeight: FontWeight.w500
                      ),),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
