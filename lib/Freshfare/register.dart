import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/adminorder.dart';
import 'package:freshfare/freshfare/register.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/enroll.dart';
import 'package:freshfare/freshfare/admin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget 
{
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
{

  String userName = '';
  String userEmail = '';

  List<dynamic> users = [];  

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
    _fetchUsers();
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

  Future<void> _fetchUsers() async 
  {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/register.php"),
      );
      if (response.statusCode == 200) {
        setState(() {
          var allUsers = json.decode(response.body) as List;
          users = allUsers.where((user) {
          final category = (user['category'] ?? '').toString().toLowerCase();
          return category != "admin";
        }).toList();
      });
      } else {
        Fluttertoast.showToast(msg: "Failed to load users");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  void _categoryDialog(BuildContext context, Map<String, dynamic> user) 
  {
    TextEditingController nameController = TextEditingController(text: user['name']);
    TextEditingController phoneController = TextEditingController(text: user['phone']);
    String? selectedCategory = user['category'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          titlePadding: EdgeInsets.zero,
          title: Container
          (
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration
            (
              color: Colors.green, 
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text("Update User Info",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,),),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Name", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                    controller:nameController,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  ),
                ),
                SizedBox(height: 15),
                Text("Phone", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                    controller:phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  ),
                ),
                SizedBox(height: 15),
                Text("Category", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: ["company", "customer", "delivery agent"]
                      .map((cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedCategory = value;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed:() async {
              if (selectedCategory != null) {
                await _updateCategory(
                  user['id'].toString(),
                  selectedCategory!,
                  user['source'],
                );
                Navigator.pop(context);
                _fetchUsers(); 
              } else {
                Fluttertoast.showToast(msg: "Please select a category");
              }
            },
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateCategory(String id, String category, String source) async {
  try {
    final response = await http.post(
      Uri.parse("http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/CategoryUpdate.php"),
      body: {
        "id": id,
        "category": category,
        "source": source,  // pass origin
      },
    );

    final result = json.decode(response.body);
    if (result["success"] == true) {
      Fluttertoast.showToast
      (
        msg: "Category updated successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _fetchUsers(); 
    } else {
      Fluttertoast.showToast(msg: "Failed: ${result["message"]}");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Error: $e");
  }
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
                title: const Text('Dashboard'),
                onTap: () {          
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage(),));               
                },
              ),
              ListTile
              (
                title: Text('View Registered Companies'),
                onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
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
                  0: FixedColumnWidth(50),  //#
                  1: FixedColumnWidth(150), //Name
                  2: FixedColumnWidth(250), //Email
                  3: FixedColumnWidth(110),  //phone
                  4: FixedColumnWidth(160), //category
                  5: FixedColumnWidth(200), //Action
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
                  ...users.asMap().entries.map((entry) {
                    int index = entry.key + 1;
                    var user = entry.value;
                    return TableRow(
                      children: [
                        Padding(padding: EdgeInsets.all(8), child: Text(index.toString())),
                        Padding(padding: EdgeInsets.all(8), child: Text(user['name'] ?? '')),
                        Padding(padding: EdgeInsets.all(8), child: Text(user['email'] ?? '')),
                        Padding(padding: EdgeInsets.all(8), child: Text(user['phone'] ?? '')),
                        Padding(padding: EdgeInsets.all(8), child: Text(user['category'] ?? '')),
                        Padding
                        (
                          padding: EdgeInsets.all(8), 
                          child : ElevatedButton
                          (
                            style: ElevatedButton.styleFrom
                            (
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                            ),
                            ),
                            onPressed: ()async {   
                             _categoryDialog(context, user);                  
                            },              
                            child: Text("Change Category",style:TextStyle(color:Colors.white))
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

