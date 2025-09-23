import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/adminorder.dart';
import 'package:freshfare/freshfare/viewcompany.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/enroll.dart';
import 'package:freshfare/freshfare/admin.dart';

class ViewcompanyPage extends StatefulWidget 
{
  const ViewcompanyPage({super.key});
  @override
  State<ViewcompanyPage> createState() => _ViewcompanyPageState();
}

class _ViewcompanyPageState extends State<ViewcompanyPage>
{

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
              onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn'); 
              await prefs.remove('userId');     

            
              Navigator.of(context).pop();
              
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
                title: const Text('Dashboard'),
                onTap: () {          
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage(),));               
                },
              ),
              ListTile
              (
                title: Text('View Registered Companies'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => ViewcompanyPage(),));
                },
             ),
              ListTile
              (
                title: Text('Enroll New Company'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => EnrollPage(),));
                },
             ),
             ListTile
              (
                title: Text('View Orders List'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminOrderPage(),));
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
    body: SingleChildScrollView
      (
        padding: EdgeInsets.all(16),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: 
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: 
              [
                Text("Registered Users",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,fontFamily: "Poppins",),),
              ],
            ),
            SizedBox(height:40),
            SingleChildScrollView
            (
              scrollDirection: Axis.horizontal, 
              child: Table
              (
                border: TableBorder.all(color: Colors.grey.shade400,width: 1,),
                columnWidths: const {
                  0: FixedColumnWidth(50), 
                  1: FixedColumnWidth(150), 
                  2: FixedColumnWidth(220), 
                  3: FixedColumnWidth(80),  
                  4: FixedColumnWidth(160), 
                  5: FixedColumnWidth(170),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: 
                [
                  TableRow
                  (
                    decoration: BoxDecoration(color: Colors.green.shade100),
                    children: const [
                      Padding(padding: EdgeInsets.all(8), child: Text(" # ", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Email", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Phone", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Category", style: TextStyle(fontWeight: FontWeight.bold))),
                      Padding(padding: EdgeInsets.all(8), child: Text("Action", style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

