import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:freshfare/freshfare/payment.dart';
import 'package:freshfare/freshfare/prawns.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CheckoutPage extends StatefulWidget 
{
  const CheckoutPage({super.key});
  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
{
  final _formkey = GlobalKey<FormState>();
  final  namecontroller = TextEditingController();
  final  countrycontroller = TextEditingController();
  final  addresscontroller = TextEditingController();
  final  towncontroller = TextEditingController();
  final  statecontroller = TextEditingController();
  final zipcontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final loginemailcontroller = TextEditingController();

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
     Future.delayed(Duration(milliseconds: 0), () {
    fetchUserData(); 
    loadBillingDetails();
     });
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

  final String baseUrl = "http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/";

  Future<void> checkout() async{

   if (userEmail.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("No email found, login again")),
    );
    return;
  }


    var url = Uri.parse("$baseUrl/checkout.php");


    var response = await http.post(url, body:{
        "email":userEmail,
        "country":countrycontroller.text,
        "Address_1":addresscontroller.text,
        "town":towncontroller.text,
        "state":statecontroller.text,
    });

    var data = json.decode(response.body);

   
      if (data['status'] == "Success") {
      Fluttertoast.showToast(
          msg: "Checkout Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        ); 
        Navigator.push(context,MaterialPageRoute(builder: (context) => PaymentPage()),
        );
    }
      else{
        Fluttertoast.showToast(
                    msg: "Error",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
      }
    
  }

  Future<void> fetchUserData() async {
  if (userEmail.isEmpty) return;

  final response = await http.post(
    Uri.parse("$baseUrl/getuser.php"),
    body: {"email": userEmail},
  );

  var data = jsonDecode(response.body);

  if (data['status'] == "Success") {
    setState(() {
      namecontroller.text = data['name'] ?? '';
      emailcontroller.text = data['email'] ?? '';
      phonecontroller.text = data['number'] ?? '';
    });
  } else {
      Fluttertoast.showToast(
        msg: "Failed to fetch user data",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> saveBillingDetails() async 
  {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('billingName', namecontroller.text);
    await prefs.setString('billingCountry', countrycontroller.text);
    await prefs.setString('billingAddress', addresscontroller.text);
    await prefs.setString('billingTown', towncontroller.text);
    await prefs.setString('billingState', statecontroller.text);
    await prefs.setString('billingZip', zipcontroller.text);
    await prefs.setString('billingEmail', emailcontroller.text);
    await prefs.setString('billingPhone', phonecontroller.text);

    Fluttertoast.showToast(
      msg: "Billing details saved!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  Future<void> loadBillingDetails() async
  {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      namecontroller.text = prefs.getString('billingName') ?? '';
      countrycontroller.text = prefs.getString('billingCountry') ?? '';
      addresscontroller.text = prefs.getString('billingAddress') ?? '';
      towncontroller.text = prefs.getString('billingTown') ?? '';
      statecontroller.text = prefs.getString('billingState') ?? '';
      zipcontroller.text = prefs.getString('billingZip') ?? '';
      emailcontroller.text = prefs.getString('billingEmail') ?? '';
      phonecontroller.text = prefs.getString('billingPhone') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    final cart = Provider.of<CartProvider>(context);
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
      
        body: ListView
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
                SizedBox(height: 30),
                
                Form(
                  key: _formkey,  
                  child:Padding
                (
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                
                
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text("Note : If you have already saved your billing Address and its not visisble, Kindly logout and Login back,You will be provided with the Address that are saved.",
                          style: TextStyle(fontSize: 12)),
                    SizedBox(height: 30),
                    Text("Billing Detail",style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                  
                SizedBox(height: 30),
                TextFormField
                (
                    controller: namecontroller,                  
                    decoration: InputDecoration(labelText: 'Full Name*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value) {
                    if(value == null || value.isEmpty)
                    {
                      return 'Name is required';
                    }
                    return null;
                    },
                ),
              SizedBox(height: 20),
              TextFormField
                (
                    controller: countrycontroller,
                    decoration: InputDecoration(labelText: 'Country*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value)
                    {
                      if(value == null || value.isEmpty)
                      {
                        return 'Country is required';
                      }
                    },
                ),
                SizedBox(height: 20),
                TextFormField
                (
                    controller: addresscontroller,
                    decoration: InputDecoration(labelText: 'Address*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value)
                    {
                      if(value == null || value.isEmpty)
                      {                    
                        return 'Address  is required';
                      }
                      return null;
                    },   
                ),
                SizedBox(height: 20),
                TextFormField
                (
                    controller: towncontroller,
                    decoration: InputDecoration(labelText: 'Town / City*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value)
                    {
                      if(value == null || value.isEmpty)
                      {                    
                        return 'City is required';
                      }
                      return null;
                    },   
                ),
                SizedBox(height: 20),
                TextFormField
                (
                    controller: statecontroller,
                    decoration: InputDecoration(labelText: 'State*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value)
                    {
                      if(value == null || value.isEmpty)
                      {                    
                        return 'State is required';
                      }
                      return null;
                    },   
                ),  
                SizedBox(height: 20),    
                TextFormField
                (
                    controller: zipcontroller,
                    decoration: InputDecoration(labelText: 'Postcode / ZIP*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value)
                    {
                      if(value == null || value.isEmpty)
                      {                    
                        return 'Code is required';
                      }
                      return null;
                    },   
                ),      
                SizedBox(height: 20),
                TextFormField
                (
                    controller: emailcontroller,
                    decoration: InputDecoration(labelText: 'Email*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value)
                    {
                      if(value == null || value.isEmpty)
                      {
                        return 'Email is required';
                      }
                      else if(!value.contains('@'))
                      {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                ),
                SizedBox(height: 20),    
                TextFormField
                (
                    controller: phonecontroller,
                    decoration: InputDecoration(labelText: 'Mobile*',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)))),
                    validator: (value)
                    {
                      if(value == null || value.isEmpty)
                      {                    
                        return 'Mobile number is required';
                      }
                      return null;
                    },   
                ),       
                SizedBox(height: 20),
                SizedBox
                (
                  width: double.infinity,
                  child: ElevatedButton                                             
                    (
                      onPressed: (){
                        if (_formkey.currentState!.validate()) {
                          saveBillingDetails();  
                        }
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
                      child: Text("SAVE BILLING DETAILS",style: TextStyle(color: Colors.white),)
                    ),
                ),
                SizedBox(height: 30),
                Text("Your Order",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Subtotal",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text("₹${cart.totalPrice}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                ],
                ),
                Divider(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    Text("₹${cart.totalPrice}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                ],
                ),
                Divider(height: 30),
                SizedBox
                (
                  width: double.infinity,
                  child: ElevatedButton                                             
                    (
                      onPressed: (){
                        if (_formkey.currentState!.validate()) {
                              checkout();
                        }
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
                      child: Text("PROCEED TO PAYMENT",style: TextStyle(color: Colors.white),)
                    ),
                ),
              ],
              ),
            ),
           ),
            ],
          ),
    ); 
  }
}
