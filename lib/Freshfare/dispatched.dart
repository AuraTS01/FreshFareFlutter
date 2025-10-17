import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/company.dart';
import 'package:freshfare/freshfare/dispatched.dart';
import 'package:freshfare/freshfare/price.dart';
import 'package:freshfare/freshfare/orderlist.dart';
class DispatchedPage extends StatefulWidget 
{
  const DispatchedPage({super.key});
  @override
  State<DispatchedPage> createState() => _DispatchedPageState();
}

class _DispatchedPageState extends State<DispatchedPage>
{

  String userName = '';
  String userEmail = '';

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

   void _showLogoutDialog(BuildContext context)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton
            (
              onPressed: () async 
              {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();    
                setState(() {
                  userName = '';
                  userEmail = '';
                });
                Navigator.of(context).pop();
                Fluttertoast.showToast(
                msg: "Logout Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
                );    
              },
               child: const Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text("No"),
            ),            
          ],
        );
      },
    );
  }

  int _selectedIndex = 2;
 
  @override
  Widget build(BuildContext context) {
    return  Scaffold
    (
      appBar: AppBar
      (
        title:Row
        (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              Image.asset('assets/logo.png',
              height:45),
              SizedBox(width: 8),
              RichText(text: TextSpan
              (
                children: 
                [
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
                  TextSpan(text: 'resh',style:TextStyle(color:Colors.black,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
                  TextSpan(text: 'are',style: TextStyle(color:Colors.black,fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
                ],
              ),
              ),
            ],
          ),
      ),
      body: SingleChildScrollView
      (
        padding: EdgeInsets.all(16),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Icon(Icons.shopping_bag, color: Colors.green, size: 28),
                SizedBox(width: 8),
                Text("Dispatched Orders",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: "Poppins",),),
              ],
            ),
            SizedBox(height:40),
            SingleChildScrollView
            (
              scrollDirection: Axis.horizontal, 
              child: Table
              (
                border: TableBorder.all(color: Colors.grey.shade400,width: 1,),
                columnWidths: const {
                  0: FixedColumnWidth(120), // Order #
                  1: FixedColumnWidth(150), // Customer
                  2: FixedColumnWidth(220), // Items
                  3: FixedColumnWidth(100),  // Total
                  4: FixedColumnWidth(160), // Date
                  5: FixedColumnWidth(170), // Status
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: 
                [
                  TableRow
                  (
                    decoration: BoxDecoration(color: Colors.green.shade100),
                    children: const [
                      Padding(padding: EdgeInsets.all(8), child: Text("Order Code", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Customer", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Items", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Total Price", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Order Date", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar
      (
        currentIndex: _selectedIndex  < 0 ? 0 : _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: (index) 
        {
          setState(() {
            _selectedIndex = index;
          });
          switch (index) 
          {
            case 0:
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const CompanyPage()));
              break;
            case 1:
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const OrderlistPage()));
              break; 
            case 2:
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const DispatchedPage()));
              break;
            case 3:
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const PricePage()));
              break;
            case 4:
               Navigator.pop(context); 
               break;
          }
        },
        items: const 
        [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.book_rounded),label: 'View Orders',),
          BottomNavigationBarItem(icon: Icon(Icons.view_agenda),label: 'Dispatched',),
          BottomNavigationBarItem(icon: Icon(Icons.price_change),label: 'Fix Price',),
        ],
      ),
    ); 
  }
}

