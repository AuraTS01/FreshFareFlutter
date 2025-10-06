import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/admin.dart';
import 'package:freshfare/freshfare/adminorder.dart';
import 'package:freshfare/freshfare/register.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/enroll.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EnrollPage extends StatefulWidget 
{
  const EnrollPage({super.key});
  @override
  State<EnrollPage> createState() => _EnrollPageState();
}

class _EnrollPageState extends State<EnrollPage>
{
   final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  bool showPassword = false; 

  final List<String> items = [
    "Chicken",
    "Mutton",
    "Fish",
    "Prawn",
    "Kadai",
    "Mutton - Boti",
    "Mutton Liver",
    "Beef",
    "Beef Boti",
    "Beef Liver",
    "Duck",
  ];
  Map<String, bool> selectedItems = {};

  Map<String, bool> chickenSubItems = {
    "Chicken With Skin": false,
    "Chicken Without Skin": false,
  };

  void _generatePassword() {
    setState(() {
      _passwordController.text = "Password";
      showPassword = true; 
    });
  }

  void _enrollCompany() async 
  {
    if (_formKey.currentState!.validate())
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? signupId = prefs.getString("userId");
      print("Sending signupId to enroll: $signupId"); 

      final selected = selectedItems.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

      if (selectedItems["Chicken"] == true)
      {
        selected.addAll(chickenSubItems.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList());
      }

       String sellingItems = selected.join(",");

       print("POST body: { "
          "company_name: ${_nameController.text}, "
          "company_address: ${_addressController.text}, "
          "email: ${_emailController.text}, "
          "mobile: ${_mobileController.text}, "
          "selling_items: $sellingItems, "
          "signup_id: $signupId "
          "}");
                                                                                     

      var url = Uri.parse("http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/enroll.php");
      var response = await http.post(url, body: {
        "company_name": _nameController.text,
        "company_address": _addressController.text,
        "email": _emailController.text,
        "mobile": _mobileController.text,
        "selling_items": sellingItems,
        "signup_id": signupId ?? '',   
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data["status"] == "Success")
        {

          Fluttertoast.showToast(
            msg: "Enroll Company Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 3,
            textColor: Colors.white,
            fontSize: 16.0,
          ); 
        } 
        else
        {
          Fluttertoast.showToast(msg: data["message"]);
        }
      } 
      else 
      {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
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
     for (var item in items) {
      selectedItems[item] = false;
    }
  }

  InputDecoration _inputDecoration() 
  {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), 
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
    );
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
      body:SingleChildScrollView
      (
        child:Container
          (
            decoration:BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow:
            [
              BoxShadow
              (
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 4,
                offset: Offset( 0, 5,),
              ),
            ],
            ),
            margin: EdgeInsets.all(20.0),
            child: Form
            (
              key: _formKey,
              child:Padding
                (
                  padding: EdgeInsets.all(16.0),
                  child:Column 
                    (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: 
                      [
                        Container
                        (
                          width: double.infinity,  
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration
                          (
                            color: Colors.green, 
                            borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
                          ),                          
                          child: Text("           Enroll New Company",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,),),                   
                        ),                 
                        SizedBox(height:20),
                        Text("Company Name",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        TextFormField
                        (
                          controller: _nameController,
                          decoration:_inputDecoration(),
                          validator: (v) => v!.isEmpty ? "Enter company name" : null,
                        ),
                        SizedBox(height:15),
                        Text("Company Address",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        TextFormField
                        (
                          controller: _addressController,
                          decoration: _inputDecoration(),
                          maxLines: 2,
                          validator: (v) => v!.isEmpty ? "Enter address" : null,
                        ),
                        SizedBox(height:15),
                        Text("Company Sells:",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Column
                        (
                          children: items.map((item) 
                          {
                            return Column
                            (
                              children: 
                              [
                                CheckboxListTile
                                (
                                  title: Text(item),
                                  value: selectedItems[item],
                                  onChanged: (val) {
                                    setState(() 
                                    {
                                      selectedItems[item] = val!;
                                      if (!val && item == "Chicken") {
                                        chickenSubItems.updateAll((key, value) => false);
                                      }
                                    });
                                  },
                                ),
                                if(item == "Chicken" && selectedItems["Chicken"] == true)
                                Padding
                                (
                                  padding: const EdgeInsets.only(left: 32),
                                  child: Column
                                  (
                                    children: chickenSubItems.keys.map((subItem) 
                                    {
                                      return CheckboxListTile
                                      (
                                        title: Text(subItem),
                                        value: chickenSubItems[subItem],
                                        onChanged: (val) 
                                        {
                                          setState(() {
                                            chickenSubItems[subItem] = val!;
                                          });
                                        },
                                      );
                                    }
                                    ).toList(),
                                  ),
                                )
                              ],
                            );
                          }
                          ).toList(),
                        ),
                        SizedBox(height:15),
                        Text("Email",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        TextFormField
                        (
                          controller: _emailController,
                          decoration: _inputDecoration(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) =>
                              v!.isEmpty ? "Enter email" : null,
                        ),
                        SizedBox(height:15),                       
                        Text("Mobile Number",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        TextFormField
                        (
                          controller: _mobileController,
                          decoration: _inputDecoration(),
                          keyboardType: TextInputType.phone,
                          validator: (v) =>
                              v!.isEmpty ? "Enter mobile number" : null,
                        ),
                        SizedBox(height:15),                     
                        Text("Password",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Column
                        (
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: 
                          [
                            TextFormField
                            (
                              controller: _passwordController,
                              obscureText: !showPassword,
                              decoration: _inputDecoration(),
                              validator: (v) => v!.isEmpty ? "Enter password" : null,
                            ),     
                            ElevatedButton
                            (
                              onPressed: _generatePassword,
                              style: ElevatedButton.styleFrom
                              (
                                backgroundColor: Colors.grey,
                                shape: const RoundedRectangleBorder
                                (
                                  borderRadius: BorderRadius.only
                                  (
                                      bottomLeft: Radius.circular(4),
                                      bottomRight: Radius.circular(4),
                                  ),
                                ),
                              ),
                              child: const Text("Generate Default Password",style:TextStyle(color:Colors.white)),
                            ),
                          ],
                        ),
                        SizedBox(height:20),
                        Center
                        (
                          child: ElevatedButton
                          (
                            onPressed:_enrollCompany,
                            style: ElevatedButton.styleFrom
                            (
                                          backgroundColor: Colors.blue,
                                          shape: RoundedRectangleBorder
                                          (
                                            borderRadius: BorderRadius.circular(0),
                                          ),
                            ),
                            child: Text("Enroll Company",style:TextStyle(color:Colors.white)),
                          ),
                        ),
                      ],
                    ),
                ),
            ),
          ),
      ),
    );
  }
}

