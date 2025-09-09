import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/cartmodel.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrawnsPage extends StatefulWidget {
  const PrawnsPage({super.key, required String selecteditem});

  @override
  State<PrawnsPage> createState() => _PrawnsPageState();
}

class _PrawnsPageState extends State<PrawnsPage> {
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

   final List<Product> products = [
                  Product(name:"Prawns", baseprice: 400.0, image:"assets/prawns.png"),              
                  Product(name:"Shrimp", baseprice: 350.0, image:"assets/Shrimp.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar
          (
               title:
               Row
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
              SizedBox(height: 30),
              Column
                (
                  children: 
                  [
                    Text("Prawns",style: TextStyle(
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold, ),),
                    SizedBox(height: 5),
                    Container
                    (
                      width: 30,
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

  Widget productCard(BuildContext context,Product product)
  {
    return  Card(
       child:Column
        (
        children: 
        [
          Image.asset(product.image,height: 150,fit: BoxFit.cover),
          Text(product.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
          Text("₹${product.price}"),
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