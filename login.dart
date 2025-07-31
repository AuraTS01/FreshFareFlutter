import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/signin.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  bool passwordVisible=false;
  @override
  void initState()
  {
    super.initState();
    passwordVisible=true;
  }    

  @override
  Widget build(BuildContext context) {
    return  Scaffold
    (
      appBar: AppBar
      (
        automaticallyImplyLeading: false,
        title:Row
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
           children: 
            [
              Image.asset('assets/logo.png',
              height:70,),
              RichText(text: TextSpan
              (
                children: 
                [
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 60,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'resh',style:TextStyle(color:Colors.black,fontSize: 60,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 60,fontWeight: FontWeight.bold),),
                  TextSpan(text: 'are',style: TextStyle(color:Colors.black,fontSize: 60,fontWeight: FontWeight.bold),),
                ],
              ),
              ),
            ],
        ),
      ),
      body:Center
      (
       child: Container
       (
            decoration:BoxDecoration(color: Colors.white,             
            boxShadow:[
            BoxShadow( color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 4,
            offset: Offset(0,5,),
            ),
            ],
            ),
            margin:EdgeInsets.all(20.0),
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
                          Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
                          Text("Enter your username & password to login"),
                          TextFormField
                          (
                            controller: emailcontroller,
                            decoration: InputDecoration(labelText: 'Email',),                   
                            validator: (value) 
                            {
                              if(value == null || value.isEmpty)
                              {
                                return 'Email is required';
                              }
                              else if(!value.contains('@')){
                                return 'Enter valid email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField
                          (
                            obscureText: passwordVisible,
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                            labelText: 'Password',                              
                            suffixIcon: IconButton(
                                icon: Icon(passwordVisible? Icons.visibility:Icons.visibility_off),
                                onPressed: () 
                                  {
                                    setState
                                    (
                                      (){
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
                                else if(value.length < 6)
                                {
                                  return 'Minimum 6 characters or invlaid Password';
                                }   
                                else if(value.length >= 15)
                                {
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
                                  borderRadius: BorderRadius.circular(0),
                                ),
                                ),
                                onPressed:()
                                {
                                  if(_formkey.currentState!.validate())
                                  {
                                  _formkey.currentState!.save();
                                    Fluttertoast.showToast
                                    (
                                      msg: "Login Successfully",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
                                  }
                                },
                                child: Text('Login',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          Row
                          (
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: 
                            [
                              Text("Don't have an account? "),
                              TextButton
                              (
                                onPressed: () 
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignPage(),));
                                },
                                child:Text(" Create an account", style: TextStyle(color: Colors.blue),)
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

