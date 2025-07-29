import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freshfare/freshfare/chicken.dart';
import 'package:freshfare/freshfare/home.dart';
import 'package:freshfare/freshfare/login.dart';
import 'package:freshfare/freshfare/fish.dart';
import 'package:freshfare/freshfare/mutton.dart';
import 'package:freshfare/freshfare/prawns.dart';


class CartPage extends StatefulWidget 
{
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
{
  String selectedWeight = '1 kg';
  double pricePerKg = 190.0;
  double quantity = 1.0;

  double get unitMultiplier => selectedWeight == '1 Kg' ? 1.0 : 0.5;
  double get totalPrice => pricePerKg * quantity * unitMultiplier;

  final  searchcontroller = TextEditingController();
  void search()
  {
    String input = searchcontroller.text;
    if(input=="chicken"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => ChickenPage(selecteditem: '',),));
    }
    else if(input=="fish"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => FishPage(selecteditem: '',),),);
    }
    else if(input=="prawns"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => PrawnsPage(selecteditem: '',),),);
    }
    else if(input=="mutton"){
       Navigator.push(context, MaterialPageRoute(builder: (context) => MuttonPage(selecteditem: '',),),);
    }
    else if(input.isEmpty)
    {
      Fluttertoast.showToast
                      (
                        msg: "Please enter something to search",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
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
          mainAxisAlignment: MainAxisAlignment.center,
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
              title: const Text('Home'),
              onTap: () {          
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));               
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
              Row
                (
                  children: 
                  [
                    Expanded
                    (
                      child: TextField
                      (
                        controller:searchcontroller,
                        decoration: InputDecoration
                        (
                          hintText: 'what do you need?',
                          border: OutlineInputBorder(),
                          
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 120.0,
                      height: 45.0,
                    child:ElevatedButton
                    (
                      
                      style: ElevatedButton.styleFrom
                      (
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder
                        (
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      onPressed:search,
                      child: Text('search',style: TextStyle(color: Colors.white),),
                    ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                   [
                     Row
                     (
                      children:
                      [
                        DropdownButton<String>
                        (
                          value: selectedWeight,
                          items: ['1 kg','0.5 kg']
                          .map((weight) => DropdownMenuItem(value:weight,
                          child:Text(weight),
                          ))
                        
                          .toList(),
                          onChanged:(value){
                            setState((){
                              selectedWeight = value!;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Row
                        (
                          children: 
                          [
                            IconButton
                            (
                              icon: Icon(Icons.remove),
                              onPressed: ()
                              {
                                if(quantity > 1)
                                {
                                  setState(() {
                                    quantity--;
                                  });
                                }
                              },
                            ),
                            Text(quantity.toStringAsFixed(0)),
                            IconButton
                            (
                              icon: Icon(Icons.add),
                              onPressed: ()
                              {
                                setState((){
                                  quantity++;
                                });
                              }, 
                            ),
                          ],
                        ),

                      ],
                    ),  
                  ],
                ),
                Column(
                  children: 
                  [
                    Text('₹${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16),),
                    TextButton
                    (
                      onPressed: (){

                      },
                      child:Text('Remove',style: TextStyle(color: Colors.red))
                    ),
                  ],
                ),
                Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: 
                  [
                    Text('Total: ₹${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18,color: Colors.red),),
                  ],
                  ),
                  SizedBox(height: 10),
                  ElevatedButton
                  (
                    onPressed: (){}, 
                    style: ElevatedButton.styleFrom
                    (
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 40,vertical: 15),
                    ),
                    child: Text("PROCEED TO CHECKOUT",style: TextStyle(color: Colors.white)),
                  ),
            ],
           
          ),
        ),   
    ); 
  }
}
