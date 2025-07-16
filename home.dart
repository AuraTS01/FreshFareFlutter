import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> categories = ['Chicken','Mutton','Fish','Prawns'];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
               title:Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
           children: [
            Image.asset('assets/logo.png',
            height:50,),
            RichText(text: TextSpan(
            children: [
            TextSpan(text: 'Fresh',style:TextStyle(color:Colors.green,fontSize: 40,fontWeight: FontWeight.bold),),
            TextSpan(
              text: 'Fare',style: TextStyle(color:Colors.black,fontSize: 40,fontWeight: FontWeight.bold),),
            ],
        ),),
           ],
      ),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical:8),
              color: Colors.green.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: categories
                .map((item) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(item,style: TextStyle(fontSize: 16)),
                ))
                .toList(),
              ), 
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: TextField(
                  decoration: InputDecoration(
                    hintText: 'what do you need?',
                    border: OutlineInputBorder(),
                  ),
                ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: (){},
                   child: Text('search'),
                   )
              ],
            )    ,
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.phone,color: Colors.green),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('+91 9865321478',style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('support 24/7 '),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 300,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo.png'),
              fit: BoxFit.cover,
              ),
              ),
            ),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
          ],
        ),
      ),
    );
  }
}