import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/profile.dart';
import 'package:freshfare/freshfare/viewdelivery.dart';


class DeliveryPage extends StatefulWidget 
{
  const DeliveryPage({super.key});
  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage>
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
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Poppins"),),
                  ),
              ),
              ListTile
              (
                leading: Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () {          
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryPage(),));               
                },
              ),
              ListTile
              (
                leading: Icon(Icons.delivery_dining),
                title: Text('View Undelivered /Delivered Orders'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewdeliveryPage(),));
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
     body: Padding
     (
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView
        (
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
                  Icon(Icons.bar_chart, size: 30.0, color: Colors.blue),
                  SizedBox(width: 10),
                  RichText(
                    text: TextSpan
                    (
                      children: 
                      [
                        TextSpan(text: "Delivery Dashboard",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,fontFamily: "Poppins",),),
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
                decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(12),),
                child: Column
                (
                  children: 
                  [
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Delivered Orders",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
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
                decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(12),),
                child: Column
                (
                  children: 
                  [
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text("Pending Orders",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
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
                    Text("Picked Up (Undelivered)",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

