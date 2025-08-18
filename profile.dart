import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget 
{
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                // Navigator.pushReplacementNamed(context, '/login');
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: 
            [
              Image.asset('assets/logo.png',
              height:53),
              RichText(text: TextSpan
              (
                children: 
                [
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 50,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'resh',style:TextStyle(color:Colors.black,fontSize: 50,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 50,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'are',style: TextStyle(color:Colors.black,fontSize: 50,fontWeight: FontWeight.bold),),
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
                child: Text(userName.isNotEmpty ? userName[0] : '?'),
                ),
              ),
            ListTile
            (
              leading: Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {          
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));               
              },
            ),
            ListTile
              (
                leading: const Icon(Icons.shopping_cart),
                title: const Text('My Cart'),
                onTap: () {   
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));                    
                },
              ),
            ListTile
            (
                  leading: Icon(Icons.notifications_outlined),
                  title: Text('Notifications'),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(),));
                  },
            ),
           ListTile
              (
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async{   
                  _showLogoutDialog(context); 
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                },
              ),
          ],
        ),
      ),
      body:Center
      (
       child: Container
       (
          decoration:BoxDecoration
          (
            color: Colors.white,             
            boxShadow:
            [
              BoxShadow
              ( 
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 4,
                offset: Offset(0,5,),
              ),
            ],
          ),
          margin:EdgeInsets.all(20.0),    
        ),
      ),  
    ); 
  }
}

