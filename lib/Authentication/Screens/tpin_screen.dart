// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tradingapp/Authentication/auth_services.dart';
import 'dart:convert';
import 'package:tradingapp/Bottom_nav_bar_screen.dart';
import 'package:tradingapp/Utils/const.dart/app_colors_const.dart';
import 'package:tradingapp/Utils/const.dart/app_images_const.dart';

class ValidPasswordScreen extends StatefulWidget {
  String? isFromMainScreen;
  String? userID;

  ValidPasswordScreen({super.key, this.userID, this.isFromMainScreen});

  @override
  State<ValidPasswordScreen> createState() => _ValidPasswordScreenState();
}

class _ValidPasswordScreenState extends State<ValidPasswordScreen> {
  String enteredPin = '';
  String userId = '';
  late TextEditingController userIDController = TextEditingController(text: widget.userID);
  final TextEditingController pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getId();
  }

  void getId() async {
    userId = await getUserId() ?? "";
  }

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextButton(
        onPressed: () async {
          setState(() {
            if (enteredPin.length < 6) {
              enteredPin += number.toString();
            }
          });
          if (enteredPin.length == 6) {
            var result = await validatePin(enteredPin);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result['message'])),
            );
          }
        },
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> validatePin(String pin) async {
    try {
      var url =
          Uri.parse('http://14.97.72.10:3000/enterprise/auth/validatepin');
      var response = await http.post(
        url,
        body: jsonEncode({
          'userID': widget.isFromMainScreen == "true" ? "${userId}" : widget.userID,
          'pin': pin.toString(),
          'source': 'EnterpriseWeb',
        }),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print(response.body);
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['type'] == 'success') {
          print(response.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (jsonResponse['result'] != null &&
              jsonResponse['result']['token'] != null) {
            storeUserId(userId: jsonResponse['result']['userID']);
            storeClientId(clientId: jsonResponse['result']['clientCodes'][0]);
            await prefs.setString('token', jsonResponse['result']['token']);
            print('Stored token: ${prefs.getString('token')}');
            Get.offAll(() => MainScreen());
          } else {
            print('Token not found in the response');
          }
          return {
            'status': true,
            'message': 'Pin validation successful',
            'data': jsonResponse['result']
          };
        }
        else {
          return {'status': false, 'message': jsonResponse['description']};
        }
      }
      else {
        if (jsonResponse['type'] == 'error') {
          return {'status': false, 'message': jsonResponse['description']};
        } else if (jsonResponse['result'] != null &&
            jsonResponse['result']['errors'] != null) {
          List errors = jsonResponse['result']['errors'];
          String errorMessage =
              errors.map((e) => e['messages'].join(' ')).join('\n');
          return {'status': false, 'message': errorMessage};
        } else {
          print(response.body);
          throw Exception('Failed to load API response');
        }
      }
    } catch (e) {
      print(e.toString());
      return {'status': false, 'message': 'Internal Server Error!'};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        leading: widget.isFromMainScreen == "true"
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 13.0, top: 25),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 15,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(ImageAssets.ValidPinIcon),
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter Your Pin",
                    style: GoogleFonts.inter(
                        color: AppColors.appCommonColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Please enter your valid pin",
                    style: GoogleFonts.inter(
                      color: AppColors.textGreyColor,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     Text(
              //       "User ID",
              //       style: GoogleFonts.inter(
              //         color: AppColors.textBlackColor,
              //         fontSize: 15,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CustomTextFormField(
              //   controller: userIDController,
              //   labelText: '',
              //   errorMessage: 'userid',
              //   obscureText: false,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  6,
                  (index) {
                    return Container(
                      margin: const EdgeInsets.all(6.0),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: index < enteredPin.length
                            ? AppColors.commonButtonColor
                            : Colors.black),
                        color: index < enteredPin.length
                            ? AppColors.commonButtonColor
                            : Colors.transparent,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 120,
              ),
              for (var i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => numButton(1 + 3 * i + index),
                    ).toList(),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextButton(onPressed: null, child: SizedBox()),
                    numButton(0),
                    TextButton(
                      onPressed: () {
                        setState(
                          () {
                            if (enteredPin.isNotEmpty) {
                              enteredPin = enteredPin.substring(
                                  0, enteredPin.length - 1);
                            }
                          },
                        );
                      },
                      child: const Icon(
                        Icons.backspace,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              // Row(
              //   children: [
              //     Text(
              //       "Pin",
              //       style: GoogleFonts.inter(
              //         color: AppColors.textBlackColor,
              //         fontSize: 15,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // TextFormField(
              //   keyboardType: TextInputType.text,
              //   textInputAction: TextInputAction.next,
              //   controller: pinController,
              //   decoration: InputDecoration(
              //     hintText: "1234",
              //     enabledBorder: const OutlineInputBorder(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10.0),
              //       ),
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //     border: const OutlineInputBorder(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10.0),
              //       ),
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // InkWell(
              //   onTap: () async {
              //     var result = await validatePin(
              //         userIDController.text, pinController.text);
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text(result['message'])),
              //     );
              //   },
              //   child: Container(
              //     height: 50,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: AppColors.commonButtonColor,
              //     ),
              //     child: Center(
              //       child: Text(
              //         "Validate pin",
              //         style: GoogleFonts.inter(
              //             color: AppColors.textWhiteColor,
              //             fontSize: 18),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(20.0),
      //   child: Center(
      //     child: Column(
      //       children: [
      //         TextField(
      //           controller: userIDController,
      //           decoration: const InputDecoration(
      //             labelText: 'User ID',
      //           ),
      //         ),
      //         TextField(
      //           controller: pinController,
      //           decoration: const InputDecoration(
      //             labelText: 'Pin',
      //           ),
      //         ),
      //         const SizedBox(
      //           height: 20.0,
      //         ),
      //         SizedBox(
      //           width: double.infinity,
      //           height: 50.0,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               foregroundColor: Colors.white,
      //               backgroundColor: Colors.blueAccent,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(10.0),
      //               ),
      //             ),
      //             onPressed: () async {
      //               var result = await validatePin(
      //                   userIDController.text, pinController.text);
      //               ScaffoldMessenger.of(context).showSnackBar(
      //                 SnackBar(content: Text(result['message'])),
      //               );
      //             },
      //             child: const Text('Validate Pin'),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
