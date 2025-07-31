import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:http/http.dart' as http;

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

  void sign() async{
    var url = Uri.parse('http://192.168.86.9/database.php'); // Replace with your actual PHP URL
    var response = await http.post(url, body: {
      'sign': 'true', // this will trigger isset($_POST['sign'])
      // Add more fields if needed, like 'email', 'password', etc.
    });
    if (response.statusCode == 200) 
    {
      print('Signup triggered successfully');
      print('Response: ${response.body}');
    } 
    else
    {
      print('Failed with status: ${response.statusCode}');
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: 
          [
            Image.asset('assets/logo.png',
            height:70,),
            RichText(text:TextSpan
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
                      Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
                      Text("Create an account"),
                      TextFormField
                      (
                                controller: namecontroller,
                                decoration: InputDecoration(labelText: 'username'),
                                validator: (value) {
                                if(value == null || value.isEmpty)
                                {
                                  return 'Name is required';
                                }
                                return null;
                                },
                      ),
                      SizedBox(height: 10),
                      TextFormField
                      (
                                controller: emailcontroller,
                                decoration: InputDecoration(labelText: 'email'),
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
                      SizedBox(height: 10),
                      TextFormField
                      (
                                controller: phonecontroller,
                                decoration: InputDecoration(labelText: 'mobile',),
                                validator: (value)
                                {
                                  if(value == null || value.isEmpty)
                                  {                    
                                    return 'Mobile number is required';
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
                                filled: true,),
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
                      SizedBox(height: 10),
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
                                filled: true,),
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
                      SizedBox(height: 10),
                      ElevatedButton
                      (
                          style: ElevatedButton.styleFrom
                          (
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          ),
                          ),
                          onPressed: sign,
                          child: Text('Register', style: TextStyle(color: Colors.white)),
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
                            child:Text("Login", style: TextStyle(color: Colors.blue),)
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