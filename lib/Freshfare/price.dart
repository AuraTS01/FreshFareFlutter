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

  int _selectedIndex = 3;

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

