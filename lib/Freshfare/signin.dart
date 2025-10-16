import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:freshfare/freshfare/orderhistory.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/notification.dart';
import 'package:freshfare/freshfare/cart.dart';


class SignPage extends StatefulWidget 
{
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage>
{
  final _formkey = GlobalKey<FormState>();
  final  namecontroller = TextEditingController();
  final  emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final  passwordcontroller =  TextEditingController();
  final  confirmcontroller = TextEditingController(); 

  
  final String baseUrl = "http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/";

  Future<void> signup() async{
    var url = Uri.parse("$baseUrl/signup.php");
    var response = await http.post(url, body:{
        "email":emailcontroller.text,
        "number":phonecontroller.text,
        "name":namecontroller.text,
        "password":passwordcontroller.text,
    });
    var data = json.decode(response.body);
      if(data['status'] == "Error"){
        Fluttertoast.showToast(
                    msg: "Database error: ${data['message'] ?? 'Unknown error'}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
      }
   else if (data['status'] == "Success" || data['status'] == "Exists") {
  SharedPreferences prefs = await SharedPreferences.getInstance();


  String signupId = data["signup_id"]?.toString() ?? "0";  

  print("DEBUG signupId from API: $signupId"); 
  await prefs.setString('userId', signupId);
      Fluttertoast.showToast(
          msg: data['status'] == "Success"
        ? "Registration Successful"
        : "User already exists, using existing account",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 3,
          textColor: Colors.white,
          fontSize: 16.0,
        ); 
        Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()),
        );
    }
  }

 
  bool passwordVisible=false;
  bool passwordVis=false;
  get validator => null;
  
  @override
  void initState()
  {
    super.initState();
    passwordVisible=true;
    passwordVis=true;
    Future(() async {
      await fetchData(); 
    });
  }  

  Future<void> fetchData() async {
    
    await Future.delayed(Duration(seconds: 2));
    print("Data fetched");
  }

  InputDecoration _inputDecoration() 
  {
    return const InputDecoration(
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), 
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
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


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar:AppBar
      (
        // automaticallyImplyLeading: false,
        title:Row
         (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Image.asset('assets/logo.png',
              height:50),
              SizedBox(width: 8),
              RichText(text: TextSpan
              (
                children: 
                [
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
                  TextSpan(text: 'resh',style:TextStyle(color:Colors.black,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
                  TextSpan(text: 'are',style: TextStyle(color:Colors.black,fontSize: 40,fontWeight: FontWeight.bold,fontFamily: "Poppins"),),
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
          ],
        ),
      ),
      body:SingleChildScrollView
      (
        child:Container
          (
            decoration:BoxDecoration(color: Colors.white,
            borderRadius: BorderRadius.circular(20), 
            boxShadow:[
            BoxShadow
            (
              color: Colors.black26,
              blurRadius: 7,
              spreadRadius: 6,
              offset: Offset( 0, 5,),
            ),
            ],
            ),
            margin: EdgeInsets.all(20.0),
            child: Form
            (
              key: _formkey,
              child:Padding
                (
                  padding: EdgeInsets.all(16.0),
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>
                    [
                      Text("Create  Account",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),     
                      SizedBox(height: 20),                
                      TextFormField
                      (                           
                        controller: namecontroller,
                        decoration:_inputDecoration().copyWith(
                                  labelText: 'username',prefixIcon: Icon(Icons.person)),
                        validator: (v) => v!.isEmpty ? "Enter name" : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField
                      (
                        controller: emailcontroller,
                        decoration: _inputDecoration().copyWith(
                                  labelText: 'Email',prefixIcon: Icon(Icons.email)),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            v!.isEmpty ? "Enter email" : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField
                      (                        
                        controller: phonecontroller,
                        decoration: _inputDecoration().copyWith(
                                  labelText: 'mobile',prefixIcon: Icon(Icons.phone)),
                        keyboardType: TextInputType.phone,
                        validator: (v) =>
                            v!.isEmpty ? "Enter mobile number" : null,
                      ),
                      SizedBox(height: 20),
                      TextFormField
                      (
                        obscureText: passwordVisible,
                        controller: passwordcontroller,
                        decoration: _inputDecoration().copyWith(
                        labelText: 'password',
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                              icon: Icon(passwordVisible? Icons.visibility: Icons.visibility_off),
                              onPressed: () 
                              {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                        alignLabelWithHint: false,
                        filled: true,
                        ),                               
                        validator : (value)
                        {
                            if(value == null || value.isEmpty)
                            {
                              return 'Password is required';
                            }
                            else if(value.length < 6){
                              return 'Minimum 6 characters or invlaid Password';
                            }   
                            else if(value.length >= 15){
                              return 'Miaximum 15 characters or invlaid Password';
                            }  
                            return null;
                        },                     
                      ),
                      SizedBox(height: 20),
                      TextFormField
                      (
                        obscureText: passwordVis,
                        controller: confirmcontroller,
                        decoration: _inputDecoration().copyWith(
                        labelText: 'confirm password',
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: IconButton(
                              icon: Icon(passwordVis ? Icons.visibility : Icons.visibility_off),
                              onPressed: ()
                              {
                                setState
                                (
                                  (){
                                  passwordVis = !passwordVis;
                                  },
                                );
                              },
                            ),
                        alignLabelWithHint: false,
                        filled: true,                     
                        ),
                        validator : (value)
                        {
                              if(value == null || value.isEmpty)
                              {
                                return 'Confirm password is required';
                              }
                              else if(value != passwordcontroller.text)
                              {
                                return 'Password does not match';
                              }   
                              return null;
                        },          
                      ),
                      SizedBox(height: 20),
                      ElevatedButton
                      (
                          style: ElevatedButton.styleFrom
                          (
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                          ),
                          ),
                          onPressed: (){
                            if (_formkey.currentState!.validate()) 
                            {
                              signup();
                            }
                          },                          
                          child: Text('Register', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                      ),
                      Row
                      (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: 
                        [
                            Text("Already have an account? "),
                            TextButton
                            (
                            onPressed: () 
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                            },
                            child:Text("Login here", style: TextStyle(color: Colors.blue),)
                            ),
                        ],
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