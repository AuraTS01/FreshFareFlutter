import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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
  final  confrimcontroller = TextEditingController(); 

  
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
                    msg: "This user Already Exist!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
      }
    else if(data['status'] == "Success"){
        
      Fluttertoast.showToast(
          msg: "Registration Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.green,
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
    // simulate heavy work
    await Future.delayed(Duration(seconds: 2));
    print("Data fetched");
  }

  


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar:AppBar
      (
        automaticallyImplyLeading: false,
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
                                decoration: InputDecoration(labelText: 'username',
                                border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(0)))),
                                validator: (value) {
                                if(value == null || value.isEmpty)
                                {
                                  return 'Name is required';
                                }
                                return null;
                                },
                      ),
                      SizedBox(height: 20),
                      TextFormField
                      (
                                controller: emailcontroller,
                                decoration: InputDecoration(labelText: 'email',
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)))),
                                validator: (value)
                                {
                                  if(value == null || value.isEmpty)
                                  {
                                    return 'Email is required';
                                  }
                                  else if(!value.contains('@'))
                                  {
                                    return 'Enter valid email';
                                  }
                                  return null;
                                },
                      ),
                      SizedBox(height: 20),
                      TextFormField
                      (
                                controller: phonecontroller,
                                decoration: InputDecoration(labelText: 'mobile',
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)))),
                                validator: (value)
                                {
                                  if(value == null || value.isEmpty)
                                  {                    
                                    return 'Mobile number is required';
                                  }
                                  return null;
                                },   
                      ),
                      SizedBox(height: 20),
                      TextFormField
                      (
                                obscureText: passwordVisible,
                                controller: passwordcontroller,
                                decoration: InputDecoration(
                                labelText: 'password',
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
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)))
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
                                controller: confrimcontroller,
                                decoration: InputDecoration(
                                labelText: 'confrim password',
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
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(0)))
                                ),
                                validator : (value)
                                {
                                      if(value == null || value.isEmpty)
                                      {
                                        return 'Confrim password is required';
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
                          borderRadius: BorderRadius.circular(0),
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