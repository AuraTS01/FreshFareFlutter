import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/Freshfare/cartprovider.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/summary.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PaymentPage extends StatefulWidget 
{
  const PaymentPage({super.key});
  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
{

  
  String selectedPayment = 'Pay on Delivery';

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

  @override
  Widget build(BuildContext context) 
  {
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
                      child: Icon(Icons.shopping_bag, size: 30),
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
                            title: Text('Pay Online (UPI / Card / Netbanking / Wallet)'),
                            value: 'Card', 
                            groupValue: selectedPayment, 
                            onChanged: (value)
                            {
                              setState(() {
                                selectedPayment =  value.toString();
                              });
                            },
                          ),
                          SizedBox(height: 20),
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
                          child: Text('You’ve selected Pay on Delivery. Please keep the amount ready when your order arrives.',
                          style: TextStyle(color:Colors.green.shade900),),
                        ),
                      if(selectedPayment == 'Card')
                        Container
                        (
                          padding: EdgeInsets.all(10),
                          color: Colors.green.shade50,
                          child: Text('You’ve selected Online Payment. Complete the payment securely with Razorpay.',
                          style: TextStyle(color:Colors.green.shade900),),
                        ),  
                      SizedBox(height: 30),
                      ElevatedButton
                      (
                        onPressed:(){
                                Navigator.push( context,MaterialPageRoute(builder: (context) => const SummaryPage()));
                                Fluttertoast.showToast(
                                      msg: "Order is Placed",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                        },
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
