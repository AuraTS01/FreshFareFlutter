import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:freshfare/freshfare/prawns.dart';
import 'package:freshfare/freshfare/profile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String ? selecteditem;
  final items =['Chicken','Mutton','Fish','Prawns'];

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

  bool showButton = false;

  void toggleButton(){
    setState(() {
      showButton = !showButton;
    });
  }

  
  String message = '';

  final allowedLocations = [
    {'lat': 11.289087, 'lng': 76.940971}, // Location 1 Mettupalayam
    {'lat': 11.238106, 'lng': 76.961426}, // Location 2 Karamadai
  ];

  double allowedRadius = 5.0; // in km

  @override
  void initState() {
    super.initState();
    checkUserLocation();
    _loadUserData();
  }

  Future<void> checkUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        message = "Location services are disabled.";
      });
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          message = "Location permissions are denied.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        message = "Location permissions are permanently denied.";
      });
      return;
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    bool isInAllowedArea = false;

    for (var loc in allowedLocations) {
      double distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        loc['lat']!,
        loc['lng']!,
      );
      double distanceInKm = distanceInMeters / 1000;

      if (distanceInKm <= allowedRadius) {
        isInAllowedArea = true;
        break;
      }
    }

    setState(() {
      if (isInAllowedArea) {
        Fluttertoast.showToast(
                msg: "✅ You can place an order.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0,
              );
        
      } else {
        Fluttertoast.showToast(
                msg: "🚫 Sorry, orders are not available in your location.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
      }
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
  Widget build(BuildContext context) 
  {
    return  Scaffold
    (
       appBar: AppBar
       (
          title:Row
          (
            mainAxisAlignment: MainAxisAlignment.start,
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
              Text("Please allow location access to check delivery availabity in your area"),
              SizedBox
              (
                width: 0.0,
                height: 30.0,
                child:ElevatedButton
                  (
                    style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder
                              (
                                borderRadius: BorderRadius.circular(0),
                              ),
                              ),
                    onPressed: checkUserLocation,                    
                    child:Text("change location", style: TextStyle(color: Colors.white),)
                  ),
              ),
              SizedBox(height: 30),
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
                    hint: Text("All Items"),
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
                  Text("Order  Products",style: TextStyle(
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
              SizedBox(height: 40),
              Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/prawns.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("  Prawns \n ₹ 400.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ], 
              ),
              SizedBox(height: 40),
              Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/fish.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (              
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("    Fish  \n ₹ 200.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),  
                ],
              ),
              SizedBox(height: 40),
              Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/chicken_flesh.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Chicken_Flesh \n     ₹ 220.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
             SizedBox(height: 40),
             Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/chicken_2.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("  Chicken \n ₹ 260.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 40),
              Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/chicken_withoutSkin.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Chicken_withoutSkin \n        ₹ 300.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 40),
              Stack
              (
                children: 
                [
                  GestureDetector
                  (
                    onTap: toggleButton,
                    child: Image.asset('assets/Shrimp.png',
                    width: 700,
                    height: 300,
                    fit: BoxFit.cover,     
                    ),
                  ),
                  if(showButton)
                    Positioned
                    (
                      bottom: 10,
                      left: 170,
                      child: ElevatedButton
                      (
                        style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                        onPressed: (){},
                        child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                        
                      ),
                    ),      
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Shrimp \n₹ 350.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 40),
              Stack
                (
                  children: 
                  [
                    GestureDetector
                    (
                      onTap: toggleButton,
                      child: Image.asset('assets/fresh_raw_mutton_leg.png',
                      width: 700,
                      height: 300,
                      fit: BoxFit.cover,     
                      ),
                    ),
                    if(showButton)
                      Positioned
                      (
                        bottom: 10,
                        left: 170,
                        child: ElevatedButton
                        (
                          style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder
                                  (
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  ),
                          onPressed: (){},
                          child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
                          
                        ),
                      ),      
                  ],
                ),
             SizedBox(height: 20),
             Row
             (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Mutton_Leg \n ₹ 800.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ], 
              ),
            ],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
          ),
        ),
    );
  }
}