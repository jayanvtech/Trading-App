import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media_flutter/social_media_flutter.dart';
import 'package:tradingapp/Authentication/Screens/login_screen.dart';
import 'package:tradingapp/Authentication/auth_services.dart';
import 'package:tradingapp/GetApiService/apiservices.dart';
import 'package:tradingapp/Profile/Models/UserProfileModel/userProfile_model.dart';
import 'package:tradingapp/Profile/Screens/ProfileScreen/download_report_screen.dart';
import 'package:tradingapp/Profile/Screens/ProfileScreen/user_details_screen.dart';
import 'package:tradingapp/model/trade_balance_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  bool isExpanded = false;
  bool isLoading = false;
  Future<String?> balanceRefresher() async {
    await ApiService().GetBalance();

    setState(() {});
    return 'done';
  }

  @override
  void initState() {
    balanceRefresher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () async {
              await logout();
              Get.offAll(() => LoginScreen());
            },
            child: Text('Logout'),
          ),
          IconButton(
              onPressed: () async{
                String? token = await getToken();
                print(token);
              },
              icon: Icon(Icons.sort_by_alpha_outlined))
        ],
        title: const Text('Dashboard '),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await balanceRefresher();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Container(
              child: FutureBuilder<UserProfile>(
                future: ApiService().fetchUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {

                    return Skeletonizer(
                        child:

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Trading Balance"),

                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 16,
                                              color: Colors.blue,
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 50,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.blue),
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Text(
                                                    "WITHDRAWAL",
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 50,
                                              width: 150,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Text(
                                                    "ADD FUNDS",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Card(
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(() => UserProfileScreen(
                                                userProfile: snapshot.data!));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                  'Client ID: ',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                size: 16,
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 230,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Card(
                                        color: Colors.white,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.widgets,
                                                      color: Colors.blue,
                                                      size: 34,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Pledge Holdings",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                "Pledge Stocks or Mutual Funds you hold to Increase trading balance",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                "Pledge Stocks > ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 230,
                                      child: Card(
                                        color: Colors.white,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    height: 50,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.rv_hookup_sharp,
                                                      color: Colors.blue,
                                                      size: 34,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Pay Later(MTF)",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                "View and Analyze your MTF Stocks",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Text(
                                                "View Stocks > ",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text("DASH",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          " Reports & Statements  ",
                                          style: TextStyle(
                                              fontSize: 14,
                                              background: Paint()
                                                ..color =
                                                Colors.grey.withOpacity(0.1)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Morden Back office for investors and traders",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Divider(),
                                    CustomInkWell(
                                      onTap: () {},
                                      title: 'Trades & Charges',
                                      subtitle: 'All your charges in one place',
                                      icons: Icons.track_changes_rounded,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomInkWell(
                                      onTap: () {},
                                      title: 'Profit and Loss',
                                      subtitle: 'Analyse your profit and loss',
                                      icons: Icons.trending_up,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomInkWell(
                                      onTap: () {},
                                      title: 'Statement/Ledger',
                                      subtitle: 'Your transaction history',
                                      icons: Icons.stacked_bar_chart_sharp,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomInkWell(
                                      onTap: () {},
                                      title: 'Fund Transactions',
                                      subtitle: 'Add Funds and Withdraws histroy',
                                      icons: Icons.account_balance_wallet,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomInkWell(
                                      onTap: () {
                                        Get.to(() => DownloadReportsScreen());
                                      },
                                      title: 'Download Reports',
                                      subtitle: 'In PDF and Excel format',
                                      icons: Icons.edit_document,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Help & Support",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                    ),
                                    Row(),
                                    Container(
                                      child: Text(
                                        "Raise a ticket for any query or issue",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 85,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text("Your Tickets",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                              FontWeight.bold)),
                                                    ),
                                                    Flexible(
                                                      flex: 2,
                                                      child: Text(
                                                        "Create and manage tickets for your questions",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 85,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Call Us",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "Connect with customer support",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 85,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Contact Us",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                    Expanded(
                                                      child: Text(
                                                        "Get in touch with us",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height: 85,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                    BorderRadius.circular(5)),
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text("FAQs",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold)),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "Get Solution to common queries",
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomBasicInkWell(
                                      onTap: () {},
                                      title: 'Rate Us',
                                      icons: Icons.star,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: Divider(),
                                    ),
                                    CustomBasicInkWell(
                                      onTap: () {},
                                      title: 'Settings',
                                      icons: Icons.settings,
                                    ),
                                    SizedBox(
                                      height: 10,
                                      child: Divider(),
                                    ),
                                    CustomBasicInkWell(
                                      onTap: () {},
                                      title: 'About Us',
                                      icons: Icons.info,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        "JOIN OUR COMMUNITY",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    SocialWidget(
                                                      iconSize: 28,

                                                      placeholderText: '',
                                                      iconData: SocialIconsFlutter
                                                          .instagram,
                                                      iconColor: Colors.blue,
                                                      link:
                                                      'https://www.instagram.com/',
                                                      placeholderStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ), //placeholder text style
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.1),
                                                      shape: BoxShape.circle),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    SocialWidget(
                                                      iconSize: 28,

                                                      placeholderText: '',
                                                      iconData: SocialIconsFlutter
                                                          .linkedin,
                                                      iconColor: Colors.blue,
                                                      link:
                                                      'https://www.linkedin.com/',
                                                      placeholderStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ), //placeholder text style
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.1),
                                                      shape: BoxShape.circle),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    SocialWidget(
                                                      iconSize: 28,

                                                      placeholderText: '',
                                                      iconData: SocialIconsFlutter
                                                          .twitter,
                                                      iconColor: Colors.blue,
                                                      link:
                                                      'https://www.twitter.com/',
                                                      placeholderStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ), //placeholder text style
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.1),
                                                      shape: BoxShape.circle),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    SocialWidget(
                                                      iconSize: 28,

                                                      placeholderText: '',
                                                      iconData: SocialIconsFlutter
                                                          .facebook,
                                                      iconColor: Colors.blue,
                                                      link:
                                                      'https://www.facebook.com/',
                                                      placeholderStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                      ), //placeholder text style
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.1),
                                                      shape: BoxShape.circle),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )

                    );


                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Trading Balance"),
                                        ChangeNotifierProvider(
                                          create: (context) =>
                                          BalanceProvider()..GetBalance(),
                                          child: Consumer<BalanceProvider>(
                                            builder:
                                                (context, provider, child) {
                                              if (provider.balance == null) {
                                                return Container();
                                              }
                                              if (provider
                                                  .balance!.isNotEmpty) {
                                                var balance =
                                                    provider.balance!.first;
                                                return Text(
                                                  "₹ ${balance.netMarginAvailable}", // Replace `cashAvailable` with your actual field
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                );
                                              } else {
                                                // Handle the case when balance is empty
                                                // For example, you can return a default text widget:
                                                return Text(
                                                  "0",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16,
                                          color: Colors.blue,
                                        ))
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blue),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                                "WITHDRAWAL",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 16,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 50,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: Center(
                                              child: Text(
                                                "ADD FUNDS",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Card(
                          color: Colors.white,
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => UserProfileScreen(
                                            userProfile: snapshot.data!));
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${snapshot.data!.clientName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                              'Client ID: ${snapshot.data!.clientId}',
                                              style: TextStyle(
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 230,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  child: Card(
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.widgets,
                                                  color: Colors.blue,
                                                  size: 34,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Pledge Holdings",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "Pledge Stocks or Mutual Funds you hold to Increase trading balance",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "Pledge Stocks > ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 230,
                                  child: Card(
                                    color: Colors.white,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.rv_hookup_sharp,
                                                  color: Colors.blue,
                                                  size: 34,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Pay Later(MTF)",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            "View and Analyze your MTF Stocks",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            height: 50,
                                          ),
                                          Text(
                                            "View Stocks > ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("DASH",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      " Reports & Statements  ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          background: Paint()
                                            ..color =
                                            Colors.grey.withOpacity(0.1)),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Morden Back office for investors and traders",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Divider(),
                                CustomInkWell(
                                  onTap: () {},
                                  title: 'Trades & Charges',
                                  subtitle: 'All your charges in one place',
                                  icons: Icons.track_changes_rounded,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomInkWell(
                                  onTap: () {},
                                  title: 'Profit and Loss',
                                  subtitle: 'Analyse your profit and loss',
                                  icons: Icons.trending_up,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomInkWell(
                                  onTap: () {},
                                  title: 'Statement/Ledger',
                                  subtitle: 'Your transaction history',
                                  icons: Icons.stacked_bar_chart_sharp,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomInkWell(
                                  onTap: () {},
                                  title: 'Fund Transactions',
                                  subtitle: 'Add Funds and Withdraws histroy',
                                  icons: Icons.account_balance_wallet,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomInkWell(
                                  onTap: () {
                                    Get.to(() => DownloadReportsScreen());
                                  },
                                  title: 'Download Reports',
                                  subtitle: 'In PDF and Excel format',
                                  icons: Icons.edit_document,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Help & Support",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Row(),
                                Container(
                                  child: Text(
                                    "Raise a ticket for any query or issue",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 85,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text("Your Tickets",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.bold)),
                                                ),
                                                Flexible(
                                                  flex: 2,
                                                  child: Text(
                                                    "Create and manage tickets for your questions",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 85,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Call Us",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "Connect with customer support",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 85,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("Contact Us",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                Expanded(
                                                  child: Text(
                                                    "Get in touch with us",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 85,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.blue),
                                                borderRadius:
                                                BorderRadius.circular(5)),
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text("FAQs",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    "Get Solution to common queries",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomBasicInkWell(
                                  onTap: () {},
                                  title: 'Rate Us',
                                  icons: Icons.star,
                                ),
                                SizedBox(
                                  height: 10,
                                  child: Divider(),
                                ),
                                CustomBasicInkWell(
                                  onTap: () {},
                                  title: 'Settings',
                                  icons: Icons.settings,
                                ),
                                SizedBox(
                                  height: 10,
                                  child: Divider(),
                                ),
                                CustomBasicInkWell(
                                  onTap: () {},
                                  title: 'About Us',
                                  icons: Icons.info,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    "JOIN OUR COMMUNITY",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                SocialWidget(
                                                  iconSize: 28,

                                                  placeholderText: '',
                                                  iconData: SocialIconsFlutter
                                                      .instagram,
                                                  iconColor: Colors.blue,
                                                  link:
                                                  'https://www.instagram.com/',
                                                  placeholderStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ), //placeholder text style
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                SocialWidget(
                                                  iconSize: 28,

                                                  placeholderText: '',
                                                  iconData: SocialIconsFlutter
                                                      .linkedin,
                                                  iconColor: Colors.blue,
                                                  link:
                                                  'https://www.linkedin.com/',
                                                  placeholderStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ), //placeholder text style
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                SocialWidget(
                                                  iconSize: 28,

                                                  placeholderText: '',
                                                  iconData: SocialIconsFlutter
                                                      .twitter,
                                                  iconColor: Colors.blue,
                                                  link:
                                                  'https://www.twitter.com/',
                                                  placeholderStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ), //placeholder text style
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                SocialWidget(
                                                  iconSize: 28,

                                                  placeholderText: '',
                                                  iconData: SocialIconsFlutter
                                                      .facebook,
                                                  iconColor: Colors.blue,
                                                  link:
                                                  'https://www.facebook.com/',
                                                  placeholderStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ), //placeholder text style
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subtitle;
  final IconData icons;

  CustomInkWell(
      {required this.onTap,
        required this.title,
        required this.subtitle,
        required this.icons});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: Icon(
                        icons,
                        color: Colors.blue,
                        size: 34,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomBasicInkWell extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final IconData icons;

  CustomBasicInkWell(
      {required this.onTap, required this.title, required this.icons});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: Icon(
                        icons,
                        color: Colors.blue,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: onTap,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BalanceProvider with ChangeNotifier {
  List<Balance>? _balance;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  String searchTerm = '';
  List<Balance>? get balance => _balance;

  Future<void> GetBalance() async {
    var response = await ApiService().GetBalance();
    print("098765432$response");
    if (response != null && response is Balance) {
      _balance = [response]; // Wrap the Balance instance in a list
    } else {
      // Handle the case when response is null or not a Balance instance
    }

    print(response);
    notifyListeners();
    if (!_disposed) {
      notifyListeners();
    }
  }

  void setSearchTerm(String term) {
    searchTerm = term;
    notifyListeners();
  }
}
