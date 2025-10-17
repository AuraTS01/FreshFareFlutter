import 'dart:convert';
import 'package:freshfare/Freshfare/profile.dart';
import 'package:http/http.dart' as http;
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
import 'package:freshfare/freshfare/orderhistory.dart';

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
   String ? selecteditem;
  final items =['Chicken','Mutton','Fish','Prawns','Mutton - Boti','Mutton - Liver','Beef','Beef - Liver','Beef - Boti','Quail','Duck'];

  String userName = '';
  String userEmail = '';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') != null &&
           prefs.getString('userEmail')!.isNotEmpty;
  }

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

  List<dynamic> companies = [];

  Future<void> fetchCompanies() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/get_companies.php"),
      );

      if (response.statusCode == 200) {
        setState(() {
          companies = json.decode(response.body);
        });
      }
    } catch (e) {
      print("Error fetching companies: $e");
    }
  }

  int _selectedIndex = 0;

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
        child: ListView
        (  
          children: 
          [
            // Row
            // (
            //   children: 
            //   [
            //     Expanded
            //     (
            //       child: TextField
            //       (
            //         controller:searchcontroller,
            //         decoration: InputDecoration
            //         (
            //           hintText: 'what do you need?',
            //           border: OutlineInputBorder(),
                      
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 10),
            //     SizedBox(
            //       width: 120.0,
            //       height: 45.0,
            //     child:ElevatedButton
            //     (
                  
            //       style: ElevatedButton.styleFrom
            //       (
            //         backgroundColor: Colors.green,
            //         shape: RoundedRectangleBorder
            //         (
            //           borderRadius: BorderRadius.circular(0),
            //         ),
            //       ),
            //       onPressed:search,
            //       child: Text('search',style: TextStyle(color: Colors.white),),
            //     ),
            //     ),
            //   ],
            // ),
            SizedBox(height: 20),
            Container
            (
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration
              (
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline
              (
                child: DropdownButton
                (
                  value: selecteditem,
                  hint: Text("All Items",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
                  items: items.map((String value)
                  {
                    return DropdownMenuItem<String>
                    (
                      value: value,
                      child:Text(value,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500)),
                    );
                  }).toList(),
                  onChanged:(value)
                  {
                    if(value == "Choose Your Butcher Shops")
                    {
                      // setState(() {
                      // selecteditem = value ;
                      // });                        
                      // navigate(value);                        
                        // Scrollable.ensureVisible(
                        //   butcherShopKey.currentContext!,
                        //   duration: const Duration(milliseconds: 500),
                        // );
                    }    
                  },
                ),
              ),
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
                    Text('support 24/7 time'),
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
                SizedBox
                (
                  height: 400,
                  child: cart.items.isEmpty ? const Center
                  (
                    child: Text("🛒 Your cart is empty",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black,),),
                  )
                  : ListView.builder
                  (
                    itemCount: cart.items.length,
                    itemBuilder: (context,index)
                    {
                      final item =  cart.items[index];                   
                      return Column
                      (
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: 
                        [
                          Padding
                          (
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Text("${item.companyName ?? 'Unknown'}",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding
                          (
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            child: Row
                            (                             
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: 
                              [                              
                                Image.asset(item.image,width: 60,height: 60,fit: BoxFit.cover,),
                                SizedBox(width: 8),
                                Expanded
                                (
                                  child: Column
                                  (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: 
                                    [
                                      Text
                                      (
                                        item.name,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        maxLines: 1,overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text("₹${item.price}  × ${item.quantity}",style: const TextStyle(fontSize: 14),),
                                      const SizedBox(height: 4),
                                      DropdownButton<String>
                                      (
                                        value: item.weight,
                                        items: ["0.5kg", "1kg"].map((String value) 
                                        {
                                          return DropdownMenuItem<String>
                                          (
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (newValue) 
                                        {
                                          if (newValue != null) 
                                          {
                                            item.weight = newValue;
                                            cart.notifyListeners();
                                          }
                                        },
                                        isDense: true,
                                        underline: Container(height: 1, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),         
                                Column
                                (
                                  children:
                                  [
                                    Row
                                    (
                                      mainAxisSize: MainAxisSize.min,
                                      children: 
                                      [
                                        IconButton
                                        (
                                          icon:Icon(Icons.remove_circle, color: Colors.red),
                                          onPressed: () 
                                          {
                                            Provider.of<CartProvider>(context, listen: false)
                                                .decreaseQuantity(item);
                                          },
                                        ),
                                        Text(item.quantity.toString(),style: const TextStyle(fontSize: 16),),
                                        IconButton
                                        (
                                          icon: const Icon(Icons.add_circle, color: Colors.green),
                                          onPressed: () 
                                          {
                                            Provider.of<CartProvider>(context, listen: false)
                                                .increaseQuantity(item);
                                          },
                                        ),
                                      ],
                                    ),
                                    ElevatedButton
                                    (
                                      onPressed: () 
                                      {
                                        Provider.of<CartProvider>(context, listen: false)
                                            .removeProduct(item);
                                        Fluttertoast.showToast
                                        (
                                          msg: "${item.name} removed from cart",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom
                                      (
                                        backgroundColor: Colors.red,
                                        // padding: EdgeInsets.symmetric(vertical: 15),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                      ),
                                      child: Text("Remove",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: 30),
            Align
            (
              alignment: Alignment.centerLeft,
              child:ElevatedButton
              (
                onPressed: ()
                {
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
            Divider(height: 30),
            Container
            (
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration
              (
                color: Colors.grey[100],
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column
              (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: 
                [
                  Text("Cart Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                    [
                      Text("Total (Incl GST)", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("₹${(cart.totalPrice * 1.05).toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Note: Total Cart Value will be displayed in the checkout page."),
                  Text("Note: GST (Goods and Services Tax) of 5% is included in the total price."),
                  SizedBox(height: 16),
                  SizedBox
                  (
                    width: double.infinity,
                    child: ElevatedButton
                    (
                      onPressed: () async
                      {
                        bool loggedIn = await isLoggedIn();
                        if (loggedIn) 
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(),)); 
                        }
                        else 
                        {                            
                          Fluttertoast.showToast
                          (
                            msg: "Please Login First to Proceed",
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            gravity: ToastGravity.CENTER,
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),)); 
                        }                  
                      }, 
                      style: ElevatedButton.styleFrom
                      (
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      ),
                      child: Text("PROCEED TO CHECKOUT",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ),             
          ],           
        ),
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
