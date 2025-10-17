import 'package:flutter/material.dart';
import 'package:freshfare/Freshfare/profile.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:intl/intl.dart';
import 'package:freshfare/freshfare/orderhistory.dart';

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

  int _selectedIndex = 0;
  
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
            Image.asset('assets/logo.png',height:45),
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
        actions: 
        [
          Consumer<CartProvider>
          (
            builder: (context, cart, child) 
            {
              return InkWell
              (
                onTap: () 
                {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const CartPage()),);
                },
                child: Stack
                (
                  alignment: Alignment.center,
                  children: 
                  [
                    Padding
                    (
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.shopping_cart_outlined, size: 30),
                    ),
                    if (cart.items.isNotEmpty) 
                      Positioned
                      (
                        right: 4,
                        top: 4,
                        child: Container
                        (
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration
                          (
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: Text('${cart.items.length}',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold,)),
                        ),
                      ),
                  ],
                ),
              );  
            },
          ),
          SizedBox(width: 10),  
        ],
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
                        Text("Order ID :", style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),
                        Text("Date : $formattedDate $formattedTime", style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),
                        Text("Payment Mode : Cash On Delivery", style: TextStyle(fontSize: 14,)),
                        SizedBox(height: 20),
                        Text("Status : ", style: TextStyle(fontSize: 14,)),
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
                              title: Text("${product.companyName ?? 'FreshChicken'}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                              subtitle:Column
                              (
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                [
                                  Text(product.name),
                                  Text("Qty: ${product.quantity}"),
                                  
                                ],
                              ),                               
                              trailing: Text("₹${product.price}"),  
                            );                
                          }
                        ),
                        Divider(height: 20),
                        Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: 
                          [
                            Text("Subtotal",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            Text("₹${cart.totalPrice}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                          ],
                        ),
                        Divider(height: 20),
                        Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: 
                          [
                            Text("GST (5%)", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("₹${(cart.totalPrice * 0.05).toStringAsFixed(2)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Divider(height: 30),
                        Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: 
                          [
                            Text("Total",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            Text("₹${(cart.totalPrice * 1.05).toStringAsFixed(2)}",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HomePage()));
              break;
            case 1:
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const HistoryPage()));
              break; 
            case 2:
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const NotificationPage()));
              break;
            case 3:
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const ProfilePage()));
              break;
            case 4:
               Navigator.pop(context); 
               break;
          }
        },
        items: const 
        [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.history),label: 'Orders',),
          BottomNavigationBarItem(icon: Icon(Icons.notifications),label: 'Notifications',),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',),
        ],
      ),  
    ); 
  }
}
