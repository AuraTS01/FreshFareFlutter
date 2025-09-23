import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/cartmodel.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:freshfare/freshfare/prawns.dart';
import 'package:freshfare/freshfare/profile.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final  pincodecontroller = TextEditingController();

  String ? selecteditem;
  final items =['Chicken','Mutton','Fish','Prawns','Mutton - Boti','Mutton - Liver','Beef','Beef - Liver','Beef - Boti','Quail','Duck'];
  void navigate(String value)
  {
    if(value == 'Chicken'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => ChickenPage(selecteditem: '',),));
    }
    else if(value == 'Fish'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => FishPage(selecteditem: '',),),);
    }
    else if(value == 'Prawns'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => PrawnsPage(selecteditem: '',),),);
    }
    else if(value == 'Mutton'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => MuttonPage(selecteditem: '',),),);
    }
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
              await prefs.remove('userName');     

            
              Navigator.of(context).pop();
              
              // Navigator.of(context).pop();

              
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
  Future<void> checkPincode() async {
    String pincode = pincodecontroller.text.trim();

    if (pincode.isEmpty) {
      Fluttertoast.showToast(
              msg: "Please enter your pincode",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
              );           
      return;
    }

    try {
      var response = await http.post(
        Uri.parse("http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/pincode.php"),
        body: {"pincode": pincode},
      );

      var data = json.decode(response.body);
      if (data["status"] == "success") {
              Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
              ); 
              Navigator.pop(context); 
      } else {
         Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
              ); 
              Navigator.pop(context); 
      }
     
    } catch (e) {
      Fluttertoast.showToast(
              msg: "Something went wrong. Try again later.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
              );
    }
  }

  void _showLocationDialog(BuildContext context)
  {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enter Your Pincode"),
          content: 
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Location access was denied. Please enter your area pincode to check delivery availability.",
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 15),
              TextField(
                controller: pincodecontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "e.g., 641301",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                pincodecontroller.clear(); 
                Navigator.pop(context); 
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: ()
              {
                checkPincode();
                pincodecontroller.clear(); 
              },
              child: Text("Check",style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
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

 final List<Product> products = [
                  Product(name:"Prawns", baseprice: 400.0, image:"assets/prawns.png"),
                  Product(name:"Fish", baseprice: 200.0, image: "assets/fish.png"),
                  Product(name:"Chicken_Flesh", baseprice: 300.0, image:"assets/chicken_flesh.png"),
                  Product(name:"Chicken_Without_Skin", baseprice: 250.0, image:"assets/chicken_withoutSkin.png"),
                  Product(name:"Chicken", baseprice: 300.0, image:"assets/chicken_2.png"),
                  Product(name:"Mutton", baseprice: 800.0, image:"assets/fresh_raw_mutton_leg.png"),
                  Product(name:"Shrimp", baseprice: 350.0, image:"assets/Shrimp.png"),
  ];


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
                accountName: Text(userName.isNotEmpty ? "Hello $userName" : "Hello Guest"),
                accountEmail: Text(userEmail),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(userName.isNotEmpty ? userName[0] : '?',
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Poppins"),),
                  ),
              ),
              ListTile
              (      
                leading: const Icon(Icons.person),              
                title: const Text('My profile'),
                onTap: () {          
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));               
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
        body: Padding
        (
          padding: EdgeInsets.all(16.0),
          child: ListView
          (
            children: 
            [
              Text("Please allow location access to check delivery availabity in your area.",style: TextStyle(fontSize: 14),),
              SizedBox(height: 10),             
              Align
              (
                alignment: Alignment.center,              
                child:ElevatedButton
                  (
                    style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder
                              (
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              ),
                    onPressed:  () async{   
                      _showLocationDialog(context);                  
                        },                    
                    child:Text("Change Location", style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold))
                  ),
              ),
              SizedBox(height: 40),
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
                    value:selecteditem,
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
                        if(value != null)
                        {
                          setState(() {
                          selecteditem = value ;
                          });
                        
                          navigate(value);
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
                  Text("Choose Your Butcher Shops",style: TextStyle(
                  color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold, ),),
                  SizedBox(height: 5),
                  Container
                  (
                    width: 95,
                    height: 4,
                    color: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 30),
              ListView.builder
              (
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), 
                itemCount: products.length,
                itemBuilder: (context, index) 
                {
                  final product = products[index];
                  return Container(
                    // color: Colors.white,
                    child: productCard(context, product),
                  );
                },
              ),
            ],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
          ),
        ),
    );
  }

  Widget productCard(BuildContext context,Product product){
    return  Card(
       child:Column
        (
        children: 
        [
          Image.asset(product.image,height: 150,fit: BoxFit.cover),
          Text(product.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          Text("₹${product.price} / KG"),
          ElevatedButton.icon
          (
            style: ElevatedButton.styleFrom
            (
              backgroundColor: Colors.green, 
              shape: RoundedRectangleBorder
                        (
                          borderRadius: BorderRadius.circular(0),
                        ),                             
            ),
            onPressed: ()
            {
              if(product.isAdded){             
                 Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),)); 
              }
              else{
                Provider.of<CartProvider>(context,listen:false).addProduct(product);
                setState((){
                  product.isAdded = true;
                });
              }
              Fluttertoast.showToast(
              msg: "${product.name} Added to cart",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
              );           

            },
            icon:Icon(product.isAdded ?  Icons.shopping_cart : Icons.add_shopping_cart,color: Colors.white),
            label: Text(product.isAdded ? "View Cart" : "Add to Cart",style: TextStyle(color: Colors.white)),
          )
        ],
        ),
    );

  }
}
