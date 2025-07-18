import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
   final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController passwordcontroller =  TextEditingController();
  final TextEditingController confrimcontroller = TextEditingController();
  String? nameError;
  String? emailError;
  String? phoneError;
  String? passwordError;
  String? confrimError;
  
  void sign() {
      setState(() {
        nameError = null;
        emailError = null;
        phoneError = null;
        passwordError = null;
        confrimError = null;

        if(namecontroller.text.isEmpty){
          nameError = 'Name is required';
        }
        else  if(!RegExp(r'^[A-Za-z\s]+').hasMatch(namecontroller.text)){
            nameError = 'Enter valid name';
        }
        
        if(emailcontroller.text.isEmpty){
          emailError = 'Email is required';
        }
        else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailcontroller.text)){
          emailError = 'Enter valid email';
        }
        // ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(ac\.uk)$
        if(phonecontroller.text.isEmpty){
          phoneError = 'Mobile number is required';
        }
        else if(!RegExp( r'^[6-9]\d{9}$').hasMatch(phonecontroller.text)){
          phoneError = 'Enter valid mobile number';
        }
                  
        if(passwordcontroller.text.isEmpty){
          passwordError = 'Password is required';
        }
        else if(passwordcontroller.text.length < 6 ){
          passwordError = 'Minimum 6 characters or invlaid Password';
        }
        else if(passwordcontroller.text.length >= 15){
          passwordError = 'Maximum 15 characters or invlaid Password';
        }
        else if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(passwordcontroller.text)){
          passwordError = 'Enter valid password';
        }
        // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'
        if(confrimcontroller.text.isEmpty){
          confrimError = 'Confrim password is required';
        }
        else if(confrimcontroller.text != passwordcontroller.text){
          confrimError = 'Password does not match';
        }
       

        if (nameError == null && emailError == null && phoneError == null && passwordError == null && confrimError == null){
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
         });
      
  }
   bool passwordVisible=false;
   bool passwordVis=false;
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
            // Image.asset('assets/logo.png',
            // height:70,),
            RichText(text: TextSpan(
            children: [
            TextSpan(text: 'Fresh',style:TextStyle(color:Colors.green,fontSize: 60,fontWeight: FontWeight.bold),),
            TextSpan(
              text: 'Fare',style: TextStyle(color:Colors.black,fontSize: 60,fontWeight: FontWeight.bold),),
            ],
        ),),
           ],
      ),),
           body: Center(
            child: Card(
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
               Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40)),
               Text("Create an account"),
               TextField(
                controller: namecontroller,
                decoration: InputDecoration(labelText: 'Full Name',
                errorText: nameError),
                
              ),
               SizedBox(height: 10),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(labelText: 'Email',
                errorText: emailError),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phonecontroller,
                decoration: InputDecoration(labelText: 'Mobile number',
                errorText: phoneError),
                
              ),
              SizedBox(height: 10),
              TextField(
                 obscureText: passwordVisible,
                controller: passwordcontroller,
                decoration: InputDecoration(
                  labelText: 'Password', errorText: passwordError,
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
                  // keyboardType: TextInputType.visiblePassword,
                  // textInputAction: TextInputAction.done,
              
        ),
               SizedBox(height: 10),
              TextField(
                 obscureText: passwordVis,
                controller: confrimcontroller,
                decoration: InputDecoration(labelText: 'Confrim Password',
                errorText: confrimError,
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
            
              ),
               SizedBox(height: 10),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
               shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
               ),
              ),
                onPressed:sign,
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
           ),
    );
    }
}