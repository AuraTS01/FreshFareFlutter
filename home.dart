import 'package:flutter/material.dart';
import 'package:freshfare/freshfare/cart.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/prawns.dart';
import 'package:freshfare/freshfare/profile.dart';



class HomePage extends StatefulWidget 
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // String selecteditem = 'All Items';
  // List<String> items = ['Chicken','Mutton','Fish','Prawns'];

  String ? selecteditem;
  final items =['Chicken','Mutton','Fish','Prawns'];

  void navigate(String value)
  {
    if(value == 'Chicken'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => ChickenPage(selecteditem: '',),));
    }
    else if(value == 'Fish'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => FishPage(selecteditem: '',),),);
    }
    else if(value == 'Prawns'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => PrawnsPage(selecteditem: '',),),);
    }
    else if(value == 'Mutton'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => MuttonPage(selecteditem: '',),),);
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return  Scaffold
    (
       appBar: AppBar
       (
          title:Row
          (
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: 
            [
              Image.asset('assets/logo.png',
              height:60,),
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
       drawer:Drawer
       ( 
          child: ListView
          (                
            padding: EdgeInsets.zero,
            children: 
            [ 
              ListTile
              (
                leading: CircleAvatar
                (
                  backgroundColor: Color(0xffE6E6E6),
                  radius: 30,
                  child: Icon(Icons.person,color:Color(0xffCCCCCC),),
                ),
                title:Text('Hello'),                    
              ),
              SizedBox(height: 40),
              ListTile
              (                    
                title: const Text('My profile'),
                onTap: () {          
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));               
                },
              ),
              ListTile
              (
                title: const Text('My Cart'),
                onTap: () {   
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(),));                    
                },
              ),
              ListTile
              (
                title: const Text('Logout'),
                onTap: () {   
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));                    
                },
              ),
            ],
          ),
        ),
        body: Padding
        (
          padding: EdgeInsets.all(16.0),
          child: ListView
          (
            children: 
            [
              Container
              (
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration
                (
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButtonHideUnderline
                (
                  child: DropdownButton
                  (
                    value:selecteditem,
                    hint: Text("All Items"),
                    items: items.map((String value)
                    {
                      return DropdownMenuItem<String>
                      (
                        value: value,
                        child:Text(value,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500)),
                      );
                    }).toList(),
                    onChanged:(value)
                    {
                        if(value != null)
                        {
                          setState(() {
                          selecteditem = value ;
                          });
                        
                          navigate(value);
                        }
                        
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row
              (
                children: 
                [
                  // Expanded
                  // (
                  //   child: TextField
                  //   (
                  //     decoration: InputDecoration
                  //     (
                  //       hintText: 'what do you need?',
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(width: 10),
                  // ElevatedButton
                  // (
                  //   style: ElevatedButton.styleFrom
                  //   (
                  //     backgroundColor: Colors.green,
                  //     shape: RoundedRectangleBorder
                  //     (
                  //        borderRadius: BorderRadius.circular(0),
                  //     ),
                  //   ),
                  //   onPressed: ()
                  //   {
                  //   // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(selecteditem: '',),));
                  //   },
                  //   child: Text('search',style: TextStyle(color: Colors.white),),
                  // )
                ],
              ),
              SizedBox(height: 20),
              Row
              (
                children:
                [
                  Icon(Icons.phone,color: Colors.green),
                  SizedBox(width: 10),
                  Column
                  (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: 
                    [
                      Text('+91 8754364997',style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('support 24/7 '),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30),
              Column
              (
                children: 
                [
                  Text("Order  Products",style: TextStyle(
                  color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold, ),),
                  SizedBox(height: 5),
                  Container
                  (
                    width: 95,
                    height: 4,
                    color: Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 40),
              Container
              (
                height: 300,
                decoration: BoxDecoration
                (
                  image:DecorationImage
                  (
                    image: AssetImage('assets/prawns.png'),
                    fit: BoxFit.cover,
                  ),
                ),      
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("  Prawns \n ₹ 400.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ], 
              ),
              SizedBox(height: 40),
              Container
              (
                height: 300,
                decoration: BoxDecoration
                (
                  image:DecorationImage
                  (
                    image: AssetImage('assets/fish.png'),
                    fit: BoxFit.cover,
                  ),
                ),      
              ),
              SizedBox(height: 20),
              Row
              (              
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("    Fish  \n ₹ 200.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),  
                ],
              ),
              SizedBox(height: 40),
              Container
              (
                height: 300,
                decoration: BoxDecoration
                (
                  image:DecorationImage
                  (  
                    image: AssetImage('assets/chicken_flesh.png'),
                    fit: BoxFit.cover,
                  ),
                ),      
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Chicken_Flesh \n     ₹ 220.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
             SizedBox(height: 40),
             Container
             (             
                height: 300,
                decoration: BoxDecoration
                (
                  image:DecorationImage
                  (
                    image: AssetImage('assets/chicken_2.png'),
                    fit: BoxFit.cover,
                  ),
                ),      
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("  Chicken \n ₹ 260.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 40),
              Container
              (
                height: 300,
                decoration: BoxDecoration
                (         
                  image:DecorationImage
                  (
                    image: AssetImage('assets/chicken_withoutSkin.png'),
                    fit: BoxFit.cover,
                  ),
                ),      
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Chicken_withoutSkin \n        ₹ 300.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 40),
              Container
              (
                height: 300,
                decoration: BoxDecoration
                (     
                  image:DecorationImage
                  (
                    image: AssetImage('assets/Shrimp.png'),
                    fit: BoxFit.cover,
                  ),
                ),      
              ),
              SizedBox(height: 20),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Shrimp \n₹ 350.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 40),
              Container
              (
                height: 300,
                decoration: BoxDecoration
                (               
                  image:DecorationImage
                  (
                    image: AssetImage('assets/fresh_raw_mutton_leg.png'),
                    fit: BoxFit.cover,
                  ),
                ),      
              ),
             SizedBox(height: 20),
             Row
             (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                  Text("Mutton_Leg \n ₹ 800.00",style: TextStyle(
                    shadows: 
                    [
                      Shadow(
                          color: Colors.black,
                          offset: Offset(0, 1)
                          )
                    ],
                    color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                ], 
              ),
            //   Container
            //   (
            //     height: 300,
            //     decoration: BoxDecoration
            //     (               
            //       image:DecorationImage
            //       (
            //         image: AssetImage('assets/fresh_fish.png'),
            //         fit: BoxFit.cover,
            //       ),
            //     ),      
            //   ),
            //  SizedBox(height: 20),
            //  Row
            //  (
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>
            //     [
            //       Text("Fresh_Fish \n ₹ 800.00",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
            //     ], 
            //   ),
            ],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
          ),
        ),
    );
  }
}