import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   String selecteditem = 'All Items';
   List<String> items = ['Chicken','Mutton','Fish','Prawns'];
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              
              child:DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded:true,
                  value:selecteditem,
                  items: ['All Items', ...items].map((String value){
                    return DropdownMenuItem<String>(value: value,
                    child:Text(value,style: TextStyle(fontSize: 16,fontWeight:FontWeight.w500)),
                    );
                  }).toList(), onChanged:(newValue){
                    setState(() {
                      selecteditem = newValue! ;
                    });
                  },
                  ),
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
                 style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                 shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(0),
               ),
              ),
                  onPressed: (){},
                   child: Text('search',style: TextStyle(color: Colors.white),),
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
              decoration: BoxDecoration(
                color: Colors.green,
              image: DecorationImage(image: NetworkImage(""),
              fit: BoxFit.cover,
              ),
            ),      
            ),
          CarouselSlider(
              items: [
                
                //1st image slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                //2nd image slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("ADD IMAGE URL HERE"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                //3rd image slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("ADD IMAGE URL HERE"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                //4th image slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("ADD IMAGE URL HERE"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // 5th image slider
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage("ADD IMAGE URL HERE"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

          ],
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
          ),
        ],                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
         
        ),
      ),
    );
  }
}