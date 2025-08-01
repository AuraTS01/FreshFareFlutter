import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/prawns.dart';
import 'package:freshfare/freshfare/summary.dart';



class PaymentPage extends StatefulWidget 
{
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
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

  String selectedPayment = 'Pay on Delivery';

  void placeorder()
  {
    Fluttertoast.showToast
        (
          msg: "Order Placed Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
     Navigator.push(context, MaterialPageRoute(builder: (context) => SummaryPage(),));  
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
      
        body: SingleChildScrollView
        (
          padding: EdgeInsets.all(50.0),
          child: Column
          (  
            children: 
            [
                      Text("Payment Options",style: TextStyle(color: Colors.black,fontSize: 30),),
                      Divider(height: 30,thickness: 1,),
                      Column
                      (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: 
                        [ 
                          RadioListTile
                          (
                            title: Text('Credit/Debit Card'),
                            value: 'Card', 
                            groupValue: selectedPayment, 
                            onChanged: (value)
                            {
                              setState(() {
                                selectedPayment =  value.toString();
                              });
                            },
                          ),
                          RadioListTile
                          (
                            title: Text('UPI'),
                            value: 'UPI', 
                            groupValue: selectedPayment, 
                            onChanged: (value)
                            {
                              setState(() {
                                selectedPayment =  value.toString();
                              });
                            },
                          ),
                          RadioListTile
                          (
                            title: Text('Pay on Delivery'),
                            value: 'Pay on Delivery', 
                            groupValue: selectedPayment, 
                            onChanged: (value)
                            {
                              setState(() {
                                selectedPayment =  value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      if(selectedPayment == 'Pay on Delivery')
                        Container
                        (
                          padding: EdgeInsets.all(10),
                          color: Colors.green.shade50,
                          child: Text('You\'ve selected Pay on Delivery. Please Keep the amount ready when your order arrives.',
                          style: TextStyle(color:Colors.green.shade900),),
                        ),
                      if(selectedPayment == 'Card')
                        Container
                        (
                          padding: EdgeInsets.all(10),
                          color: Colors.yellow.shade50,
                          child: Text('This payment method is under development. Please choose a Pay on Delivery',
                          style: TextStyle(color:Colors.black),),
                        ),  
                      if(selectedPayment == 'UPI')
                        Container
                        (
                          padding: EdgeInsets.all(10),
                          color: Colors.yellow.shade50,
                          child: Text('This payment method is under development. Please choose a Pay on Delivery',
                          style: TextStyle(color:Colors.black),),
                        ),  
                      SizedBox(height: 30),
                      ElevatedButton
                      (
                        onPressed: placeorder,
                        style: ElevatedButton.styleFrom
                        (
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                          shape: RoundedRectangleBorder
                          (
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: Text('Place Order',style: TextStyle(color: Colors.white,fontSize: 16),)
                      ),  
                    ],
                ),
        ),   
    ); 
  }
}
