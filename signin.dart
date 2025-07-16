import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/login.dart';

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
        if(emailcontroller.text.isEmpty){
          emailError = 'Email is required';
        }
        else if(!RegExp(r'\S+@\S+\.\S+').hasMatch(emailcontroller.text)){
          emailError = 'Invalid email';
        }
        
        if(phonecontroller.text.isEmpty){
          phoneError = 'mobile number is required';
        }
        else if(!RegExp(r'^[0-9]{10}$').hasMatch(phonecontroller.text)){
          emailError = 'Invalid mobile number';
        }

        if(passwordcontroller.text.isEmpty){
          passwordError = 'Password is required';
        }
        else if(passwordcontroller.text.length < 6){
          passwordError = 'Minimum 6 characters or invlaid Password';
        }
        
         if(confrimcontroller.text.isEmpty){
          confrimError = 'Confrim password is required';
        }
        else if(confrimcontroller.text != passwordcontroller.text){
          confrimError = 'Password does not match';
        }


        if (nameError == null && emailError == null && phoneError == null && passwordError == null && confrimError == null){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Your account created')),);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('invalid')),);
        }
      });
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
                controller: passwordcontroller,
                decoration: InputDecoration(labelText: 'Password',
                errorText: passwordError),
                obscureText: true,
              ),
               SizedBox(height: 10),
              TextField(
                controller: confrimcontroller,
                decoration: InputDecoration(labelText: 'Confrim Password',
                errorText: passwordError),
                obscureText: true,
              ),
               SizedBox(height: 10),
              ElevatedButton(
                onPressed:sign,
                child: Text('Sign Up'),
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