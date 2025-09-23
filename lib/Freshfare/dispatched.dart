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
            TextButton(
              onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn'); 
              await prefs.remove('userId');     

            
              Navigator.of(context).pop();
              
              Navigator.of(context).pop();

              
              setState(() {
                userName = '';
                userEmail = '';
              });
              await prefs.remove('userEmail'); // clear login
              
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
      drawer:Drawer
      ( 
        child: ListView
        (                
          padding: EdgeInsets.zero,
          children: 
          [
           UserAccountsDrawerHeader
              (
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text("Hello $userName"),
                accountEmail: Text(userEmail),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(userName.isNotEmpty ? userName[0] : '?',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Poppins"),),
                  ),
              ),
             ListTile
              (
                leading: Icon(Icons.home_outlined),
                title: const Text('Dashboard'),
                onTap: () {          
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyPage(),));               
                },
              ),
              ListTile
              (
                leading: Icon(Icons.auto_stories_outlined),
                title: Text('View Orders List'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => OrderlistPage(),));
                },
             ),
             ListTile
              (
                leading: Icon(Icons.auto_stories_outlined),
                title: Text('View Dispatched Order List'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => DispatchedPage(),));
                },
             ),
             ListTile
              (
                leading: Icon(Icons.price_change_outlined),
                title: Text(' Fix Price for Products'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => PricePage(),));
                },
             ),
             if (userEmail.isEmpty) 
              ...[
                ListTile
                (
                  leading: Icon(Icons.login_outlined),
                  title: Text('Login'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ).then((_) => _loadUserData()); 
                  },
                ),
              ]
              else 
              ...[
                ListTile
                (
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    _showLogoutDialog(context);
                  },
                ),
              ]
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
                  // TableRow
                  // (
                  //   decoration: BoxDecoration(color: Colors.white),
                  //   children: 
                  //   [
                  //     Padding(padding: EdgeInsets.all(10), child: Text("#ORD967329")),
                  //     Padding(padding: EdgeInsets.all(10),child: Text("John Frank\n8967452310\nCOD")),
                  //     Padding
                  //     (
                  //       padding: EdgeInsets.all(10),
                  //       child: Column
                  //       (
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: const [
                  //           Text("Chicken With Skin (1 Kg) – ₹170.00"),
                  //           Text("Chicken Without Skin (1 Kg) – ₹180.00"),
                  //         ],
                  //       ),
                  //     ),
                  //     Padding(padding: EdgeInsets.all(10), child: Text("₹350")),
                  //     Padding(padding: EdgeInsets.all(10), child: Text("2025-09-15 11:44:59")),
                  //     Padding(
                  //       padding: EdgeInsets.all(10),
                  //       child: ElevatedButton(
                  //         onPressed: () {},
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.blue,
                  //           foregroundColor: Colors.white,
                  //         ),
                  //         child: Text("Acknowledge"),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // TableRow
                  // (
                  //   decoration: BoxDecoration(color: Colors.white),
                  //   children: 
                  //   [
                  //     Padding(padding: EdgeInsets.all(10), child: Text("#ORD967329")),
                  //     Padding(padding: EdgeInsets.all(10),child: Text("John Frank\n8967452310\nCOD")),
                  //     Padding
                  //     (
                  //       padding: EdgeInsets.all(10),
                  //       child: Column
                  //       (
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: const [
                  //           Text("Chicken With Skin (1 Kg) – ₹170.00"),
                  //           Text("Chicken Without Skin (1 Kg) – ₹180.00"),
                  //         ],
                  //       ),
                  //     ),
                  //     Padding(padding: EdgeInsets.all(10), child: Text("₹350")),
                  //     Padding(padding: EdgeInsets.all(10), child: Text("2025-09-15 11:44:59")),
                  //     Padding(
                  //       padding: EdgeInsets.all(10),
                  //       child: ElevatedButton(
                  //         onPressed: () {},
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.blue,
                  //           foregroundColor: Colors.white,
                  //         ),
                  //         child: Text("Acknowledge"),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    ); 
  }
}

