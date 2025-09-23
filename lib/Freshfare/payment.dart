import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:freshfare/freshfare/summary.dart';
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
              onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn'); 
              await prefs.remove('userId');     

            
              Navigator.of(context).pop();
              
              Navigator.of(context).pop();

              
              setState(() {
                userName = '';
                userEmail = '';
              });
              await prefs.remove('userEmail'); // clear login
              
              Fluttertoast.showToast(
              msg: "Logout Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
              );  
             
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
            if (userEmail.isEmpty) 
              ...[
                ListTile
                (
                  leading: Icon(Icons.login_outlined),
                  title: Text('Login'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    ).then((_) => _loadUserData()); 
                  },
                ),
              ]
              else 
              ...[
                ListTile
                (
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async {
                    _showLogoutDialog(context);
                  },
                ),
              ]
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
