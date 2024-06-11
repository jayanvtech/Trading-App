import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tradingapp/Utils/const.dart/app_colors_const.dart';
import 'package:tradingapp/Utils/const.dart/app_images_const.dart';
import 'package:tradingapp/Utils/const.dart/custom_textformfield.dart';

class ForgetPasswordScreen extends StatefulWidget {
  final String username;
  const ForgetPasswordScreen({super.key, required this.username});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController usernameController;
  late TextEditingController dateController;
  late TextEditingController panCardController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController = TextEditingController();
    panCardController = TextEditingController();

    usernameController = TextEditingController(text: widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 13.0,top: 25),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 15,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200
              ),
              child: Center(
                child: Icon(Icons.arrow_back,color: Colors.black,),
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
                  Image(image: AssetImage(ImageAssets.ForgetPasswordImage),height: 120,width: 120,),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    "Forget Password",
                    style: GoogleFonts.inter(
                        color: AppColors.appCommonColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Please fill these details to Forget Password",
                      style: GoogleFonts.inter(
                        color: AppColors.textGreyColor,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Username",
                    style: GoogleFonts.inter(
                      color: AppColors.textBlackColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                controller: usernameController,
                labelText: '',
                errorMessage: 'username',
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Date of Birth",
                    style: GoogleFonts.inter(
                      color: AppColors.textBlackColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.next,
                controller: dateController,
                decoration: InputDecoration(
                  hintText: "12/03/2002",
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        dateController.text =
                            DateFormat('dd-MMM-yyyy').format(date);
                      }
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Pan Number",
                    style: GoogleFonts.inter(
                      color: AppColors.textBlackColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                controller: panCardController,
                decoration: InputDecoration(
                  hintText: "FSDPP3387F",
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.commonButtonColor,
                  ),
                  child: Center(
                    child: Text(
                      "Verify",
                      style: GoogleFonts.inter(
                          color: AppColors.textWhiteColor,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // body: Padding(
      //     padding: const EdgeInsets.all(20.0),
      //     child: Column(children: [
      //       TextFormField(
      //           controller: usernameController,
      //           decoration: const InputDecoration(
      //             prefixIcon: Icon(Icons.person),
      //             labelText: 'Username',
      //           )),
      //       TextFormField(
      //         keyboardType: TextInputType.datetime,
      //         textInputAction: TextInputAction.next,
      //         controller: dateController,
      //         decoration: InputDecoration(
      //           prefixIcon: const Icon(Icons.date_range_outlined),
      //           labelText: 'Date of Birth',
      //           suffixIcon: IconButton(
      //             onPressed: () async {
      //               final date = await showDatePicker(
      //                 context: context,
      //                 initialDate: DateTime.now(),
      //                 firstDate: DateTime(1900),
      //                 lastDate: DateTime.now(),
      //               );
      //               if (date != null) {
      //                 dateController.text =
      //                     DateFormat('dd-MMM-yyyy').format(date);
      //               }
      //             },
      //             icon: const Icon(Icons.calendar_today),
      //           ),
      //         ),
      //       ),
      //       TextFormField(
      //         textInputAction: TextInputAction.next,
      //         decoration: const InputDecoration(
      //           prefixIcon: Icon(Icons.edit_document),
      //           labelText: 'Pan Number',
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       SizedBox(
      //           width: double.infinity,
      //           height: 50.0,
      //           child: ElevatedButton(
      //               onPressed: () {
      //                 showDialog(
      //                     context: context,
      //                     builder: (context) {
      //                       return AlertDialog(
      //                         //title: Text('Verification'),
      //                         content: SizedBox(
      //                           height: 350,
      //                           child: Column(
      //                             crossAxisAlignment: CrossAxisAlignment.center,
      //                             mainAxisAlignment: MainAxisAlignment.center,
      //                             children: [
      //                               // Text('Verification'),
      //
      //                               Image.asset(
      //                                 'assets/done.png',
      //                                 width: 200,
      //                                 height: 200,
      //                               ),
      //                               const SizedBox(
      //                                 height: 10,
      //                               ),
      //                               const Text(
      //                                 "Congratulations!",
      //                                 style: TextStyle(
      //                                     fontSize: 20,
      //                                     fontWeight: FontWeight.bold),
      //                               ),
      //                               const Center(
      //                                 child: Text(
      //                                     textAlign: TextAlign.center,
      //                                     'An email has been sent to your registered email address. Please check your email and follow the instructions to reset your password.'),
      //                               ),
      //                             ],
      //                           ),
      //                         ),
      //                         actions: [
      //                           TextButton(
      //                               onPressed: () {
      //                                 Navigator.pop(context);
      //                               },
      //                               child: const Text('OK'))
      //                         ],
      //                       );
      //                     });
      //                 // showAboutDialog(
      //                 //   context: context,
      //                 //   applicationIcon: Icon(Icons.person),
      //                 // );
      //               },
      //               style: ButtonStyle(
      //                   foregroundColor:
      //                       MaterialStateProperty.all(Colors.white),
      //                   backgroundColor: MaterialStateProperty.all(Colors.blue),
      //                   shape:
      //                       MaterialStateProperty.all<RoundedRectangleBorder>(
      //                           RoundedRectangleBorder(
      //                               borderRadius:
      //                                   BorderRadius.circular(15.0)))),
      //               child: const Text('Verify')))
      //     ])),
    );
  }
}
