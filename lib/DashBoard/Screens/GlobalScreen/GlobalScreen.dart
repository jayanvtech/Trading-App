import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Globalscreen extends StatefulWidget {
  const Globalscreen({super.key});

  @override
  State<Globalscreen> createState() => _GlobalscreenState();
}

class _GlobalscreenState extends State<Globalscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
          "Indices",
          style: GoogleFonts.inter(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          sectorIndices(),
        ],
      ),
    );
  }

  Widget sectorIndices(){
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: 50,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nifty Bank",
                                  style: GoogleFonts.inter(
                                      color: Colors.black, fontSize: 13),
                                ),
                                Text(
                                  "NSE",
                                  style: GoogleFonts.inter(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "49999.00",
                                  style: GoogleFonts.inter(
                                      color: Colors.green.shade800, fontSize: 13),
                                ),
                                Text(
                                  "+1557.14 (+4.79%)",
                                  style: GoogleFonts.inter(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
