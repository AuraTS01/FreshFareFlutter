import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/company.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freshfare/freshfare/dispatched.dart';
import 'package:freshfare/freshfare/price.dart';
import 'package:freshfare/freshfare/orderlist.dart';

class PricePage extends StatefulWidget 
{
  const PricePage({super.key});
  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage>
{

  String userName = '';
  String userEmail = '';

   final Map<String, TextEditingController> priceControllers = {
    "Chicken With Skin": TextEditingController(),
    "Chicken Without Skin": TextEditingController(),
    "Mutton": TextEditingController(),
    "Kadai": TextEditingController(),
    "Beef": TextEditingController(),
    "Beef Boti": TextEditingController(),
    "Beef Liver": TextEditingController(),
  };


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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Item Price Update",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Product list
            Column(
              children: priceControllers.keys.map((productName) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: priceControllers[productName],
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed : () async {
                            Map<String, String> updatedPrices = {};
                priceControllers.forEach((product, controller) {
                  if (controller.text.isNotEmpty) {
                    updatedPrices[product] = controller.text;
                  }
                });

                if (updatedPrices.isNotEmpty) {
                  // Add company_id if needed
                  updatedPrices['company_id'] = '1'; // Replace with actual company_id

                  // Send POST request to your PHP script
                  var url = Uri.parse('http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/price.php');
                  var response = await http.post(url, body: updatedPrices);

                  if (response.statusCode == 200) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(response.body)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to update prices")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter at least one price")),
                  );
                }
              },                         
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder
                    (
                      borderRadius: BorderRadius.circular(0),
                    ),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Update Prices",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      );
    
  }
}

