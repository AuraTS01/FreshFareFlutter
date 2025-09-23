import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/notification.dart';
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

   Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
    });
  }


  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? '';
      userPhone = prefs.getString('userPhone') ?? '';
      userEmail = prefs.getString('userEmail') ?? '';
    
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
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
                   style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30,fontFamily: "Poppins"),),
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
                ],
              ),
            ),
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

