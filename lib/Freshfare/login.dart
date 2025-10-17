import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/delivery.dart';
import 'package:freshfare/freshfare/company.dart';
import 'package:freshfare/freshfare/admin.dart';
import 'package:freshfare/freshfare/signin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  final _formkey = GlobalKey<FormState>();
  final  emailcontroller = TextEditingController();
  final  passwordcontroller =  TextEditingController();

  String category = '';

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      category = prefs.getString('category') ?? '';
    });
  }


  final String baseUrl = "http://192.168.86.9/FreshFareFlutter/lib/freshfare_database/";

  Future<void> login() async{
    var url = Uri.parse("$baseUrl/login.php");
    var response = await http.post(url, body:{
        "email":emailcontroller.text,
        "password":passwordcontroller.text,
        
    });
    var data = json.decode(response.body);
      if(data['status'] == "Success")
      {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userName', data["username"]);
        await prefs.setString('userPhone', data['number']);
        await prefs.setString('userEmail', data["email"]);
        await prefs.setString('category', data['category']);
        await prefs.setString('userId', data["signup_id"].toString());
    
       

       if (data['category'] == "customer") {
          Fluttertoast.showToast(
            msg: "Login Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (data['category'] == "delivery agent") {
          Fluttertoast.showToast(
            msg: "Login Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DeliveryPage()),
          );
        }
         else if (data['category'] == "company") {
          Fluttertoast.showToast(
            msg: "Login Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CompanyPage()),
          );
        }
        else if (data['category'] == "admin") {
          Fluttertoast.showToast(
            msg: "Login Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminPage()),
          );
        }

      } 
      else 
      {
        Fluttertoast.showToast(
            msg: "Invalid email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
            );
      }
  }
  bool passwordVisible=false;
  @override
  void initState()
  {
    super.initState();
    passwordVisible=true;
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold
    (
      backgroundColor: Colors.white,
      appBar: AppBar
      (
        backgroundColor: Colors.white,
        title:Row
        (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
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
      body:SingleChildScrollView
      (
       child: Center
       (
          child:Container
          (
              decoration:BoxDecoration(color: Colors.white, 
              borderRadius: BorderRadius.circular(20),             
              boxShadow:[
              BoxShadow( color: Colors.black26,
              blurRadius: 7,
              spreadRadius: 6,
              offset: Offset(0,5,),
              ),
              ],
              ),
              margin:EdgeInsets.all(25.0),
              child:Form
              (
                  key: _formkey,
                  child: Padding
                  (
                      padding: EdgeInsets.all(16.0),
                      child: Column
                      (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>
                          [
                            Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),  
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
                              obscureText: passwordVisible,
                              controller: passwordcontroller,
                              decoration: _inputDecoration().copyWith(
                              labelText: 'password',
                              fillColor: Colors.white,
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
                            SizedBox
                            (
                              width: 100.0,
                              height: 45.0,
                              child: ElevatedButton
                              (
                                  style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder
                                  (
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  ),
                                  onPressed: () 
                                  {
                                    if (_formkey.currentState!.validate()) 
                                    {
                                      login();
                                    }
                                  },                            
                                  child: Text('Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row
                            (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: 
                              [
                                Text("Don't have an account?"),
                                TextButton
                                (
                                  onPressed: () 
                                  {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignPage(),));
                                  },
                                  child:Text("Create an account", style: TextStyle(color: Colors.blue),)
                                ),
                              ],
                            ),
                          ],                      
                      ),
                  ),
              ),
          ),
        ),
      ),  
    ); 
  }
}

