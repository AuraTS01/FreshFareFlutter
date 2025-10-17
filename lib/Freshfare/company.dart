import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/orderlist.dart';
import 'package:freshfare/freshfare/dispatched.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/profile.dart';
import 'package:freshfare/freshfare/price.dart';

class CompanyPage extends StatefulWidget 
{
  const CompanyPage({super.key});
  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage>
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
                Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginPage()),);
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

  int _selectedIndex = 0;

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
              accountName: Text(userName.isNotEmpty ? "Hello $userName" : "Hello Guest"),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(userName.isNotEmpty ? userName[0] : '?',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,),),
                ),
            ),
            ListTile
            (
              leading: Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {          
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CompanyPage(),));               
              },
            ),
            ListTile
            (
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {},
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
     body: Padding
     (
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView
        (
          // scrollDirection: Axis.horizontal,
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: 
            [
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  Icon(Icons.business_outlined, size: 25.0, color: Colors.blue),
                  SizedBox(width: 10),
                  RichText(
                    text: TextSpan
                    (
                      children: 
                      [
                        TextSpan(text:"Company Orders Dashboard",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold,fontFamily: "Poppins",),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Container
              (
                width: double.infinity,
                padding: EdgeInsets.all(40),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(12),),
                child: Column
                (
                  children: 
                  [
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Pending Orders Received",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container
              (
                width: double.infinity,
                padding: EdgeInsets.all(40),
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(12),),
                child: Column
                (
                  children: 
                  [
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Orders Packed and Out for Delivery",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          ),
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

