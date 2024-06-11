import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tradingapp/model/profile_model.dart';
import 'package:tradingapp/model/userProfile_model.dart';

class UserProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  UserProfileScreen({required this.userProfile});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isVisiblePersonalDetails = false;
  bool isVisibleBankDetails = false;

  @override
  Widget build(BuildContext context) {
    // Use userProfile to build your screen
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text('Profile'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
              child: Container(
                  child: Column(children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black12.withOpacity(0.06),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text("Personal Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        trailing: isVisiblePersonalDetails
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up),
                        onTap: () {
                          setState(() {
                            isVisiblePersonalDetails =
                                !isVisiblePersonalDetails;
                          });
                        },
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: isVisiblePersonalDetails,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal Details",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.edit,
                              size: 19,
                            ),
                            color: Colors.black,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name (as on PAN Card)",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.clientName,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.phone,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            //itis done
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mobile Number",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.mobileNo,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Birth Date",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.dateOfBirth,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email ID",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.emailId,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.withOpacity(0.1),
                                  child: Icon(
                                    Icons.credit_card,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "PAN Number",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.userProfile.pan,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.copy,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: widget.userProfile.pan));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Copied to clipboard'),
                                    duration: Duration(milliseconds: 80),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey.withOpacity(0.1),
                                  child: Icon(
                                    Icons.account_balance,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Demat Account Number",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.userProfile.dematAccountNumber,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.copy,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text:
                                        widget.userProfile.dematAccountNumber));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Copied to clipboard'),
                                    duration: Duration(milliseconds: 80),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Client Type",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Colors.grey.withOpacity(0.1),
                                    child: Icon(
                                      Icons.account_balance_wallet,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.blue.withOpacity(0.2)),
                                          value: widget
                                              .userProfile.isInvestorClient,
                                          groupValue: widget
                                              .userProfile.isInvestorClient,
                                          onChanged: null),
                                      Text(
                                        widget.userProfile.isProClient
                                            ? "Pro "
                                            : widget.userProfile
                                                    .isInvestorClient
                                                ? "Investor "
                                                : "Client",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.withOpacity(0.8),
                                        ), // Adjust the style as needed
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        fillColor: MaterialStateProperty.all(
                                          Colors.grey.withOpacity(0.2),
                                        ),
                                        value: null,
                                        groupValue:
                                            widget.userProfile.isProClient,
                                        onChanged: null,
                                      ),
                                      Text(
                                        widget.userProfile.isProClient
                                            ? "Pro "
                                            : widget.userProfile
                                                    .isInvestorClient
                                                ? "Pro "
                                                : "Client",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.withOpacity(0.8),
                                        ), // Adjust the style as needed
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.qr_code,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Client Code",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.clientId,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black12.withOpacity(0.06),
                      ),
                      Container(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.place,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Residential Address",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.residentialAddress == null
                                      ? ""
                                      : " - ",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ]),
                  ),
                ]),
          
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black12.withOpacity(0.06),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text("Bank Details",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                trailing: isVisibleBankDetails
                    ? Icon(Icons.arrow_drop_down)
                    : Icon(Icons.arrow_drop_up),
                onTap: () {
                  setState(() {
                    isVisibleBankDetails = !isVisibleBankDetails;
                  });
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Visibility(
              visible: isVisibleBankDetails,
              child: Column(
                children: [
                  
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Bank Details",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          size: 19,
                        ),
                        color: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          child: Icon(
                            Icons.account_balance,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank Name",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.userProfile.bankName,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12.withOpacity(0.06),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.wb_iridescent,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "IFSC Code",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.bankIFSCCode,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.copy,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: widget.userProfile.bankIFSCCode));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Copied to clipboard'),
                                duration: Duration(milliseconds: 80),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12.withOpacity(0.06),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              child: Icon(
                                Icons.numbers,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Account Number",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.userProfile.accountNumber,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.copy,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text: widget.userProfile.accountNumber));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Copied to clipboard'),
                                duration: Duration(milliseconds: 80),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.black12.withOpacity(0.06),
                  ),
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          child: Icon(
                            Icons.location_city,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Type",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.userProfile.accountType,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Divider(
            //   color: Colors.black12.withOpacity(0.06),
            // ),
          ])))),
    );
  }
}
