import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/cartprovider.dart';
import 'package:freshfare/Freshfare/orderhistory.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfilePage extends StatefulWidget 
{
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
{

  String userName = '';
  String userEmail = '';
  String userPhone = '';
   String billingAddress = '';
  String billingTown = '';
  String billingState = '';

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userPhone = prefs.getString('userPhone') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
      billingAddress = prefs.getString('billingAddress') ?? '';
      billingTown = prefs.getString('billingTown') ?? '';
      billingState = prefs.getString('billingState') ?? '';
    
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }
  
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CurvedHeaderClipper(),
                child: Container(
                  height: 200,
                  color: Colors.green,
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: CircleAvatar(
                     radius: 40,
                    backgroundColor: Colors.white,
                   child: Text(userName.isNotEmpty ? userName[0] : '?',
                   style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30,),),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileItem(Icons.person, "Name", userName),
                  SizedBox(height: 20), 
                  profileItem(Icons.phone, "Phone", userPhone),
                  SizedBox(height: 20),        
                  profileItem(Icons.email, "Email", userEmail),
                  SizedBox(height: 20),        
                  profileItem(Icons.home, "Address", billingAddress),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar
      (
        currentIndex: _selectedIndex,
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
          }
        },
        items: const 
        [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
  Widget profileItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 28, color: Colors.green),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )),
            SizedBox(height: 3),
            Text(value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                )),
          ],
        ),
      ],
    );
  }
}
class CurvedHeaderClipper extends CustomClipper<Path> 
{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 60);
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height - 60);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}

