
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
                      child: cart.items.isEmpty
                      ? const Center(
                          child: Text(
                            "🛒 Your cart is empty",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : ListView.builder
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
                Align(
                alignment: Alignment.centerLeft,
                child:ElevatedButton
                (
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),)); 
                  }, 
                  style: ElevatedButton.styleFrom
                  (
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    shape: RoundedRectangleBorder
                        (
                          borderRadius: BorderRadius.circular(0),
                        ),
                  ),
                  child: Text("CONTINUE SHOPPING",style: TextStyle(color: Colors.white)),
                ),  
                ),            
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
                    shape: RoundedRectangleBorder
                            (
                              borderRadius: BorderRadius.circular(0),
                            ),
                  ),
                  child: Text("PROCEED TO CHECKOUT",style: TextStyle(color: Colors.white)),
                ),
            ],           
          ),
        ),  
    ); 
  }
}
