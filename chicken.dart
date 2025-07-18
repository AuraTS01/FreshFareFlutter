import 'package:flutter/material.dart';

class ChickenPage extends StatefulWidget {
  const ChickenPage({super.key, required String selecteditem});

  @override
  State<ChickenPage> createState() => _ChickenPageState();
}

class _ChickenPageState extends State<ChickenPage> {
   

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
               title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
           children: [
            // Image.asset('assets/logo.png',
            // height:50,),
            RichText(text: TextSpan(
            children: [
            TextSpan(text: 'Fresh',style:TextStyle(color:Colors.green,fontSize: 40,fontWeight: FontWeight.bold),),
            TextSpan(
              text: 'Fare',style: TextStyle(color:Colors.black,fontSize: 40,fontWeight: FontWeight.bold),),
            ],
        ),),
           ],
      ),),
    );
  }
}