import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrawnsPage extends StatefulWidget {
  const PrawnsPage({super.key, required String selecteditem});

  @override
  State<PrawnsPage> createState() => _PrawnsPageState();
}

class _PrawnsPageState extends State<PrawnsPage> {
  final  searchcontroller = TextEditingController();
  void search()
  {
    String input = searchcontroller.text;
    if(input=="chicken"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => ChickenPage(selecteditem: '',),));
    }
    else if(input=="fish"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => FishPage(selecteditem: '',),),);
    }
    else if(input=="prawns"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => PrawnsPage(selecteditem: '',),),);
    }
    else if(input=="mutton"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => MuttonPage(selecteditem: '',),),);
    }
    else if(input.isEmpty)
    {
      Fluttertoast.showToast
                      (
                        msg: "Please enter something to search",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
    }
  }

  bool showButton = false;
  bool showButton_1 = false;

  void toggleButton(){
    setState(() {
      showButton = !showButton;
      showButton_1 = !showButton_1;
    });
  }

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
    return  Scaffold(
        appBar: AppBar(
               title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
      ),),
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
      body: Padding
        (
          padding: EdgeInsets.all(16.0),
          child: ListView
          (
            children: 
            [
              Row
                (
                  children: 
                  [
                    Expanded
                    (
                      child: TextField
                      (
                        controller:searchcontroller,
                        decoration: InputDecoration
                        (
                          hintText: 'what do you need?',
                          border: OutlineInputBorder(),
                          
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120.0,
                      height: 45.0,
                    child:ElevatedButton
                    (
                      
                      style: ElevatedButton.styleFrom
                     (
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder
                        (
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed:search,
                      child: Text('search',style: TextStyle(color: Colors.white),),
                    ),
                    ),
                  ],
                ),
              SizedBox(height: 30),
              Column
                (
                  children: 
                  [
                    Text("Prawns",style: TextStyle(
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold, ),),
                    SizedBox(height: 5),
                    Container
                    (
                      width: 30,
                      height: 4,
                      color: Colors.green,
                    ),
                  ],
                ),
              SizedBox(height: 40,),
              Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/prawns.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("  Prawns \n ₹ 400.00",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),), 
                ], 
              ),
              SizedBox(height: 40),
              Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/Shrimp.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton_1)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Shrimp \n₹ 350.00",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
        ),
        
    );
  }
}