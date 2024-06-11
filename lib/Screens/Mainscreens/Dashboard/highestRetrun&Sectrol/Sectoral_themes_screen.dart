import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tradingapp/Screens/Mainscreens/Dashboard/highestRetrun&Sectrol/Sector_in_focus_screen.dart';

class SectoralThemesScreen extends StatefulWidget {
  const SectoralThemesScreen({super.key});

  @override
  State<SectoralThemesScreen> createState() => _SectoralThemesScreenState();
}

class _SectoralThemesScreenState extends State<SectoralThemesScreen> {
final items = [
    {'title': 'IT-softwares', 'icon': Icons.computer},
    {'title': 'Finance/NBFC', 'icon': Icons.attach_money},
    {'title': 'Textile', 'icon': Icons.design_services},
    {'title': 'Chemicals', 'icon': Icons.science},
    {'title': 'Pharma', 'icon': Icons.medical_services},
    {'title': 'FMCG', 'icon': Icons.local_grocery_store},
    {'title': 'Iron and Steel', 'icon': Icons.construction},
    {'title': 'Capital Goods', 'icon': Icons.business},
    {'title': 'Cement', 'icon': Icons.apartment},
    {'title': 'Power', 'icon': Icons.power},
    {'title': 'Oil Exploration/Refineries', 'icon': Icons.local_gas_station},
    {'title': 'Private Banks', 'icon': Icons.account_balance},
    {'title': 'Consumer Durables', 'icon': Icons.shopping_cart},
    {'title': 'Others', 'icon': Icons.more_horiz},
  ];

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sectoral Themes Screen'),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => SectorInFocusScreen(sectorValue: items[index]['title'] as String
                    
                ));
              },
              child: ListTile(
                leading: Stack(
                  children: [Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  child: Icon(items[index]['icon'] as IconData,color:Colors.white,),
                  ),
                    
                  ],
                ),
                title: Text(items[index]['title'] as String),
              ),
            );
          },
        ),
      ),
    );
  }
}