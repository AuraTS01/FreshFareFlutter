
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:freshfare/freshfare/checkout.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:freshfare/freshfare/prawns.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartPage extends StatefulWidget 
{
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
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
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                // Navigator.pushReplacementNamed(context, '/login');
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
    final cart = Provider.of<CartProvider>(context);
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
              height:53,),
              RichText(text: TextSpan
              (
                children: 
                [
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 50,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'resh',style:TextStyle(color:Colors.black,fontSize: 50,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 50,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'are',style: TextStyle(color:Colors.black,fontSize: 50,fontWeight: FontWeight.bold),),
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
                SizedBox(height: 20),
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
                    Text("Shopping Cart",style: TextStyle(
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold, ),),
                    SizedBox(height: 5),
                    Container
                    (
                      width: 95,
                      height: 4,
                      color: Colors.green,
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 400,
                      child: ListView.builder
                      (
                        itemCount: cart.items.length,
                        itemBuilder: (context,index){
                          final item =  cart.items[index];
                          return ListTile(
                            leading:Image.asset(item.image,
                            width: 50,
                            height : 50,
                            fit: BoxFit.cover,
                            ),                            
                            title: Text(item.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("₹${item.price}  * ${item.quantity}"),
                                DropdownButton<String>(value: item.weight, items : ["0.5kg" , "1kg"].map((String value){
                                  return DropdownMenuItem<String>(value: value, child: Text(value),);
                                }).toList(),
                                onChanged: (newvalue){
                                  if(newvalue != null){
                                    item.weight = newvalue;
                                    cart.notifyListeners();
                                  }
                                },),
                               ],),
                            trailing:Row( 
                              mainAxisSize: MainAxisSize.min,
                              children: [                    
                                IconButton(icon: Icon(Icons.remove_circle,color: Colors.red),
                                onPressed: (){
                                  Provider.of<CartProvider>(context,listen:false).decreaseQuantity(item);
                                }),
                                Text(item.quantity.toString(),style: TextStyle(fontSize: 16)),
                                IconButton(icon: Icon(Icons.add_circle,color: Colors.green),
                                onPressed: (){
                                  Provider.of<CartProvider>(context,listen:false).increaseQuantity(item);
                                }),
                                IconButton(icon: Icon(Icons.delete,color:Colors.red),                        
                                onPressed: (){
                                  Provider.of<CartProvider>(context,listen:false).removeProduct(item);
                                   Fluttertoast.showToast(
                                      msg: "${item.name} Removed to cart",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                      );
                                },)
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 10),
                Padding
                (
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Total: ₹${cart.totalPrice}",
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                ),
                ElevatedButton
                (
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(),)); 
                  }, 
                  style: ElevatedButton.styleFrom
                  (
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                  ),
                  child: Text("PROCEED TO CHECKOUT",style: TextStyle(color: Colors.white)),
                ),
            ],
           
          ),
        ),   
    ); 
  }
}
