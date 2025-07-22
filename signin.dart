import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _formkey = GlobalKey<FormState>();
  final  namecontroller = TextEditingController();
  final  emailcontroller = TextEditingController();
   final phonecontroller = TextEditingController();
  final  passwordcontroller =  TextEditingController();
  final  confrimcontroller = TextEditingController();
  String? nameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String? confrimError;

  // Future sign() async {
  //   var url = "http:// 192.168.86.9/freshfare_db/signup.php";
  //   var response = await http.post(url as Uri, body: {
  //     "username": namecontroller.text,
  //     "email": emailcontroller.text,
  //     "mobile": phonecontroller.text,
  //     "password": passwordcontroller.text,
  //   });
  //   var data = json.decode(response.body);
  //   if (data == "Error") {
  //         Fluttertoast.showToast(
  //         msg: "User allready exit! ",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         // webPosition: Center,
  //         timeInSecForIosWeb: 3,
  //         backgroundColor: Colors.red,
  //         textColor: Colors.white,
  //         fontSize: 16.0
  //         );
  //   } 
  //   else {
  //         Fluttertoast.showToast(
  //         msg: "Your account is created",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         // webPosition: Center,
  //         timeInSecForIosWeb: 3,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //         );
  //           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(),),);
  //   }
  // }
  
  // void sign() {
      // setState(() {
      //   nameError = null;
      //   emailError = null;
      //   phoneError = null;
      //   passwordError = null;
      //   confrimError = null;

      //   if(namecontroller.text.isEmpty){
      //     nameError = 'Name is required';
      //   }
      //   else  if(!RegExp(r'^[A-Za-z\s]+').hasMatch(namecontroller.text)){
      //       nameError = 'Enter valid name';
      //   }
        
      //   if(emailcontroller.text.isEmpty){
      //     emailError = 'Email is required';
      //   }
      //   else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailcontroller.text)){
      //     emailError = 'Enter valid email';
      //   }
      //   // ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(ac\.uk)$
      //   if(phonecontroller.text.isEmpty){
      //     phoneError = 'Mobile number is required';
      //   }
      //   else if(!RegExp( r'^[6-9]\d{9}$').hasMatch(phonecontroller.text)){
      //     phoneError = 'Enter valid mobile number';
      //   }
                  
      //   if(passwordcontroller.text.isEmpty){
      //     passwordError = 'Password is required';
      //   }
      //   else if(passwordcontroller.text.length < 6 ){
      //     passwordError = 'Minimum 6 characters or invlaid Password';
      //   }
      //   else if(passwordcontroller.text.length >= 15){
      //     passwordError = 'Maximum 15 characters or invlaid Password';
      //   }
      //   else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(passwordcontroller.text)){
      //     passwordError = 'Enter valid password';
      //   }
      //   // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
      //   if(confrimcontroller.text.isEmpty){
      //     confrimError = 'Confrim password is required';
      //   }
      //   else if(confrimcontroller.text != passwordcontroller.text){
      //     confrimError = 'Password does not match';
      //   }
       

      //   if (nameError == null && emailError == null && phoneError == null && passwordError == null && confrimError == null){
      //     Fluttertoast.showToast(
      //     msg: "Your account is created",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     // webPosition: Center,
      //     timeInSecForIosWeb: 3,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0,
      //   );
         
      //    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      //   }
      //    });
      
  // }

   bool passwordVisible=false;
   bool passwordVis=false;
   
     get validator => null;
     @override
    void initState(){
      super.initState();
      passwordVisible=true;
      passwordVis=true;
    }    
    
 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
                title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
           children: [
            Image.asset('assets/logo.png',
            height:70,),
            RichText(text: TextSpan(
            children: [
             TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 60,fontWeight: FontWeight.bold),),
            TextSpan(text: 'resh',style:TextStyle(color:Colors.black,fontSize: 60,fontWeight: FontWeight.bold),),
            TextSpan(text: 'F',style:TextStyle(color:Colors.green,fontSize: 60,fontWeight: FontWeight.bold),),
            TextSpan(text: 'are',style: TextStyle(color:Colors.black,fontSize: 60,fontWeight: FontWeight.bold),),
            ],
        ),),
           ],
      ),),
           body: Center(
            child : Container(
               decoration:BoxDecoration(color: Colors.white,
           
           boxShadow:[
             BoxShadow( color: Colors.black26,
          blurRadius: 5,
          spreadRadius: 4,
          offset: Offset( 0, 5,),
       ),
         ],),
              margin: EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
        // margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
               Text("Create an account"),
               TextFormField(
                controller: namecontroller,
                decoration: InputDecoration(labelText: 'username'),
                // errorText: nameError),
                validator: (value) {
                 if(value == null || value.isEmpty){
                    return 'Name is required';
                     }
                //  else  if(!value.contains(r'^[A-Za-z\s]+')){
                //      return 'Enter valid name';
                //     }
                     return null;
                },
              ),
               SizedBox(height: 10),
              TextFormField(
             controller: emailcontroller,
            decoration: InputDecoration(labelText: 'email'),
            validator: (value) {
           if(value == null || value.isEmpty){
              return 'Email is required';
             }
            else if(!value.contains('@')){
                 return 'Enter valid email';
                }
              return null;
            },
         ),
              SizedBox(height: 10),
              TextFormField(
                controller: phonecontroller,
                decoration: InputDecoration(labelText: 'mobile',),
                // errorText: phoneError
               validator: (value) {
                 if(value == null || value.isEmpty){
                    return 'Mobile number is required';
                     }
                // else  if(!value.contains(r'^[6-9]\d{9}$')){
                //      return 'Enter valid mobile number';
                //     }
                     return null;
                },
                
              ),
              SizedBox(height: 10),
              TextFormField(
                 obscureText: passwordVisible,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: 'password',
                  //  errorText: passwordError,
                suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
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
                  validator : (value){
                    if(value == null || value.isEmpty){
                      return 'Password is required';
                    }
                    else if(value.length < 6){
                      return 'Minimum 6 characters or invlaid Password';
                    }   
                    else if(value.length >= 15){
                      return 'Miaximum 15 characters or invlaid Password';
                    }  
                  //  else  if(!value.contains(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')){
                  //     return 'Enter a valid password';
                  //   }
                    return null;
                },
                  // keyboardType: TextInputType.visiblePassword,
                  // textInputAction: TextInputAction.done,      
        ),
               SizedBox(height: 10),
              TextFormField(
                 obscureText: passwordVis,
                controller: confrimcontroller,
                decoration: InputDecoration(labelText: 'confrim password',
                // errorText: confrimError,
                 suffixIcon: IconButton(
                      icon: Icon(passwordVis
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVis = !passwordVis;
                          },
                        );
                      },
                    ),
                    alignLabelWithHint: false,
                    filled: true,),
                      validator : (value){
                    if(value == null || value.isEmpty){
                      return 'Confrim password is required';
                    }
                    else if(value != passwordcontroller.text){
                      return 'Password does not match';
                    }   
                    return null;
                },
            
              ),
               SizedBox(height: 10),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
               shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
               ),
              ),
                onPressed:(){
                  if(_formkey.currentState!.validate()){
                    _formkey.currentState!.save();
                     Fluttertoast.showToast(
                     msg: "Your account is created",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.CENTER,
                    // webPosition: Center,
                     timeInSecForIosWeb: 3,
                     backgroundColor: Colors.green,
                     textColor: Colors.white,
                     fontSize: 16.0,
                     );
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                  }
                },
                child: Text('Sign Up',style: TextStyle(color: Colors.white),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
               Text("Already have an account? "),
               TextButton(
            onPressed: () {
              
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
            },
            child:Text("Login", style: TextStyle(color: Colors.blue),)
            ),],),
            ],
          ),
        ),
      ),
           ),),
    );
    }
}