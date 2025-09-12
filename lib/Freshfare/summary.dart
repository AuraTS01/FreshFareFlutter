import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:intl/intl.dart';


class SummaryPage extends StatefulWidget 
{
  
  const SummaryPage({super.key});
  
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
{

  String userName = '';
  String userEmail = '';
  String userPhone = '';
  String billingAddress = '';
  String billingTown = '';
  String billingState = '';


  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      userPhone = prefs.getString('userPhone') ?? '';

      billingAddress = prefs.getString('billingAddress') ?? '';
      billingTown = prefs.getString('billingTown') ?? '';
      billingState = prefs.getString('billingState') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  
  @override
  Widget build(BuildContext context) 
  {

    final cart = Provider.of<CartProvider>(context); 

    DateTime now = DateTime.now();  

    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    String formattedTime = DateFormat('hh:mm a').format(now);

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
                accountName: Text("Hello $userName"),
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
          ],
        ),
      ),
      body:Padding
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
              SizedBox(height: 20), 
              Expanded
              (                
                child:SingleChildScrollView
                (                  
                  child:Padding
                  (
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Customer Info",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,)),
                        SizedBox(height: 30),
                        Text("Name : $userName",style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20), 
                        Text("Email : $userEmail",style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),        
                        Text("Phone : $userPhone", style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),
                        Text("Address : $billingAddress, $billingTown, $billingState.",style: TextStyle(fontSize: 14)),
                        SizedBox(height: 30),
                        Text("Order Details", style: TextStyle( fontSize: 16, fontWeight: FontWeight.bold,)),
                        SizedBox(height: 20),
                        Text("Order ID:", style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),
                        Text("Date : $formattedDate $formattedTime", style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),
                        Text("Payment Mode: Cash On Delivery", style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),
                        Text("Items", style: TextStyle(fontSize: 14,)),
                        Divider(height: 20),
                        ListView.builder
                        (
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: cart.items.length,               
                          itemBuilder: (context,index)
                          {
                            final product = cart.items[index];
                            return ListTile
                            (
                              title: Text(product.name),
                              subtitle: Text("Qty: ${product.quantity}"),
                              trailing: Text("₹${product.price}"),  
                            );                
                          }
                        ),
                        Divider(height: 20),
                        Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            Text("₹${cart.totalPrice}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ),   
    ); 
  }
}
