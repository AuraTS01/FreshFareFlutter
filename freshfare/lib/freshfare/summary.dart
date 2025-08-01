import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:freshfare/freshfare/prawns.dart';



class SummaryPage extends StatefulWidget 
{
  const SummaryPage({super.key});
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
{

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

  @override
  Widget build(BuildContext context) 
  {
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
              height:60,),
              RichText(text: TextSpan
              (
                children: 
                [
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 60,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'resh',style:TextStyle(color:Colors.black,fontSize: 60,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 60,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'are',style: TextStyle(color:Colors.black,fontSize: 60,fontWeight: FontWeight.bold),),
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
            DrawerHeader(
                  decoration:BoxDecoration(color:Colors.green), 
                  child: UserAccountsDrawerHeader(
                  currentAccountPictureSize: Size.square(40),
                  currentAccountPicture: CircleAvatar
                  (
                    backgroundColor:Color.fromARGB(255, 165, 255, 137),
                    child: Text("T",style: TextStyle(fontSize: 30.0),), 
                  ), 
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text( "Tester", style: TextStyle(fontSize: 18),),
                  accountEmail: Text("tester@gmail.com"),
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
              onTap: () {   
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));                    
              },
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child:Padding
        (
          padding: EdgeInsets.all(16.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: Colors.green,
                padding: EdgeInsets.all(12),
                child: Text("Order Summary",style: TextStyle(color: Colors.white,fontSize: 18),),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                ),
               
              )
            ],
          )
        )
      )
    ); 
  }
}
