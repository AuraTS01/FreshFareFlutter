import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/admin.dart';
import 'package:freshfare/freshfare/adminorder.dart';
import 'package:freshfare/freshfare/viewcompany.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/enroll.dart';

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

  // Checkbox options
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


  void _generatePassword() {
    setState(() {
      _passwordController.text = "Password"; // Example default password
    });
  }

  void _enrollCompany() {
    if (_formKey.currentState!.validate()) {
      final selected = selectedItems.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

      print("Company Name: ${_nameController.text}");
      print("Address: ${_addressController.text}");
      print("Email: ${_emailController.text}");
      print("Mobile: ${_mobileController.text}");
      print("Password: ${_passwordController.text}");
      print("Sells: $selected");
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
          ],
        ),
      ),
     body:SingleChildScrollView
      (
        child:Container
          (
            decoration:BoxDecoration(color: Colors.white,
            boxShadow:[
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                child:Text("Enroll New Company",style:TextStyle(color:Colors.black,fontSize:20,fontWeight:FontWeight.bold)),
                ),
                SizedBox(height:20),
                Text("Company Name"),
                TextFormField(
                  controller: _nameController,
                  validator: (v) => v!.isEmpty ? "Enter company name" : null,
                ),
               SizedBox(height:20),
                Text("Company Address"),
                TextFormField(
                  controller: _addressController,
                  maxLines: 2,
                  validator: (v) => v!.isEmpty ? "Enter address" : null,
                ),
                SizedBox(height:20),

                Text("Company Sells:"),
                Column(
                  children: items.map((item) {
                    return CheckboxListTile(
                      title: Text(item),
                      value: selectedItems[item],
                      onChanged: (val) {
                        setState(() {
                          selectedItems[item] = val!;
                        });
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height:20),
                Text("Email"),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) =>
                      v!.isEmpty ? "Enter email" : null,
                ),
               SizedBox(height:20),
                Text("Mobile Number"),
                TextFormField(
                  controller: _mobileController,
                  keyboardType: TextInputType.phone,
                  validator: (v) =>
                      v!.isEmpty ? "Enter mobile number" : null,
                ),
               SizedBox(height:20),
                Text("Password"),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (v) =>
                            v!.isEmpty ? "Enter password" : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _generatePassword,
                      child: Text("Generate Default Password"),
                    ),
                  ],
                ),
               SizedBox(height:20),

                Center(
                  child: ElevatedButton(
                    onPressed: _enrollCompany,
                     style: ElevatedButton.styleFrom(
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

