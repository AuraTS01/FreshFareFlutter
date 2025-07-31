import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/prawns.dart';



class CheckoutPage extends StatefulWidget 
{
  const CheckoutPage({super.key});
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
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
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text( "Tester", style: TextStyle(fontSize: 18),),
                accountEmail: Text("tester@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:Color.fromARGB(255, 165, 255, 137),
                  child: Text("T",style: TextStyle(fontSize: 30.0),), 
                ), 
                
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
                  onTap: (){},
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
                Row
                (
                  children:
                  [
                    Icon(Icons.phone,color: Colors.green),
                    SizedBox(width: 10),
                    Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: 
                      [
                        Text('+91 8754364997',style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('support 24/7 '),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 30),
                 Column
                (
                  children: 
                  [
                    Text("Checkout",style: TextStyle(
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold, ),),
                    SizedBox(height: 5),
                    Container
                    (
                      width: 40,
                      height: 4,
                      color: Colors.green,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Billing Detail",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(
                      height: 1,
                      color: Colors.black,
                    )
                  ],
                )
                
            ],
           
          ),
        ),   
    ); 
  }
}
