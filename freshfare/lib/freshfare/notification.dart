import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';


class NotificationPage extends StatefulWidget 
{
  const NotificationPage({super.key});
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
{
 
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
                  currentAccountPicture: CircleAvatar(
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
      body:Center
      (
       child: Text('No Notification',style: TextStyle(color: Colors.black,fontSize: 15),),
      ),  
    ); 
  }
}

