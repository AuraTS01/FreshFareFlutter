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
import 'package:freshfare/freshfare/orderhistory.dart';


class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> 
{

  final  pincodecontroller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey butcherShopKey = GlobalKey();

  String ? selecteditem;
  final items =['Chicken','Mutton','Fish','Prawns','Mutton - Boti','Mutton - Liver','Beef','Beef - Liver','Beef - Boti','Quail','Duck'];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchCompanies();
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
            TextButton
            (
              onPressed: () async 
              {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();    
                setState(() {
                  userName = '';
                  userEmail = '';
                });
                Navigator.of(context).pop();
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
  Future<void> checkPincode() async 
  {
    String pincode = pincodecontroller.text.trim();

    if (pincode.isEmpty) 
    {
      Fluttertoast.showToast
      (
        msg: "Please enter your pincode",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );           
      return;
    }

    try 
    {
      var response = await http.post(
        Uri.parse("http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/pincode.php"),
        body: {"pincode": pincode},
      );
      var data = json.decode(response.body);
      if (data["status"] == "success") 
      {
        Fluttertoast.showToast
        (
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        ); 
        Navigator.pop(context); 
      } 
      else 
      {
        Fluttertoast.showToast
        (
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
          Column
          (
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
          actions: 
          [
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
    await Future.delayed(const Duration(milliseconds: 100));
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
    });
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


  Future<void> showProductDialog(String companyId, String companyName) async 
  {
       // List<dynamic> products = [];

    // try 
    // {
      // final response = await http.post(
      //   Uri.parse("http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/get_products.php"),
      //   body: {'company_id': companyId},
      // );



    //   if (response.statusCode == 200) 
    //   {
    //     products = json.decode(response.body);
    //     print("Sending company_id: $companyId");
    //   }
    // } 
    // ca1
    //.0tch (e) 
    // {+
    //   print("Error fetching products: $e");
    // }
  // void showProductDialog(BuildContext context)
  // {
    final company = companies.firstWhere(
      (c) => c['company_id'].toString() == companyId.toString(),
      orElse: () => {},
    );

    
    final sellingItems = (company['selling_items'] ?? '')
        .toString()
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
        
    showDialog
    (
      context: context,
      builder: (BuildContext context) 
      {
        final Set<String> addedItems = {};
        return StatefulBuilder
        (
          builder: (context, setDialogState) 
          {
            return AlertDialog
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
              title: Text(companyName,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              content: SizedBox
              (
                width: double.maxFinite,
                height: 400,
                child:Column
                (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: 
                  [
                    Text("Note: You can Change / Modify the Quantity in Cart / View Cart Page",style: TextStyle(fontSize: 14, color: Colors.black54)), 
                    Expanded
                    (
                      child: sellingItems.isEmpty ? const Center(child: Text("No products available"))
                      : ListView.builder
                      (
                        itemCount: sellingItems.length,
                        itemBuilder: (context, index) 
                        {
                          final product = sellingItems[index];
                          final isAddedToCart = addedItems.contains(product);
                          return Card
                          (
                            shape: RoundedRectangleBorder
                            (
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 2,                            
                            child : Column
                            (           
                              children: 
                              [
                                ClipRRect
                                (
                                  borderRadius: BorderRadius.circular(10),
                                  child: Icon(Icons.fastfood, color: Colors.green),
                                  // child: Image.asset("assets/prawns.png",height: 150,width: double.infinity,fit: BoxFit.cover,),
                                ),
                                SizedBox(height: 8),
                                Text(product,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 4),
                                Text("₹ / KG",style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 8),
                                ElevatedButton.icon
                                (
                                  style: ElevatedButton.styleFrom
                                  (
                                    backgroundColor:Colors.green,
                                    shape: RoundedRectangleBorder
                                    (
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: ()  
                                  {
                                    if (isAddedToCart) 
                                    {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => const CartPage()),);
                                    } 
                                    else 
                                    {
                                      final cartProvider =Provider.of<CartProvider>(context, listen: false);

                                      final productItem = Product
                                      (
                                        name: product,
                                        baseprice: 0.0,
                                        image: "assets/logo.png",
                                      );

                                      cartProvider.addProduct(productItem);

                                      Fluttertoast.showToast
                                      (
                                        msg: "$product added to cart",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.green,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );

                                      setDialogState(() 
                                      {
                                        addedItems.add(product);
                                      });
                                    }
                                  },
                                icon: Icon(isAddedToCart ? Icons.shopping_cart : Icons.add_shopping_cart, color: Colors.white),
                                label: Text(isAddedToCart ? "View Cart" : "Add to Cart",style: TextStyle(color: Colors.white),),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: 
              [
                TextButton
                (
                  onPressed: () => Navigator.pop(context),
                  child: Text("Close"),
                ),
              ],
            );
          },
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
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,),),
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
                leading: const Icon(Icons.auto_stories_outlined),
                title: const Text('Order History'),
                onTap: () {   
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage(),));                    
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
              Text("Please allow location access to check delivery availabity in your area.",style: TextStyle(fontSize: 15),),
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
                      if(value == "Choose Your Butcher Shops")
                      {
                        // setState(() {
                        // selecteditem = value ;
                        // });                        
                        // navigate(value);                        
                          Scrollable.ensureVisible(
                            butcherShopKey.currentContext!,
                            duration: const Duration(milliseconds: 500),
                          );
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
              companies.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder
                (
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: companies.length,
                  itemBuilder: (context, index) {
                    final company = companies[index];
                    return Card
                    (
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding
                      (
                        padding: const EdgeInsets.all(12.0),
                        child: Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: 
                          [
                            Row
                            (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: 
                              [                             
                                Image.asset('assets/logo.png',height:45),
                                SizedBox(width: 12),
                                Expanded
                                (
                                  child: Column
                                  (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:
                                    [
                                      Text(company['company_name'],style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                                      SizedBox(height: 4),
                                      Text(company['email'],style: const TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Align
                            (
                              alignment: Alignment.center,
                              child: ElevatedButton
                              (
                                style: ElevatedButton.styleFrom
                                (
                                  backgroundColor: Colors.blue,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                                ),
                                onPressed: () 
                                {
                                  showProductDialog(company['company_id'],company['company_name'],);
                                },
                                child : Text("View Products",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),         
            ],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
          ),
        ),
    );
  }
}
