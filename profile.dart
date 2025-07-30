import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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
              height:70,),
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
      drawer:Drawer( 
                  child: ListView(                
                  padding: EdgeInsets.zero,
                  children: [
                   ListTile(
                          leading: CircleAvatar(
                          backgroundColor: Color(0xffE6E6E6),
                          radius: 30,
                         child: Icon(Icons.person,color:Color(0xffCCCCCC),),
                          ),
                         title:Text('Hello'),
                      // decoration: BoxDecoration(color: Colors.green),
                      
                    ),
                    SizedBox(height: 40),
                    ListTile(
                      title: const Text('Home'),
                      onTap: () {          
                         Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));               
                      },
                    ),
                    ListTile(
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
       child: Container
       (
            decoration:BoxDecoration(color: Colors.white,             
            boxShadow:[
            BoxShadow( color: Colors.black26,
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

